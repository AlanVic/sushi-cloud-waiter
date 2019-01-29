//
//  CloudKitFacade.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation

struct CloudKitFacade {
    
    /// Cria um pedido e o envia para o banco publico do container padrao
    ///
    /// - Parameters:
    ///   - plates: os pratos que conpoem o pedido
    ///   - tableNumber: o numero da mesa
    ///   - result: completionde resultado
    ///   - errorCase: completion de erro
    func sendOrder(withPlates plates: [Plates],
                   andTableNumber tableNumber: String,
                   result: @escaping (Orders?) -> (),
                   errorCase: @escaping (Error?) -> ()) {
        
        var order = Orders.init(withPlates: plates, andTable: tableNumber)
        
        if let userReference = CloudKitService.shared.userReference {
            order.waiter = userReference
            order.save(result: result, errorCase: errorCase)
        } else {
            CloudKitService.shared.discoverUserId(sucessCase: { (userReference) in
                order.waiter = userReference
                order.save(result: result, errorCase: errorCase)
            }) { (error) in
                errorCase(error)
            }
        }
    }
    
}
