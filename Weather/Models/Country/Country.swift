//
//  Country.swift
//  Weather
//
//  Created by Владимир Макаров on 02.06.2021.
//

import Foundation

struct Country: Hashable, Decodable {
    let name: String
    let cities: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "country"
        case cities = "cities"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cities = try container.decode([String].self, forKey: .cities)
        name = try container.decode(String.self, forKey: .name)
    }
}
