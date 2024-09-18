//
//  Deworming.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation
import SwiftData

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
