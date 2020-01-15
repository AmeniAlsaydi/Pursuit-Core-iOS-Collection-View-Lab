//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/14/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        getCountries()
    }
    
    private func getCountries() {
        CountryAPIClient.getCountries { (result) in
            switch result {
            case .failure(let appError):
                print("apperror: \(appError)")
            case .success(let countries):
                self.countries = countries
            }
        }
        
    }


}

extension CountryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("could not downcast to CountryCell")
        }
        
        let country = countries[indexPath.row]
        cell.configureCell(country: country)
        
        return cell
    }
    
    
}
extension CountryListViewController: UICollectionViewDelegateFlowLayout {
    
}

