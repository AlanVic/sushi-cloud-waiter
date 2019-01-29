//
//  Order.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation
import CloudKit

struct Orders: CloudObject {
    
    var recordID: CKRecord.ID?
    var orderDescription: String?
    var tableNumber: String?
    var waiter: CKRecord.Reference?
    
    init() {
        
    }
    
    init(ckRecord: CKRecord) {
        self.orderDescription = ckRecord["orderDescription"]
        self.tableNumber = ckRecord["table"]
        self.waiter = ckRecord["waiter"]
        self.recordID = ckRecord.recordID
    }
    
    init(withOrderDescription orderDescription: String, andTable table: String) {
        self.orderDescription = orderDescription
        self.tableNumber = table
    }
    
    init(withPlates plates: [Plates], andTable table: String) {
        self.orderDescription = plates.plateString()
        self.tableNumber = table
    }
}
