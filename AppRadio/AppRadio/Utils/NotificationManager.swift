//
//  NotificationManager.swift
//  AppRadio
//
//  Created by Juan Crow Wasbhrum on 10/2/18.
//  Copyright © 2018 InnovaSystem. All rights reserved.
//

import Foundation
import UIKit.UIViewController
import UserNotifications

class NotificationManager{
    
    
    static func registerNotification(titulo: String, mensaje: String) -> Void {
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "AppRadio"
        content.subtitle = titulo
        content.body = mensaje
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    
    static func notificarError(titulo: String, mensaje: String, view: UIViewController) -> Void {
        let alert = UIAlertController(title: "Error de Reproduccion", message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        view.present(alert,animated: true,completion: nil)
    }
}
