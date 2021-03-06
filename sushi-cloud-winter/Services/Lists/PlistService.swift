//
//  PlistService.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class PlistService {
    
    //busca os pratos na plist 'plates'
    var plates: [Plates] = {
        var plates: [Plates] = []
        if let path = Bundle.main.path(forPlist: "plates"),
        
        //a plist é um array de dicionarios
        let platesArray = NSArray.init(contentsOfFile: path) as? [[String: String]]{
            
            for plateDescription in platesArray {
                
                var plateImage: UIImage? = nil
                if let plateImageName = plateDescription["image"] {
                    plateImage = UIImage.init(named: plateImageName)
                }
                
                if let plateName = plateDescription["name"] {
                    let plate = Plates.init(withName: plateName, andImage: plateImage, selected: false)
                    plates.append(plate)
                }
            }
            
        }
        return plates
    }()
}
