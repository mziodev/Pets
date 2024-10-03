//
//  Format.swift
//  Pets
//
//  Created by MZiO on 21/6/24.
//

import Foundation

struct Format {
    //
    // NOT used in this app !!
    //
    /// Formats a string value as a currency string, removing trailing zeros and decimal points.
    ///
    /// - Parameter value: The input string value to be formatted.
    ///
    /// - Returns: A string representing the formatted currency value, or "0.00" if the input value cannot be converted to a double.
    ///
    /// - Note: This function assumes that the input value is entered in a right-to-left order, where numbers are input from right to left.
    ///         For example, an input value of "1230" would be formatted as "12.30".
    ///
    /// - Example: `formatValueAsCurrencyRightToLeft(value: "1230")` returns "12.30"
    static func formatValueAsCurrencyRightToLeft(value: String) -> String {
        let filteredValue = value.replacingOccurrences(
            of: "[0\\.]",
            with: "",
            options: .regularExpression
        )
        
        return Double(filteredValue).map {
            String(format: "%.2f", $0 / 100)
        } ?? "0.00"
    }
}
