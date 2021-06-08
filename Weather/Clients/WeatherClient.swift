//
//  WeatherService.swift
//  Weather
//
//  Created by Владимир Макаров on 01.06.2021.
//

import Foundation

/*
    You can easily generate your own key on openweathermap.org
 */
private let key = "72f4694fc6cad83cdf15d55fb9c3c74e"

enum WeatherClientError: Error {
    case wrongUrl
    case noData
}

protocol WeatherClient {
    func getWeatherInfo(city: String, completion: @escaping (Result<WeatherInfo, Error>) -> Void)
}

class WeatherClientImpl: WeatherClient {
    func getWeatherInfo(city: String, completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)&units=metric") else {
            completion(.failure(WeatherClientError.wrongUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(WeatherClientError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(WeatherInfo.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
