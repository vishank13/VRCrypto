//
//  NavigationBarModifier.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI

/// A view modifier that customizes the navigation bar appearance.
///
/// This modifier allows setting a navigation title, display mode,
/// and optional leading and trailing toolbar buttons. It uses a `NavigationBarConfig`
/// object to configure the navigation bar.
///
/// Usage:
/// ```swift
/// someView
///     .modifier(NavigationBarModifier(config: config))
/// ```
///
/// - Note: If no leading action is provided, the default action dismisses the current view.
struct NavigationBarModifier: ViewModifier {
    
    /// Configuration object for the navigation bar.
    var config: NavigationBarConfig
    
    /// Environment property to handle view dismissal when no leading action is provided.
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(config.title)
            .navigationBarTitleDisplayMode(config.titleDisplayMode)
            .navigationBarBackButtonHidden()
            .toolbar {
                // MARK: - Leading Toolbar Item
                if config.leadingItemVisible {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button {
                            if let action = config.leadingAction {
                                action()
                            } else {
                                dismiss() // Default dismiss action
                            }
                        } label: {
                            Image(systemName: config.leadingSystemImage ?? "chevron.left")
                        }
                    }
                }
                
                // MARK: - Trailing Toolbar Item
                if let trailingSystemImage = config.trailingSystemImage,
                   let trailingAction = config.trailingAction {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(action: trailingAction) {
                            Image(systemName: trailingSystemImage)
                        }
                    }
                }
            }
    }
}
