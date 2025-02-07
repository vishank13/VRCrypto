//
//  SheetTitleModifier.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

/// A custom `ViewModifier` that adds a styled title and a separator line to a sheet.
///
/// `SheetTitleModifier` is designed for use in SwiftUI sheets, providing:
/// - A **bold title** displayed at the top.
/// - A **horizontal separator line** below the title.
/// - **Padding and background styling** for a clean UI appearance.
/// - **Custom presentation detents** to control the sheet's height.
///
/// ## Example Usage:
/// ```swift
/// struct ExampleView: View {
///     var body: some View {
///         Text("Sheet Content")
///             .modifier(SheetTitleModifier(title: "Sheet Title"))
///     }
/// }
/// ```
///
/// ## Customization:
/// - The **title** is styled with `.title` font and `accentColor`.
/// - The **separator line** visually separates the title from the content.
/// - The **background** uses a custom color (`.vrBackground`).
/// - The **presentation detents** allow the sheet to be either 50% or 92% of the screen height.
///
struct SheetTitleModifier: ViewModifier {
    
    /// The title displayed at the top of the sheet.
    var title: String
    
    /// Modifies the view by adding a title, a separator, and styling.
    /// - Parameter content: The view to be modified.
    /// - Returns: A modified view with a title and background styling.
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title section
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentColor)
                .padding(.horizontal)
            
            // Separator line
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.accentColor)
                .padding(.vertical)
            
            // The original content
            content
        }
        .padding(.vertical)
        .background(Color(.vrBackground)) // Custom background color
        .presentationDetents([.fraction(0.5), .fraction(0.92)]) // Controls sheet height
    }
}
