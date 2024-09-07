//
//  Date+Format.swift
//  Pets
//
//  Created by MZiO on 6/9/24.
//

import Foundation

extension Date {
    var monthAndDay: String {
        self.formatted(.dateTime.month().day())
    }
    
    var monthDayYear: String {
        self.formatted(.dateTime.month().day().year())
    }
    
    var year: String {
        self.formatted(.dateTime.year())
    }
}
