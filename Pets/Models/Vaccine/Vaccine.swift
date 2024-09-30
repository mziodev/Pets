//
//  Vaccine.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import SwiftData
import SwiftUI

@Model
class Vaccine {
    var name: String = ""
    var type: VaccineType = VaccineType.unknown
    var starts: Date = Date.now
    var ends: Date = Date.now
    var notification: NotificationPeriod = NotificationPeriod.none
    var notificationID: String = ""
    var notificationTime: Date = Date.now
    var notes: String = ""
    var pet: Pet?
    
    var activeDays: Int {
        Int(ceil(ends.firstHour.timeIntervalSince(.now) / 86400))
    }
    
    var activeDaysColor: Color {
        let daysRange = 15...30
        
        if activeDays < 15 {
            return .red
        } else if daysRange.contains(activeDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var isExpired: Bool { activeDays < 0 }
    
    init(
        name: String = "",
        type: VaccineType = .unknown,
        starts: Date = .now,
        ends: Date = .now,
        notificationID: String = UUID().uuidString,
        notes: String = "",
        pet: Pet? = nil
    ) {
        self.name = name
        self.type = type
        self.starts = starts
        self.ends = ends
        self.notificationID = notificationID
        self.notes = notes
        self.pet = pet
    }
}
