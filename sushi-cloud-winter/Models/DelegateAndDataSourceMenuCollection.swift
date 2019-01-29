//
//  DelegateAndDataSourceMenuCollection.swift
//  sushi-cloud-winter
//
//  Created by Alan Victor Paulino de Oliveira on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit

class DelegateAndDataSourceMenuCollection: NSObject,UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var plates = PlistService().plates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuCollectionViewCell
        
        cell.plate = plates[indexPath.item]
        cell.loadCell()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell{
//            cell.isSelected = !cell.isSelected
            cell.selectedCheckbox()
        }
    }
    

    
    
    
}
