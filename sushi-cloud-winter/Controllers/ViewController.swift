//
//  ViewController.swift
//  sushi-cloud-winter
//
//  Created by Alan Victor Paulino de Oliveira on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Orders.findBy(field: "tableNumber", .equalTo, "1", result: { (records: [CKRecord]?) in
//            if let firstrc = records?.first {
//                firstrc["orderDescription"] = "tete"
//
//                CloudKitService.shared.container.publicCloudDatabase.save(firstrc, completionHandler: { (record, error) in
//
//                    print("ok")
//                })
//            }
//        }) { (error) in
//
//            print(error)
//        }
        
        var or = Orders.init(withOrderDescription: "tralal2", andTable: "34")
        
        CloudKitService.shared.discoverUserId(sucessCase: { (reference) in
            or.waiter = reference
            
            or.save(result: { (orders) in
                
                print("ok")
            }) { (error) in
                print("ok")
            }
        }) { (error) in
            
        }
        
    }
}

