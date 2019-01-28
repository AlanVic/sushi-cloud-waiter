//
//  Bundle+plistPath.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation

extension Bundle {
    func path(forPlist plistName: String) -> String? {
        return path(forResource: plistName, ofType: "plist")
    }
}
