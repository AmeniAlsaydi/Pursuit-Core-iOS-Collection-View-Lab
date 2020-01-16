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
        collectionView.delegate = self
        getCountries()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CountryDetailController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("couldnt get detailVC or indexPath")
        }
        
        detailVC.country = countries[indexPath.row]
        //detailVC.exchange = exchanges
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // expecting a cg size which is a tuple of two values
        
        let interItemSpacing: CGFloat = 10 // space betweem items
        let maxWidth = UIScreen.main.bounds.size.width // device width
        
        let numberOfItems: CGFloat = 3 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // padding sround collectionview
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

