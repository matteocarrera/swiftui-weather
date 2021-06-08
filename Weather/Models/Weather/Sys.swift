//
//  Sys.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import Foundation

struct Sys: Hashable, Decodable {
    let sunrise: Double
    let sunset: Double
}
