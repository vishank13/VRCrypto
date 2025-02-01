//
//  SheetTitleModifier.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI 

struct SheetTitleModifier: ViewModifier {
    
    var title: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
                .padding(.horizontal)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.accentColor)
                .padding(.vertical)
            
            content
        }
        .padding(.vertical)
        .background(Color(.vrBackground))
        .presentationDetents([.fraction(0.5), .fraction(0.92)])
    }
}
