//
//  NotificationService.swift
//  sushi-cloud-winter
//
//  Created by Elias Paulino on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import CloudKit

class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationService.init()
    
    var delegate: NotificationServiceDelegate?
    
    /// Pergunta ao usuario sobre a permissao para notificacoes remotas
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.registerForRemoteNotifications()
            }
        }
    }
    
    /// verifica autorização para envio de notificacoes remotas e as registra
    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    /// Chamado no didReceiveRemoteNotification do AppDelegate
    ///
    /// - Parameter userInfo: user info da notificacao
    func didReceivBackgroundNotification(userInfo: [AnyHashable : Any]) {
        
        print(userInfo)
    }
    
    
    /// Chamado no didRegisterForRemoteNotificationsWithDeviceToken do Appdelegate
    ///
    /// - Parameter deviceToken: o token de push
    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
        self.subscribeToSubscription()
    }
    
    
    /// Verifica se o userReference já foi pego, se não, ele é pego. Depois de obter o userReference, usa-o para subscrever a subscription
    func subscribeToSubscription() {
        if let userReference = CloudKitService.shared.userReference {
            
            let orderSubscription = formatOrderSubscription(userReference: userReference)
            saveSubscriptionToCloud(subscription: orderSubscription)
        } else {
            CloudKitService.shared.discoverUserId(sucessCase: { (userReference) in
                
                let orderSubscription = self.formatOrderSubscription(userReference: userReference)
                self.saveSubscriptionToCloud(subscription: orderSubscription)
            }) { (error) in
                print(error)
            }
        }
    }
    
    
    func saveSubscriptionToCloud(subscription: CKQuerySubscription) {
        CloudKitService.shared.container.publicCloudDatabase.save(subscription) { (_, error) in
            
            print(error)
        }
    }
    
    
    /// Cria a subscription e a notification info para uma notificação silenciosa
    ///
    /// - Parameter userReference: o user reference, que indica que garçom fez o pedido
    /// - Returns: a subscription
    func formatOrderSubscription(userReference: CKRecord.Reference) -> CKQuerySubscription {
        
        let predicate = NSPredicate.init(format: "waiter == %@", userReference)
        
        let subscription = CKQuerySubscription.init(recordType: "Orders",
                                                    predicate: predicate,
                                                    subscriptionID: "OrderSub",
                                                    options: .firesOnRecordUpdate)
        
        let notification = CKSubscription.NotificationInfo.init()
        notification.alertBody = "Pedido Finalizado"
        notification.shouldBadge = true
        //notification.shouldSendContentAvailable = true
        
        subscription.notificationInfo = notification
        
        return subscription
    }
}
