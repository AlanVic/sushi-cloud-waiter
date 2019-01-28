//
//  Users.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation
import CloudKit

struct Users: CloudObject {
    
    var recordID: CKRecord.ID?
    var name: String?
    
    init() {
        
    }
    
    init(ckRecord: CKRecord) {
        self.name = ckRecord["name"]
        self.recordID = ckRecord.recordID
    }
    
    init(withName name: String) {
        self.name = name
    }
}
