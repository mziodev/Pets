//
//  Pet+Validation.swift
//  Pets
//
//  Created by MZiO on 7/6/24.
//

import Foundation

extension Pet {
    /// A dictionary of validators for different types of pet Chip ID numbers.
    ///
    /// Each key represents a pet `ChipIDType`, and the corresponding value is a 
    /// closure that takes a `String` input (pet ID number) and returns a `Bool` indicating
    /// whether the input is valid for that Chip ID type.
    static var chipIDValidators: [ChipIDType: (String) -> Bool] = [
        .noChipID: { $0.isEmpty },
        .fifteenDigit: { $0.count == 15 },
        .tenDigit: { $0.count == 10 },
        .nineDigit: { $0.count == 9 }
    ]
}
