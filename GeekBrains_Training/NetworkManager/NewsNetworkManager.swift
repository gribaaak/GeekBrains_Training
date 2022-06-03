//
//  NewsNetworkManager.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 10.05.2022.
//

import Foundation

class NewsNetworkManager: NetworkManagerProtocol {
    func news(completion: @escaping (News) -> ()) {
        //let formattedCity = city.replacingOccurrences(of: " ", with: "+")
        let API_URL = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=\(NetworkProperties.API_KEY)"

        guard let url = URL(string: API_URL) else {
            fatalError()
        }
                     
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data else { return }

            do {
                let currentWeather = try JSONDecoder().decode(News.self, from: data)
                completion(currentWeather)
            } catch {
                 print(error)
            }

        }.resume()
    }
}

