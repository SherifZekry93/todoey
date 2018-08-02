//
//  File.swift
//  todoey
//
//  Created by Sherif  Wagih on 8/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
import UserNotifications
class LocalPushManager:NSObject
{
    static var shared = LocalPushManager();
    let center = UNUserNotificationCenter.current();
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
    func sendLocalPush(in time: DateComponents,title: String, body:String){
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        //Trigger Push Notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: false)
        let request = UNNotificationRequest(identifier: "RemindWithToDoItem", content: content, trigger: trigger)
        center.add(request)
        {
            (error) in
            if error != nil
            {
                print("error");
            }
        }
    }
    func disableNotification()
    {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["RemindWithToDoItem"])
    }
    func enableNotification()
    {
       // let app: UIApplication = UIApplication.shared
    }
}





