//
//  ContentView.swift
//  Weather
//
//  Created by Владимир Макаров on 31.05.2021.
//

import SwiftUI

struct WeatherListView: View {
    
    private let weatherClient = WeatherClientImpl()
    @State private var cities = [String]()
    @State private var weatherInfoList = [WeatherInfo]()
    
    var body: some View {
        NavigationView {
            List(weatherInfoList, id: \.self) { weatherInfo in
                NavigationLink(destination: WeatherDetailView(weatherInfo: weatherInfo)) {
                    WeatherRow(weatherInfo: weatherInfo)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Weather List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CountryListView(cities: $cities)) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        getWeatherInfoList()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .onAppear {
            getWeatherInfoList()
        }
    }
    
    private func getWeatherInfoList() {
        weatherInfoList.removeAll()
        cities.forEach { city in
            weatherClient.getWeatherInfo(city: city) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weatherInfo):
                        self.weatherInfoList.append(weatherInfo)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
            .previewDevice("iPhone 11")
    }
}
