//
//  String+Extension.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

extension String {
    
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression)
    }
}
