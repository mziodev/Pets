//
//  String+Validation.swift
//  Pets
//
//  Created by MZiO on 28/8/24.
//

import Foundation

extension String {
    
    func hasMinimumLength(length: Int = 1) -> Bool {
        self.count > length
    }
}
