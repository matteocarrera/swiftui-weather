//
//  CountriesResponse.swift
//  Weather
//
//  Created by Владимир Макаров on 02.06.2021.
//

import Foundation

struct CountriesResponse: Hashable, Decodable {
    let error: Bool
    let msg: String
    let data: [Country]
}
