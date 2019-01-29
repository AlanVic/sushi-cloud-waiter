//
//  Array+toPlateArray.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation

extension Array where Element: Plates {
    func plateString() -> String {
        return self.reduce("") { (currentContent, plate) -> String in
            return "\(currentContent), \(plate.name)"
        }
    }
}
