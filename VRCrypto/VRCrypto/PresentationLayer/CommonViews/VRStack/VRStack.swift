//
//  VRStack.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

/// A custom `ZStack`-based container view that includes a background color,
/// an optional loader overlay, and dynamically injected content.
///
/// `VRStack` is useful when you want to display content while optionally showing a loading indicator.
///
/// ## Features:
/// - **Background Styling**: Uses a custom background color (`.vrBackground`).
/// - **Content Placement**: Places the given content on top of the background.
/// - **Loader Overlay**: When `showLoader` is `true`, a semi-transparent overlay with a `ProgressView` appears.
///
/// ## Example Usage:
/// ```swift
/// struct ExampleView: View {
///     @State private var isLoading = false
///
///     var body: some View {
///         VRStack(showLoader: $isLoading) {
///             VStack {
///                 Text("Welcome to VRCrypto")
///                 Button("Load Data") {
///                     isLoading = true
///                     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
///                         isLoading = false
///                     }
///                 }
///             }
///         }
///     }
/// }
/// ```
struct VRStack<Content: View>: View {
    
    /// A binding that controls the visibility of the loader.
    @Binding var showLoader: Bool
    
    /// The content to be displayed inside the stack.
    let content: Content
    
    /// Initializes `VRStack` with a binding to control the loader and a view builder for content.
    ///
    /// - Parameters:
    ///   - showLoader: A `Binding<Bool>` to toggle the loader visibility.
    ///   - content: A closure returning the view to be displayed inside the stack.
    init(showLoader: Binding<Bool>,
         @ViewBuilder content: () -> Content) {
        self._showLoader = showLoader
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Background color that extends to the screen edges.
            Color(.vrBackground).ignoresSafeArea()
            
            // The primary content of the view.
            content
            
            // Loader overlay when `showLoader` is true.
            if showLoader {
                Color.black.opacity(0.5).ignoresSafeArea() // Dims the background
                
                ProgressView()
                    .controlSize(.large)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.vrBackground))
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Expands to fill available space
    }
}

#Preview {
    VRStack(showLoader: .constant(true)) {
        Text("Hello")
    }
}

/// A simple view model to manage the visibility of a loading indicator.
///
/// `VRViewModel` is designed to be used with `VRStack` and other views that require a loading state.
///
/// ## Example Usage:
/// ```swift
/// @StateObject var viewModel = VRViewModel()
///
/// Button("Show Loader") {
///     viewModel.loaderAppearance(true)
///     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
///         viewModel.loaderAppearance(false)
///     }
/// }
/// ```
@Observable
class VRViewModel {
    
    /// A boolean that determines whether the loader should be displayed.
    var showLoader: Bool = false
    
    /// Initializes a new instance of `VRViewModel`.
    init() {}
    
    /// Updates the visibility of the loader.
    ///
    /// - Parameter show: `true` to display the loader, `false` to hide it.
    func loaderAppearance(_ show: Bool) {
        showLoader = show
    }
}
