//
//  Double+Extension.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = true
        nf.numberStyle = .currency
        nf.currencyCode = "INR"
        nf.currencySymbol = "₹"
        nf.maximumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }
    
    private var percentageFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = true
        nf.numberStyle = .percent
        nf.maximumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }
    
    var toCurrency: String {
        let nsNumber = NSNumber(value: self)
        return currencyFormatter.string(from: nsNumber) ?? "-"
    }
    
    var toPercentage: String {
        let nsNumber = NSNumber(value: self / 100)
        return percentageFormatter.string(from: nsNumber) ?? "-"
    }
    
    var toCompactName: String {
        return self.formatted(.number.notation(.compactName))
    }
}
