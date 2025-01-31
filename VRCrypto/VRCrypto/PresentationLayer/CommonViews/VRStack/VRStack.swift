//
//  VRStack.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct VRStack<Content: View>: View {
    
    @Binding var showLoader: Bool
    let content: Content
    
    init(showLoader: Binding<Bool>,
         @ViewBuilder content: () -> Content) {
        self._showLoader = showLoader
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(.vrBackground).ignoresSafeArea()
            
            content
            
            if showLoader {
                Color.black.opacity(0.5).ignoresSafeArea()
                
                ProgressView()
                    .controlSize(.large)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.vrBackground))
                    }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    VRStack(showLoader: .constant(true)) {
        Text("Hello")
    }
}

@Observable
class VRViewModel {
    
    var showLoader: Bool = false
    
    init() {}
    
    func loaderAppearance(_ show: Bool) {
        showLoader = show
    }
}
