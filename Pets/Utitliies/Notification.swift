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
        title: String,
        body: String,
        targetDate: Date,
        daysBefore: Int,
        notificationTime: Date
    ) {
        let triggerDate = createTriggerDate(
            targetDate: targetDate,
            daysBefore: daysBefore,
            notificationTime: notificationTime
        )
        
        let calendar = Calendar.current
        let triggerComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: triggerDate
        )
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerComponents,
            repeats: false
        )
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    static private func createTriggerDate(
        targetDate: Date,
        daysBefore: Int,
        notificationTime: Date
    ) -> Date {
        let calendar = Calendar.current
        
        var triggerDate = calendar.date(byAdding: .day, value: -daysBefore, to: targetDate)!
        
        let timeComponents = calendar.dateComponents([.hour, .minute], from: notificationTime)
        if let hour = timeComponents.hour, let minute = timeComponents.minute {
            triggerDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: triggerDate)!
        }
        
        return triggerDate
    }
}
