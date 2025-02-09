//
//  VRDoubleLineTitleView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

/// A SwiftUI view that displays a two-line row with titles and captions.
///
/// `VRDoubleLineTitleView` presents textual data in a structured format where:
/// - The first row contains a **title** on the left and a **right-aligned value**.
/// - The second row contains a **caption** on the left and a **right-aligned value** with a configurable color.
///
/// This view is typically used in list-based interfaces where structured information needs to be displayed concisely.
///
/// ## Layout
/// ```
/// +----------------------------------+
/// | Title            TitleRightValue |
/// | Caption        CaptionRightValue |
/// +----------------------------------+
/// ```
///
/// ## Example Usage
/// ```swift
/// VRDoubleLineTitleView(dataRow: sampleData)
/// ```
///
/// ## Parameters
/// - `dataRow`: A model conforming to `VRDoubleLineDataProtocol`, providing the necessary text values and styling.
///
struct VRDoubleLineTitleView: View {
    
    /// The data model containing the necessary text values and styling.
    var dataRow: VRDoubleLineDataProtocol
    
    /// Initializes the view with a data row.
    /// - Parameter dataRow: An object conforming to `VRDoubleLineDataProtocol` that provides content for the view.
    init(dataRow: VRDoubleLineDataProtocol) {
        self.dataRow = dataRow
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            constructFirstLineView()
            constructSecondLineView()
        }
        .lineLimit(1)
    }
    
    fileprivate func constructFirstLineView() -> some View {
        HStack {
            VRText(dataRow.title,
                   style: .headline)
            
            VRText(dataRow.titleRightValue,
                   style: .subheadline,
                   alignment: .trailing)
        }
    }
    
    fileprivate func constructSecondLineView() -> some View {
        HStack {
            VRText(dataRow.caption,
                   style: .body)
            
            VRText(dataRow.captionRightValue,
                   style: .subheadline,
                   alignment: .trailing,
                   foreground: dataRow.captionRightValueColor)
        }
    }
}
