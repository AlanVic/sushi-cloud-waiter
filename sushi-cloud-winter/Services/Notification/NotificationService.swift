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
    func requestPushAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.getPushSettings()
            }
        }
    }
    
    /// verifica autorização para envio de notificacoes remotas e as registra
    func getPushSettings() {
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
    func receivedBackgroundNotification(userInfo: [AnyHashable : Any]) {
        
    }
    
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
        CKContainer.default().publicCloudDatabase.save(subscription) { (_, error) in
            print(error)
        }
    }
    
    func formatOrderSubscription(userReference: CKRecord.Reference) -> CKQuerySubscription {
        
        let predicate = NSPredicate.init(format: "waiter == %@", userReference)
        
        let subscription = CKQuerySubscription.init(recordType: "Order",
                                                    predicate: predicate,
                                                    subscriptionID: "OrderSub",
                                                    options: .firesOnRecordUpdate)
        
        let notification = CKSubscription.NotificationInfo.init()
        notification.alertBody = ""
        notification.shouldBadge = true
        notification.shouldSendContentAvailable = true
        
        subscription.notificationInfo = notification
        
        return subscription
    }
}
