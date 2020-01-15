//
//  Country.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let population: Int
    let currencies: [CurrencyInfo] // use .first to get the first item in this array.
    let flag: String // use urlSession
    let alpha2Code: String
    let capital: String
    
}
struct CurrencyInfo: Decodable {
    let code: String // this is the currency code to be compared to in the exchange API
    let symbol: String
    let name: String
}
