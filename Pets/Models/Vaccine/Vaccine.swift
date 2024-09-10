//
//  Vaccine.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import Foundation
import SwiftData

@Model
class Vaccine {
    var name: String = ""
    var type: VaccineType = VaccineType.unknown
    var starts: Date = Date.now
    var ends: Date = Date.now
    var notification: NotificationPeriod = NotificationPeriod.none
    var notificationTime: Date = Date.now
    var notes: String = ""
    var pet: Pet?
    
    var activeDays: Int {
        Int(ends.timeIntervalSince(.now) / 86400)
    }
    
    init(
        name: String = "",
        type: VaccineType = .unknown,
        starts: Date = .now,
        ends: Date = .now,
        notes: String = "",
        pet: Pet? = nil
    ) {
        self.name = name
        self.type = type
        self.starts = starts
        self.ends = ends
        self.notes = notes
        self.pet = pet
    }
}
