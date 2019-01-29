//
//  TableManagerViewController.swift
//  sushi-cloud-winter
//
//  Created by Matheus Damasceno on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit

class TableManagerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var tableIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let nib = UINib.init(nibName: "TableManagerCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
}

extension TableManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}

extension TableManagerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuViewController = MenuViewController()
        
        menuViewController.title = "Mesa \(indexPath.row + 1)"
        
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }
}

extension TableManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TableManagerCollectionViewCell
        
        cell.tableLabel.text = String(self.tableIndex)
        tableIndex = tableIndex + 1
        
        return cell
    }
    
    
}
