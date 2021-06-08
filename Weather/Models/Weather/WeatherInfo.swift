//
//  WeatherInfo.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import Foundation

struct WeatherInfo: Hashable, Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    
    let city: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weather = try container.decode([Weather].self, forKey: .weather)
        main = try container.decode(Main.self, forKey: .main)
        wind = try container.decode(Wind.self, forKey: .wind)
        sys = try container.decode(Sys.self, forKey: .sys)
        city = try container.decode(String.self, forKey: .city)
    }
    
    init(weather: [Weather], main: Main, wind: Wind, sys: Sys, city: String) {
        self.weather = weather
        self.main = main
        self.wind = wind
        self.sys = sys
        self.city = city
    }
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case sys
        case city = "name"
    }
}
