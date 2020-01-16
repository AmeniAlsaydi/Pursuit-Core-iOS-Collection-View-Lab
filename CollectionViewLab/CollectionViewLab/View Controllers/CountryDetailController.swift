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
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            updateUI()
        }
    
    func getRate() {
        RatesAPIClient.getRates { (result) in
            switch result {
            case .failure(let appError):
                print("error with exchange: \(appError)")
            case .success(let rate):
                
                let exchangeRate = rate.rates[self.country?.currencies.first?.code ?? " "] ?? 0
                let formatedRate = String(format: "%.0f", exchangeRate)
                let currencyName = self.country?.currencies.first?.name ?? " "
                
                DispatchQueue.main.async {
                    self.exchangeLabel.text = "1 US Dollar = \(formatedRate) \(currencyName)"
                }
                
                
            }
        }
    }
       
        func updateUI() {
            
             
            guard let country = country else {
                fatalError("no country or exchange") }
            
            nameLabel.text = country.name
            capitalLabel.text = "Capital: \(country.capital)"
            populationLabel.text = "Population: \(country.population)"
            getRate()
        
            
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


