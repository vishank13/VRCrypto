//
//  VRDoubleLineDataProtocol.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

protocol VRDoubleLineDataProtocol {
    var title: String { get }
    var titleRightValue: String { get }
    var caption: String { get }
    var captionRightValue: String { get }
    var captionRightValueColor: Color { get }
}

extension VRDoubleLineDataProtocol {
    
    var captionRightValueColor: Color {
        Color.primary
    }
}
