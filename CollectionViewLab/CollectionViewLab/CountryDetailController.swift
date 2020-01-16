//
//  CountryDetailController.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class CountryDetailController: UIViewController {
    
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var capitalLabel: UILabel!
        @IBOutlet var populationLabel: UILabel!
        @IBOutlet weak var exchangeLabel: UILabel!
        
        var country: Country?
        //var exchange: ExchangeRate?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            updateUI()
        }
       
        func updateUI() {
            // let theExchange = exchange
             
            guard let country = country  else {
                fatalError("no country") }
            nameLabel.text = country.name
            capitalLabel.text = "Capital: \(country.capital)"
            populationLabel.text = "Population: \(country.population)"
            
//            let exchangeRate = theExchange.rates[country.currencies.first?.code ?? " "] ?? 0
//            let formatedRate = String(format: "%.0f", exchangeRate)
//            let currencyName = country.currencies.first?.name ?? " "
//
//            exchangeLabel.text = "1 US Dollar = \(formatedRate) \(currencyName)"
            
            
            imageView.getImage(with: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png") { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print("error with getting flag: \(appError)")
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                    
                }
            }
        
        }

    }


