//
//  Deworming.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import SwiftData
import SwiftUI

@Model
class DewormingTreatment {
    var type: TreatmentType = TreatmentType.unknown
    var units: TreatmentUnit = TreatmentUnit.units
    var name: String = ""
    var quantity: Double = 0
    var startingDate: Date = Date.now
    var endingDate: Date = Date.now
    var notification: NotificationPeriod = NotificationPeriod.none
    var notificationID: String = ""
    var notificationTime: Date = Date.now
    var notes: String = ""
    var pet: Pet? = nil
    
    var activeDays: Int {
        Int(ceil(endingDate.firstHour.timeIntervalSince(.now) / 86400))
    }
    
    var activeDaysColor: Color {
        let daysRange = 7...15
        
        if activeDays < 7 {
            return .red
        } else if daysRange.contains(activeDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var isActive: Bool {
        self.activeDays >= 0
    }
    
    init(
        type: TreatmentType = .unknown,
        units: TreatmentUnit = .units,
        name: String = "",
        quantity: Double = 0,
        startingDate: Date = .now,
        endingDate: Date = .now,
        notificationID: String = UUID().uuidString,
        notes: String = "",
        pet: Pet? = nil
    ) {
        self.type = type
        self.units = units
        self.name = name
        self.quantity = quantity
        self.startingDate = startingDate
        self.endingDate = endingDate
        self.notificationID = notificationID
        self.notes = notes
        self.pet = pet
    }    
}
