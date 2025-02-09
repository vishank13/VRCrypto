//
//  VRGridItemView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 09/02/25.
//

import SwiftUI

struct VRGridItemView: View {
    
    let title: String
    let value: String
    let alignment: Alignment
    
    init(title: String,
         value: String,
         alignment: Alignment = .leading) {
        self.title = title
        self.value = value
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            constructFirstLineView()
            constructSecondLineView()
        }
        .lineLimit(1)
    }
    
    fileprivate func constructFirstLineView() -> some View {
        VRText(title,
               style: .caption,
               alignment: alignment,
               foreground: .accentColor)
    }
    
    fileprivate func constructSecondLineView() -> some View {
        VRText(value,
               style: .headline,
               alignment: alignment)
    }
}
