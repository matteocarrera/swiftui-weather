//
//  WeatherInfoRow.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import SwiftUI

struct WeatherInfoRow: View {
    let description: String
    let value: String
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Text(description)
                    .font(.system(size: 20))
                Spacer()
                Text(value)
                    .font(.system(size: 20))
            }
            Spacer()
                .frame(height: 20)
        }
    }
}

struct WeatherInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoRow(description: "Sunset", value: "123231")
            .previewLayout(.fixed(width: 300, height: 90))
    }
}
