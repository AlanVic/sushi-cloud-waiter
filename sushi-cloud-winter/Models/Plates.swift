//
//  Plates.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation
import UIKit

class Plates {
    var image: UIImage?
    var name: String
    var selected: Bool
    
    init(withName name: String, andImage image: UIImage?, selected:Bool = false) {
        self.image = image
        self.name = name
        self.selected = selected
    }
}
