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
