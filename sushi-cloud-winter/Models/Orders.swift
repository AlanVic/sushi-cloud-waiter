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
    var table: Int?
    var waiter: CKRecord.Reference?
    
    init() {
        
    }
    
    init(ckRecord: CKRecord) {
        self.orderDescription = ckRecord["orderDescription"]
        self.table = ckRecord["table"]
        self.table = ckRecord["waiter"]
        self.recordID = ckRecord.recordID
    }
    
    init(withOrderDescription orderDescription: String, andTable table: Int) {
        self.orderDescription = orderDescription
        self.table = table
    }
}
