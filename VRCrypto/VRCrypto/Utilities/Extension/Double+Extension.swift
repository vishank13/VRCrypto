//
//  Double+Extension.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation

/// An extension of `Double` that provides formatted representations for currency, percentage, and compact numerical notation.
extension Double {
    
    /// A `NumberFormatter` configured for currency formatting in Indian Rupees (INR).
    private var currencyFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = true
        nf.numberStyle = .currency
        nf.currencyCode = "INR"
        nf.currencySymbol = "₹"
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2 // Ensures consistency in decimal places
        return nf
    }
    
    /// A `NumberFormatter` configured for percentage formatting.
    private var percentageFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = true
        nf.numberStyle = .percent
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2 // Ensures consistency in decimal places
        return nf
    }
    
    /// Converts the `Double` value to a formatted currency string in INR.
    ///
    /// ## Example:
    /// ```swift
    /// let amount: Double = 123456.78
    /// print(amount.toCurrency) // Output: ₹1,23,456.78
    /// ```
    var toCurrency: String {
        let nsNumber = NSNumber(value: self)
        return currencyFormatter.string(from: nsNumber) ?? "-"
    }
    
    /// Converts the `Double` value to a formatted percentage string.
    ///
    /// The value is divided by 100 to correctly represent percentage values.
    ///
    /// ## Example:
    /// ```swift
    /// let percentage: Double = 12.34
    /// print(percentage.toPercentage) // Output: 12.34%
    /// ```
    var toPercentage: String {
        let nsNumber = NSNumber(value: self / 100)
        return percentageFormatter.string(from: nsNumber) ?? "-"
    }
    
    /// Converts the `Double` value to a compact number representation.
    ///
    /// This uses Apple's `formatted(.number.notation(.compactName))`, which formats numbers into short forms like "1K", "1M", "1B".
    ///
    /// ## Example:
    /// ```swift
    /// let bigNumber: Double = 1234567
    /// print(bigNumber.toCompactName) // Output: "1.2M"
    /// ```
    var toCompactName: String {
        return self.formatted(.number.notation(.compactName))
    }
}
