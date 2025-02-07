//
//  VRDoubleLineDataProtocol.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

/// A protocol defining the structure for a two-line row of textual data.
///
/// `VRDoubleLineDataProtocol` is used to standardize data representation
/// where each row consists of:
/// - A **title** on the left and a **right-aligned value**.
/// - A **caption** on the left and a **right-aligned value** with a configurable color.
///
/// ## Layout:
/// ```
/// +----------------------------------+
/// | Title            TitleRightValue |
/// | Caption        CaptionRightValue |
/// +----------------------------------+
/// ```
///
/// This protocol is intended for use in UI components, such as `VRDoubleLineRowView`,
/// where structured text-based data needs to be displayed.
///
/// ## Example Usage:
/// ```swift
/// struct SampleData: VRDoubleLineDataProtocol {
///     var title: String = "Balance"
///     var titleRightValue: String = "$1,200"
///     var caption: String = "Last Updated"
///     var captionRightValue: String = "Today"
///     var captionRightValueColor: Color = .green
/// }
///
/// let rowData = SampleData()
/// ```
///
protocol VRDoubleLineDataProtocol {
    /// The main title text displayed on the left side of the row.
    var title: String { get }
    
    /// The right-aligned value associated with the title.
    var titleRightValue: String { get }
    
    /// The caption text displayed below the title on the left side.
    var caption: String { get }
    
    /// The right-aligned value associated with the caption.
    var captionRightValue: String { get }
    
    /// The color of the `captionRightValue`, allowing customization.
    var captionRightValueColor: Color { get }
}

extension VRDoubleLineDataProtocol {
    
    /// Provides a default color for `captionRightValue`.
    ///
    /// By default, this returns `.primary`, which adapts to the system theme.
    /// Implementing types can override this property to specify a custom color.
    var captionRightValueColor: Color {
        Color.primary
    }
}
