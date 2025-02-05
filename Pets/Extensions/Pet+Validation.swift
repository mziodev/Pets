//
//  Pet+Validation.swift
//  Pets
//
//  Created by MZiO on 7/6/24.
//

import Foundation

extension Pet {
    
    static var chipIDValidators: [ChipIDType: (String) -> Bool] = [
//        .noChipID: { $0.isEmpty },
        .fifteenDigit: { $0.count == 15 },
        .tenDigit: { $0.count == 10 },
        .nineDigit: { $0.count == 9 }
    ]
}
