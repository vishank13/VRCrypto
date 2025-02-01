//
//  VRDoubleLineRowView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import SwiftUI

struct VRDoubleLineRowView: View {
    
    var dataRow: VRDoubleLineDataProtocol
    
    init(dataRow: VRDoubleLineDataProtocol) {
        self.dataRow = dataRow
    }
    
    var body: some View {
        HStack {
            VStack {
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
        }
    }
}
