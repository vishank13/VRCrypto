//
//  VRText.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 09/02/25.
//


import SwiftUI

struct VRText: View {
    let text: String
    let style: VRTextStyle
    let alignment: Alignment
    let foreground: Color
    
    init(_ text: String,
         style: VRTextStyle,
         alignment: Alignment = .leading,
         foreground: Color = .primary) {
        self.text = text
        self.style = style
        self.alignment = alignment
        self.foreground = foreground
    }
    
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: alignment)
            .applyStyle(style)
            .foregroundStyle(foreground)
    }
}
