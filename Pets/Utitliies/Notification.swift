//
//  Notifications.swift
//  Pets
//
//  Created by MZiO on 9/9/24.
//

import Foundation
import UserNotifications

struct Notification {
    
    static func requestAuthorization() {
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if !granted {
                print("Notification authorization denied")
            }
        }
    }
    
    static func schedule(
        identifier: String,
        title: String,
        body: String,
        targetDate: Date,
        daysBefore: Int,
        notificationTime: Date
    ) {
        let notificationContent = createNotificationContent(
            title: title,
            body: body
        )
        let triggerDate = createTriggerDate(
            targetDate: targetDate,
            daysBefore: daysBefore,
            notificationTime: notificationTime
        )
        let trigger = createTrigger(from: triggerDate)
        
        let newRequest = UNNotificationRequest(
            identifier: identifier,
            content: notificationContent,
            trigger: trigger
        )
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getPendingNotificationRequests { requests in
            if let _ = requests.first(where: { $0.identifier == identifier }) {
                notificationCenter.removePendingNotificationRequests(
                    withIdentifiers: [identifier]
                )
                
                print("The notification with identifier \(identifier) was removed.")
            } else {
                print("There wasn't a pending notification with identifier \(identifier).")
            }
            
            notificationCenter.add(newRequest) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification with identifier \(identifier) scheduled successfully.")
                }
            }
        }
    }
    
    static func removePendingNotifications(for identifier: String) {

        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getPendingNotificationRequests { requests in
            if let _ = requests.first(where: { $0.identifier == identifier }) {
                notificationCenter.removePendingNotificationRequests(
                    withIdentifiers: [identifier]
                )
                
                print("The notification with identifier \(identifier) was removed.")
            } else {
                print("There wasn't a pending notification with identifier \(identifier).")
            }
        }
    }
    
    static private func createTriggerDate(
        targetDate: Date,
        daysBefore: Int,
        notificationTime: Date
    ) -> Date {
        
        let calendar = Calendar.current
        
        var triggerDate = calendar.date(
            byAdding: .day,
            value: -daysBefore,
            to: targetDate
        )!
        
        let timeComponents = calendar.dateComponents(
            [.hour, .minute],
            from: notificationTime
        )
        
        if let hour = timeComponents.hour, let minute = timeComponents.minute {
            triggerDate = calendar.date(
                bySettingHour: hour,
                minute: minute,
                second: 0,
                of: triggerDate
            )!
        }
        
        return triggerDate
    }
    
    static func createTrigger(
        from date: Date
    ) -> UNCalendarNotificationTrigger {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )
        
        return UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )
    }
    
    static func createNotificationContent(
        title: String,
        body: String
    ) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        return content
    }
}
