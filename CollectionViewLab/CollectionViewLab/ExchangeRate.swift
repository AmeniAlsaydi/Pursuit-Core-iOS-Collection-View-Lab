//
//  ExchangeRate.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let rates: [String: Double]
    
    static func getRates() -> ExchangeRate {
        var rates: ExchangeRate
        
        guard let fileURL = Bundle.main.url(forResource: "ExchangeRates", withExtension: "json") else {
            fatalError("couldnt locate json data")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            rates = try JSONDecoder().decode(ExchangeRate.self, from: data)
        } catch {
            fatalError("failed to load from contents \(error)")
        }
        
        return rates
        
    }
}



