//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import SwiftUI

struct WeatherDetailView: View {
    let weatherInfo: WeatherInfo

    var body: some View {
        List {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                        .frame(height: 20)
                    Text(weatherInfo.city)
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                    Text(weatherInfo.weather[0].description)
                        .font(.system(size: 20))
                    Text(String(format: "%.0f°C", weatherInfo.main.temp))
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                    Spacer()
                        .frame(height: 20)
                }
                Spacer()
            }
            
            WeatherInfoRow(description: "Sunrise", value: getTimeFromUnix(unixTime: weatherInfo.sys.sunrise))
            WeatherInfoRow(description: "Sunset", value: getTimeFromUnix(unixTime: weatherInfo.sys.sunset))
            WeatherInfoRow(description: "Wind Speed", value: String(format: "%.1f m/s", weatherInfo.wind.speed))
            WeatherInfoRow(description: "Max Temperature", value: String(format: "%.0f°C", weatherInfo.main.maxTemp))
            WeatherInfoRow(description: "Min Temperature", value: String(format: "%.0f°C", weatherInfo.main.minTemp))
            WeatherInfoRow(description: "Feels Like", value: String(format: "%.0f°C", weatherInfo.main.feelsLike))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Weather", displayMode: .inline)
    }
    
    private func getTimeFromUnix(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherInfo: WeatherInfo(
            weather: [Weather(description: "clear sky")],
            main: Main(temp: 30, feelsLike: 31, maxTemp: 35, minTemp: 28),
            wind: Wind(speed: 1.5),
            sys: Sys(sunrise: 123123, sunset: 123123),
            city: "Los-Angeles"
        ))
            .previewDevice("iPhone 11")
    }
}
