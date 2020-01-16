//
//  CountryDetailController.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class CountryDetailController: UIViewController {
    
    var country: Country?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryNameLabel.text = country?.name
    }
    

    

}
