//
//  CountryAPIClient.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPIClient {
    
   static func getCountries(completion: @escaping (Result<[Country], AppError>)-> ()) {
        
        let endpoint = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        // make a request
        let request = URLRequest(url: url) // this is what is passed to URLSession in network helper
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            // result is either data or an error
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                 // use model to Parse data
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
    }

    
}
