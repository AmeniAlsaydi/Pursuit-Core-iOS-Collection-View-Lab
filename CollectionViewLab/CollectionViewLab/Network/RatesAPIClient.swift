//
//  RatesAPIClient.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper

struct RatesAPIClient {
    
   static func getRates(completion: @escaping (Result<ExchangeRate, AppError>)-> ()) {
        
        let endpoint = "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let rates = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    completion(.success(rates))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
    }

    
}
