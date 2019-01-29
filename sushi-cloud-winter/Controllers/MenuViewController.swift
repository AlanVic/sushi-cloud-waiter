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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapSaveButton = UITapGestureRecognizer(target: self, action: #selector(tapInSaveButton))

        saveButton.addGestureRecognizer(tapSaveButton)
        // Do any additional setup after loading the view.
    }


    @objc func tapInSaveButton(){
        print("Tap in save Button")
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
