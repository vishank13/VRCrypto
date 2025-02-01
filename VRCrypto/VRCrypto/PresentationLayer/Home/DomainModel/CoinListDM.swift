//
//  CoinListDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct CoinListDM: Identifiable {
    var id: String?
    var symbol: String?
    var name: String?
    var image: String?
    var currentPrice: Double?
    var marketCap: Int?
    var marketCapRank: Int?
    var fullyDilutedValuation: Int?
    var totalVolume: Double?
    var high24H: Double?
    var low24H: Double?
    var priceChange24H: Double?
    var priceChangePercentage24H: Double?
    var marketCapChange24H: Double?
    var marketCapChangePercentage24H: Double?
    var circulatingSupply: Double?
    var totalSupply: Double?
    var maxSupply: Double?
    var ath: Double?
    var athChangePercentage: Double?
    var athDate: String?
    var atl: Double?
    var atlChangePercentage: Double?
    var atlDate: String?
    var roi: RoiDM?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7DDM?
    var priceChangePercentage24HInCurrency: Double?
    
    init?(response: CoinListResponse?) {
        guard let response else {
            return
        }
        self.id = response.id
        self.symbol = response.symbol
        self.name = response.name
        self.image = response.image
        self.currentPrice = response.currentPrice
        self.marketCap = response.marketCap
        self.marketCapRank = response.marketCapRank
        self.fullyDilutedValuation = response.fullyDilutedValuation
        self.totalVolume = response.totalVolume
        self.high24H = response.high24H
        self.low24H = response.low24H
        self.priceChange24H = response.priceChange24H
        self.priceChangePercentage24H = response.priceChangePercentage24H
        self.marketCapChange24H = response.marketCapChange24H
        self.marketCapChangePercentage24H = response.marketCapChangePercentage24H
        self.circulatingSupply = response.circulatingSupply
        self.totalSupply = response.totalSupply
        self.maxSupply = response.maxSupply
        self.ath = response.ath
        self.athChangePercentage = response.athChangePercentage
        self.athDate = response.athDate
        self.atl = response.atl
        self.atlChangePercentage = response.atlChangePercentage
        self.atlDate = response.atlDate
        self.roi = .init(response: response.roi)
        self.lastUpdated = response.lastUpdated
        self.sparklineIn7D = .init(response: response.sparklineIn7D)
        self.priceChangePercentage24HInCurrency = response.priceChangePercentage24HInCurrency
    }
}

extension CoinListDM {
    
    var smallImage: String {
        image?.replacingOccurrences(of: "/large/", with: "/small/") ?? ""
    }
}

extension CoinListDM: VRDoubleLineDataProtocol {
    var title: String {
        name ?? "-"
    }
    
    var titleRightValue: String {
        currentPrice?.toCurrency ?? "-"
    }
    
    var caption: String {
        symbol ?? "-"
    }
    
    var captionRightValue: String {
        let priceChange24HStr = priceChange24H?.toCurrency ?? "-"
        
        let priceChangePercentage24HStr = priceChangePercentage24H?.toPercentage ?? "-"
        
        return "\(priceChange24HStr) (\(priceChangePercentage24HStr))"
    }
    
    var captionRightValueColor: Color {
        priceChangePercentage24H ?? 0 >= 0 ? Color(.vrGreen) : Color(.vrRed)
    }
}
