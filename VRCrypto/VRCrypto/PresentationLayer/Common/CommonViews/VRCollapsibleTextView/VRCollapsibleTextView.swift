//
//  VRCollapsibleTextView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

import SwiftUI

/// A reusable **collapsible text view** that allows long text to expand and collapse.
///
/// This component supports animation when toggling between expanded and collapsed states.
///
/// # Example Usage:
/// ```swift
/// CollapsibleTextView(text: "This is a long description that will be collapsible...", collapsedLines: 5)
/// ```
///
struct VRCollapsibleTextView: View {
    
    /// The **text content** to be displayed.
    var text: String
    
    /// The **number of lines** to show when collapsed.
    var collapsedLines: Int?
    
    /// **State variable** to track the number of visible lines.
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            VRText(text,
                   style: .body)
                .lineLimit(isExpanded ? nil : collapsedLines)
            
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                VRText(isExpanded ? "Show less" : "Show more",
                       style: .subheadline)
            }
        }
    }
}
