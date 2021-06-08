//
//  ProductRow.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import SwiftUI

struct WeatherRow: View {
    var weatherInfo: WeatherInfo
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text(weatherInfo.city)
                    .fontWeight(.semibold)
                    .font(.system(size: 26))
                Spacer()
                Text(String(format: "%.0f°C", weatherInfo.main.temp))
                    .font(.system(size: 26))
            }
            Spacer()
                .frame(height: 20)
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(weatherInfo: WeatherInfo(
            weather: [Weather(description: "clear sky")],
            main: Main(temp: 30, feelsLike: 31, maxTemp: 35, minTemp: 28),
            wind: Wind(speed: 1.5),
            sys: Sys(sunrise: 123123, sunset: 123123),
            city: "Los-Angeles"
        ))
            .previewLayout(.fixed(width: 300, height: 90))
    }
}
