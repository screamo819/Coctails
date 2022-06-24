//
//  NetworkManager.swift
//  coctails
//
//  Created by AnnaEvgen on 07.06.2022.
//

import Foundation

class NetworkManager {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}

class NetworkDataFromJSON {
    
    let networkService = NetworkManager()
    
    func getData(urlString: String, response: @escaping (Coctails?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let coctails = try JSONDecoder().decode(Coctails.self, from: data)
                    response(coctails)
                } catch let error {
                    print("Failed to decode JSON", error)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
