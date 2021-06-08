//
//  CountriesClient.swift
//  Weather
//
//  Created by Владимир Макаров on 02.06.2021.
//

import Foundation

enum CountriesClientError: Error {
    case wrongUrl
    case noData
}

protocol CountriesClient {
    func getAllCountries(completion: @escaping (Result<CountriesResponse, Error>) -> Void)
    func getCountryCities(countryName: String, completion: @escaping (Result<[String], Error>) -> Void)
}

class CountriesClientImpl: CountriesClient {
    func getAllCountries(completion: @escaping (Result<CountriesResponse, Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://countriesnow.space/api/v0.1/countries") else {
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
                let response = try decoder.decode(CountriesResponse.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func getCountryCities(countryName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://countriesnow.space/api/v0.1/countries/cities") else {
            completion(.failure(WeatherClientError.wrongUrl))
            return
        }

        let jsonData = try! JSONEncoder().encode(CountryRequest(country: countryName))
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.setValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(WeatherClientError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CountryResponse.self, from: data)
                completion(.success(response.data))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
