//
//  MenuViewController.swift
//  sushi-cloud-winter
//
//  Created by Alan Victor Paulino de Oliveira on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIView!
    @IBOutlet weak var layoutCollectionView: UICollectionViewFlowLayout!
    
    var delegateAndDataSourceMenuCollection = DelegateAndDataSourceMenuCollection()
    var tableSelected:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = delegateAndDataSourceMenuCollection
        menuCollectionView.dataSource = delegateAndDataSourceMenuCollection
        
        let tapSaveButton = UITapGestureRecognizer(target: self, action: #selector(tapInSaveButton))

        saveButton.addGestureRecognizer(tapSaveButton)
        
        menuCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }

    func setupCollectionView(){
        layoutCollectionView.minimumInteritemSpacing = 8
        layoutCollectionView.minimumLineSpacing = 8
        let widthCell = (self.menuCollectionView.bounds.width / 2) - 8
        let heightCell = widthCell
        layoutCollectionView.itemSize = CGSize(width: widthCell, height: heightCell)
    }

    func showError() {
        let alert = UIAlertController(title: "Error", message: "Could not save", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func sucessAlert() {
        let alert = UIAlertController(title: "Otimo", message: "You saved a order", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tapInSaveButton(){
        let plates = delegateAndDataSourceMenuCollection.plates.filter { (plate) -> Bool in
            return plate.selected
        }
        
        CloudKitFacade.init().sendOrder(withPlates: plates, andTableNumber: self.tableSelected, result: { (orders) in
            
            DispatchQueue.main.async {
                self.sucessAlert()
            }
            
            
        }) { (error) in
            DispatchQueue.main.async {
                self.showError()
            }
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
//extension MenuViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.view.bounds.width / 2
//
//        return CGSize(width: width, height: width)
//    }
//}
