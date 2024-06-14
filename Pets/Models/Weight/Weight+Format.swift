//
//  Weight+Format.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

extension Weight {
    /// Computed variable that contains the correct weight unit depending on the current locale.
    ///
    /// - returns: A string with `lb` for US locale and `kg` for the rest of the countries.
    static var units: String {
        if Locale.current.identifier == "en_US" {
            return "lb"
        } else {
            return "kg"
        }
    }
}

