//
//  CountryCollectionViewCell.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    func configureCell(country: Country) {
        
        countryNameLabel.text = country.name
        countryNameLabel.font = UIFont.boldSystemFont(ofSize: countryNameLabel.font.pointSize)
        let capital = (country.capital == "") ? "N/A" : country.capital
        capitalLabel.text = "Capital: \(capital)"
        populationLabel.text = "Population: \(country.population.description)"
        
        flagImageView.getImage(with: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error with getting flag: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImageView.image = image
                }
                
            }
        }
    }
}
