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
    
    @State private var activeNotificationRequests: [UNNotificationRequest] = []
    
    var body: some View {
        NavigationStack {
            List(activeNotificationRequests, id: \.identifier) { request in
                Section("Upcoming Notifications") {
                    ActiveNotificationListRow(notification: request)
                }
            }
            .navigationTitle("Notifications center")
            .overlay {
                if activeNotificationRequests.isEmpty {
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
        UNUserNotificationCenter.current().getPendingNotificationRequests { request in
            self.activeNotificationRequests = request
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
