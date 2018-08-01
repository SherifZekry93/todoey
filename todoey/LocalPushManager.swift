//
//  LocalPushManager.swift
//  todoey
//
//  Created by Sherif  Wagih on 8/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
class LocalPushManager:NSObject
{
    static var shared = LocalPushManager();
    let center = UNUserNotificationCenter.current();
 
   
    // Create the trigger as a repeating event.
//    let trigger = UNCalendarNotificationTrigger(
//        dateMatching: dateComponents, repeats: true)
//
    
    
    func requestAuth()
    {
        center.requestAuthorization(options: [.alert]) {
            (granted, error) in
            if error == nil
            {
                print("permission granted")
            }
        }
        
    }
    //setup local push
    func sendLocalPush(in time: TimeInterval){
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "wake up", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Time TO Wakeup", arguments: nil)
        //Trigger Push Notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        center.add(request)
        {
            (error) in
            if error != nil
            {
                print("error");
            }
        }
    }
}
