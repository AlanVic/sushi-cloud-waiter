//
//  ViewController.swift
//  sushi-cloud-winter
//
//  Created by Alan Victor Paulino de Oliveira on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let plates = [Plates.init(withName: "Nigiri", andImage: nil), Plates.init(withName: "Wasabi", andImage: nil)]
        
        let facade = CloudKitFacade.init()
        facade.sendOrder(withPlates: plates, andTableNumber: "23", result: { (orders) in
            
            print(orders)
        }) { (error) in
            
            print(error)
        }
        
    }
}

