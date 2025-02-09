//
//  NavigationBarConfig.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI

/// A configuration class to define properties for a navigation bar in SwiftUI.
class NavigationBarConfig {
    
    /// The title displayed in the navigation bar.
    let title: String
    
    /// The display mode for the navigation bar title (e.g., `.inline`, `.large`).
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    
    /// A flag to determine if the leading toolbar item (e.g., back button) is visible.
    let leadingItemVisible: Bool
    
    /// The system image name for the leading toolbar item (optional).
    let leadingSystemImage: String?
    
    /// The action to be executed when the leading toolbar item is tapped (optional).
    let leadingAction: (() -> Void)?
    
    /// The system image name for the trailing toolbar item (optional).
    let trailingSystemImage: String?
    
    /// The action to be executed when the trailing toolbar item is tapped (optional).
    let trailingAction: (() -> Void)?
    
    /// Initializes a new navigation bar configuration.
    ///
    /// - Parameters:
    ///   - title: The title displayed in the navigation bar.
    ///   - titleDisplayMode: The display mode for the navigation bar title (default is `.inline`).
    ///   - leadingItemVisible: A Boolean flag to control the visibility of the leading toolbar item (default is `true`).
    ///   - leadingSystemImage: The system image name for the leading toolbar item (optional, default is `nil`).
    ///   - leadingAction: The action to be performed when the leading toolbar item is tapped (optional, default is `nil`).
    ///   - trailingSystemImage: The system image name for the trailing toolbar item (optional, default is `nil`).
    ///   - trailingAction: The action to be performed when the trailing toolbar item is tapped (optional, default is `nil`).
    init(title: String,
         titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
         leadingItemVisible: Bool = true,
         leadingSystemImage: String? = nil,
         leadingAction: (() -> Void)? = nil,
         trailingSystemImage: String? = nil,
         trailingAction: (() -> Void)? = nil) {
        self.title = title
        self.titleDisplayMode = titleDisplayMode
        self.leadingItemVisible = leadingItemVisible
        self.leadingSystemImage = leadingSystemImage
        self.leadingAction = leadingAction
        self.trailingSystemImage = trailingSystemImage
        self.trailingAction = trailingAction
    }
}
