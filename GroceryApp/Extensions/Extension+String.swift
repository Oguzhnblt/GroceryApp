//
//  Extension+String.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import Foundation

extension String {
    /// Breaks the string into chunks of specified size.
    func chunked(into size: Int) -> [String] {
        guard size > 0 else { return [] }
        return stride(from: 0, to: count, by: size).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
    
    /// Formats a card number into groups of four digits.
    func formattedCardNumber() -> String {
        let digits = self.filter { $0.isNumber }
        return digits.chunked(into: 4).joined(separator: " ")
    }
    
    /// Formats a date into MM/YY format.
    func formattedExpirationDate() -> String {
        let digits = self.filter { $0.isNumber }
        return digits.chunked(into: 2).joined(separator: "/")
    }
    
    /// Returns only the numeric characters in the string.
    var digitsOnly: String {
        return self.filter { $0.isNumber }
    }
    
    /// Limits the string to a specified maximum length.
    func limited(to maxLength: Int) -> String {
        return String(self.prefix(maxLength))
    }
}
