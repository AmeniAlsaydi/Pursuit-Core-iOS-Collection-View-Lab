//
//  CollectionViewLabTests.swift
//  CollectionViewLabTests
//
//  Created by Amy Alsaydi on 1/16/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import XCTest
@testable import CollectionViewLab

class CollectionViewLabTests: XCTestCase {
    

    func testModel() {
         let data = """
{
  "success":true,
  "timestamp":1579148105,
  "base":"EUR",
  "date":"2020-01-16",
  "rates":{
    "AED":4.096766,
    "AFN":86.835871,
    "ALL":122.014194,
    "AMD":533.974613
  }
}
""".data(using: .utf8)!
        
        let expected = 4
        
        let rates = try! JSONDecoder().decode(ExchangeRate.self, from: data)
        XCTAssertEqual(rates.rates.count, expected)
        
        
    }

    func testRatesApiClient() {
        // arrange
        // let code = "AED"
        let expectedCount = 169 //4.096766
        let exp = XCTestExpectation(description: "rates found")
        
        // act
        
        RatesAPIClient.getRates { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let rate):
                let exchangeRates = rate.rates
                
                 // assert
                
                XCTAssertEqual(exchangeRates.count , expectedCount)
                exp.fulfill()
                
            }
        }
        
     wait(for:[exp], timeout: 5.0)
        
       
    }

}

// 168
