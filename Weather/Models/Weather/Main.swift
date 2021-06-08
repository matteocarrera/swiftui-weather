//
//  Main.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import Foundation

struct Main: Hashable, Decodable {
    let temp: Double
    let feelsLike: Double
    let maxTemp: Double
    let minTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
    }
}
