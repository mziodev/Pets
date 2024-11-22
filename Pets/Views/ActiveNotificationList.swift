//
//  ActiveNotificationList.swift
//  Pets
//
//  Created by MZiO on 22/11/24.
//

import UserNotifications
import SwiftUI

struct ActiveNotificationList: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var activeNotifications: [UNNotificationRequest] = []
    
    var body: some View {
        NavigationStack {
            List(activeNotifications, id: \.identifier) { notification in
                Section("Active notifications") {
                    ActiveNotificationListRow(notification: notification)
                }
            }
            .navigationTitle("Notifications center")
            .overlay {
                if activeNotifications.isEmpty {
                    ActiveNotificationsListEmpty()
                }
            }
            .onAppear(perform: loadActiveNotifications)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK", action: dismissView)
                }
            }
        }
    }
    
    private func loadActiveNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            self.activeNotifications = notifications
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

#Preview {
    ActiveNotificationList()
}

struct ActiveNotificationListRow: View {
    let notification: UNNotificationRequest
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(notification.content.title)
                .font(.headline)
            
            Text(notification.content.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let trigger =  notification.trigger as? UNCalendarNotificationTrigger {
                let date = Date().addingTimeInterval(
                    trigger.nextTriggerDate()!.timeIntervalSinceNow
                )
                
                Text("Scheduled for: \(date.monthDayYearTime)")
                    .font(.caption)
                    .foregroundStyle(.petsCelestialBlue)
            }
        }
    }
}

struct ActiveNotificationsListEmpty: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "bell.slash")
                .font(.largeTitle)
                .foregroundStyle(.petsCelestialBlue)
            
            Text("No active notifications yet.")
                .foregroundStyle(.secondary)
        }
    }
}
