//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Amy Alsaydi on 1/14/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var largeFlageImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "united" {
        didSet {
            CountryAPIClient.getCountries(searchQuery: searchQuery) { (result) in
                switch result {
                case .failure(let appError):
                    print("appError: \(appError)")
                case .success(let countries):
                    DispatchQueue.main.async {
                        self.countries = countries
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeFlageImage.clipsToBounds = true
        largeFlageImage.layer.cornerRadius = largeFlageImage.frame.width/13


        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
        getCountries()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CountryDetailController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("couldnt get detailVC or indexPath")
        }
        
        detailVC.country = countries[indexPath.row]
        
    }
    
    private func getCountries() {
        CountryAPIClient.getCountries(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                print("apperror: \(appError)")
            case .success(let countries):
                self.countries = countries
            }
        }
        
    }
    
    func displayLargeFlag() {
        
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
        
        largeFlageImage.getImage(with: "https://www.countryflags.io/\(country.alpha2Code)/shiny/64.png") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error with getting flag: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.largeFlageImage.image = image
                }
                
            }
        }
        
        countryNameLabel.text = country.name

        
        
        return cell
    }
    
    
}
extension CountryListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // expecting a cg size which is a tuple of two values
        
        let interItemSpacing: CGFloat = 5 // space betweem items
        let maxWidth = UIScreen.main.bounds.size.width // device width
        
        let numberOfItems: CGFloat = 2 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth * 0.8 , height: itemWidth * 1.5)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // padding sround collectionview
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
        searchQuery = "united"
               return
           }
           searchQuery = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
}

