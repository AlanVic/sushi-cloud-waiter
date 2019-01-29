//
//  CloudKitService.swift
//  AprendendoCloudkit
//
//  Created by Elias Paulino on 26/01/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitService {
    static let shared = CloudKitService.init()
    
    var userReference: CKRecord.Reference?
    
    var container: CKContainer = {
        return CKContainer.init(identifier: "iCloud.com.thalys.sushi-cloud")
    }()
    
    private init() {
        
    }
    
    /// Descobre o ID do usuario logado no iCloud
    ///
    /// - Parameters:
    ///   - container: o container
    ///   - sucessCase: caso de sucesso
    ///   - errorCase: caso de erro
    func discoverUserId(
        container: CKContainer = CloudKitService.shared.container,
        sucessCase: @escaping (CKRecord.Reference) -> (),
        errorCase: @escaping (Error?) -> ()) {
        
        container.fetchUserRecordID { (userId, error) in
            if let error = error {
                errorCase(error)
                return
            }
            
            if let authorId = userId {
                let userReference = CKRecord.Reference.init(recordID: authorId, action: .none)
                self.userReference = userReference
                
                sucessCase(userReference)
                
            } else {
                errorCase(nil)
            }
        }
    }
}
