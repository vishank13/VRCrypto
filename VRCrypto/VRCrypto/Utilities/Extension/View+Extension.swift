//
//  View+Extension.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI

extension View {
    
    /// Applies a custom navigation bar configuration to the view.
    ///
    /// This modifier allows you to configure the navigation bar with a title, display mode,
    /// and optional leading/trailing toolbar items using a `NavigationBarConfig` object.
    ///
    /// - Parameter config: The configuration object containing navigation bar settings.
    /// - Returns: A modified view with the specified navigation bar configuration.
    func customNavigationBar(_ config: NavigationBarConfig) -> some View {
        self.modifier(NavigationBarModifier(config: config))
    }
}
