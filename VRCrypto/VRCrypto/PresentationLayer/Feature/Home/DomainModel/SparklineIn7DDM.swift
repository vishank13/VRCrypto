//
//  SparklineIn7DDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct SparklineIn7DDM {
    var price: [Double]?
    
    init?(response: CoinListResponse.SparklineIn7D?) {
        guard let response else {
            return
        }
        self.price = response.price
    }
}

extension SparklineIn7DDM {
    
    var sparklineColor: Color {
        guard let first = price?.first,
              let last  = price?.last else {
            return Color.secondary
        }
        
        if first > last {
            return Color(.vrRed)
        } else if first < last {
            return Color(.vrGreen)
        } else {
            return Color.secondary
        }
    }
}
