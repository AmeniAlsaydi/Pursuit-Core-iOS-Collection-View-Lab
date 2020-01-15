//
//  CountryCollectionViewCell.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

import ImageKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    func configureCell(country: Country) {
        
        countryNameLabel.text = country.name
        flagImageView.getImage(with: country.flag) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error with getting flag: \(appError)")
            case .success(let image):
                self?.flagImageView.image = image
            }
        }
    }
}
