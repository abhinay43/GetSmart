//
//  LocalNotificationHelper.swift
//  DKBJournal
//
//  Created by Abhinay Maurya on 11/9/17.
//  Copyright © 2017 ONS Application Studio. All rights reserved.
//

import Foundation
import UserNotifications

final class LocalNotificationHelper:NSObject
{
    fileprivate static let twoWeekReminderNotification = "AfterTwoWeekNotification"
    fileprivate static let threeMonthsReminderNotification = "threeMonthsReminderNotification"
    
    fileprivate static let twoWeekReminderNotificationActionIdentifier = "RemindLater"
    fileprivate static let twoWeekReminderNotificationCategory = "TwoWeekCategory"
    fileprivate static let threeMonthsReminderNotificationCategory = "ThreeMonthsCategory"
    
    fileprivate static let SixWeekReminderAlert = "SixWeekReminderAlert"
    fileprivate static let SixWeekReminderDate = "SixWeekReminderDate"
    
    typealias NotificationExist = (_ requestSuccess:Bool) -> ()
}


extension LocalNotificationHelper
{
    static func scheduleNotificationForTwoWeekReminder()
    {
        if #available(iOS 10.0, *)
        {
            let date = Date().getADayAfter(xDay: 14)//Two weeks
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: .current, from: date)
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = GetSmartConstant.AppName
            content.body = "We are missing you!!"
            content.sound = UNNotificationSound.default()
            
            let request = UNNotificationRequest(identifier: twoWeekReminderNotification, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [twoWeekReminderNotification])
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
            }
        }
    }
    
    static func scheduleNotificationForThreeMonthsReminder()
    {
        if #available(iOS 10.0, *)
        {
            let date = Date().getADayAfter(xDay: 120)//Three months
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: .current, from: date)
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = GetSmartConstant.AppName
            content.body = "There are new articles for you"
            content.sound = UNNotificationSound.default()
            
            let request = UNNotificationRequest(identifier: threeMonthsReminderNotification, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [threeMonthsReminderNotification])
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
            }
        }
    }
    
    
    
    static func checkAuthoriation()
    {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            center.getNotificationSettings { (settings) in
                if(settings.authorizationStatus == .authorized){
                    scheduleNotificationForTwoWeekReminder()
                    removeSixWeekReminder()
                }else{
                    addSixWeekReminder()
                }
                
            }
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    static func removeSixWeekReminder()
    {
        let prefs = UserDefaults.standard
        if prefs.bool(forKey: SixWeekReminderAlert){
            prefs.set(false, forKey: SixWeekReminderAlert)
            prefs.removeObject(forKey: SixWeekReminderDate)
            prefs.synchronize()
        }
        
    }
    
    static func addSixWeekReminder()
    {
        let prefs = UserDefaults.standard
        if !prefs.bool(forKey: SixWeekReminderAlert)
        {
            prefs.set(true, forKey: SixWeekReminderAlert)
            prefs.set(Date(), forKey: SixWeekReminderDate)
            prefs.synchronize()
        }
        
    }
    
    static func showSixWeekReminderAlert() -> Bool
    {
        let prefs = UserDefaults.standard
        if prefs.bool(forKey: SixWeekReminderAlert)
        {
            let currentDate = Date()
            if let notificationDate = prefs.value(forKey: SixWeekReminderDate) as? Date{
                if currentDate >= notificationDate{
                    return true
                }
            }
            return false
        }
        return false
    }
    
    static func checkIfLocalNotificationExist(identifier:String, completionHandler:@escaping NotificationExist)
    {
        if #available(iOS 10.0, *)
        {
            let center = UNUserNotificationCenter.current()
            
            center.getPendingNotificationRequests { (notifications) in
                for item in notifications {
                    if item.identifier == identifier{
                        completionHandler(true)
                        break
                    }
                }
                completionHandler(false)
            }
        }
    }
}

//MARK:- Register Categories in UNUserNotificationCenter
extension LocalNotificationHelper
{
    static func registerTwoWeekReminderNotificationCategory()
    {
        if #available(iOS 10.0, *)
        {
            let action = UNNotificationAction(identifier: LocalNotificationHelper.twoWeekReminderNotificationActionIdentifier, title: "Remind me later", options: [])
            let category = UNNotificationCategory(identifier: LocalNotificationHelper.twoWeekReminderNotificationCategory, actions: [action], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
        }
    }
    
    
    static func registerThreeMonthsReminderNotificationCategory()
    {
        if #available(iOS 10.0, *)
        {
            let action_New = UNNotificationAction(identifier: LocalNotificationHelper.twoWeekReminderNotificationActionIdentifier, title: "New articles", options: [])
            
            let category = UNNotificationCategory(identifier: LocalNotificationHelper.threeMonthsReminderNotificationCategory, actions: [action_New], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
        }
    }
}

//MARK:- UNUserNotificationCenterDelegate
extension LocalNotificationHelper:UNUserNotificationCenterDelegate
{
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        if response.actionIdentifier == LocalNotificationHelper.twoWeekReminderNotificationActionIdentifier
        {
            LocalNotificationHelper.scheduleNotificationForTwoWeekReminder()
        }
        else if response.actionIdentifier == LocalNotificationHelper.threeMonthsReminderNotificationCategory
        {
            LocalNotificationHelper.scheduleNotificationForThreeMonthsReminder()
        }
    }
}
