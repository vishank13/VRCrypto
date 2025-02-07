//
//  VRDoubleLineRowView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

/// A SwiftUI view that displays a two-line row with titles and captions.
///
/// `VRDoubleLineRowView` presents textual data in a structured format where:
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
/// VRDoubleLineRowView(dataRow: sampleData)
/// ```
///
/// ## Parameters
/// - `dataRow`: A model conforming to `VRDoubleLineDataProtocol`, providing the necessary text values and styling.
///
struct VRDoubleLineRowView: View {
    
    /// The data model containing the necessary text values and styling.
    var dataRow: VRDoubleLineDataProtocol
    
    /// Initializes the view with a data row.
    /// - Parameter dataRow: An object conforming to `VRDoubleLineDataProtocol` that provides content for the view.
    init(dataRow: VRDoubleLineDataProtocol) {
        self.dataRow = dataRow
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(dataRow.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(dataRow.titleRightValue)
                    .font(.headline)
            }
            
            HStack {
                Text(dataRow.caption)
                    .font(.callout)
                
                Spacer()
                
                Text(dataRow.captionRightValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(dataRow.captionRightValueColor)
            }
        }
        .lineLimit(1)
        .padding(.vertical, 4)
    }
}
