//
//  VRStack.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct VRStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(.vrBackground).ignoresSafeArea()
            
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    VRStack {
        Text("Hello")
    }
}
