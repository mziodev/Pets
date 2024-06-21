//
//  FormVerification.swift
//  Pets
//
//  Created by MZiO on 21/6/24.
//

import Foundation

struct FormVerification {
    /// Checks if the given string has a minimum length of 2 characters.
    ///
    /// - Parameter name: The string to check.
    /// - Returns: `true` if the string has a minimum length of 2 characters, `false` otherwise.
    static func checkMinimumLength(_ name: String) -> Bool { name.count > 1 }
}
