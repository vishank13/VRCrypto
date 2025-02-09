//
//  MarketDataDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

import SwiftUI

struct MarketDataDM {
    let currentPrice: Double?
    let totalValueLocked: Double?
    let mcapToTvlRatio: Double?
    let fdvToTvlRatio: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let marketCap: Double?
    let marketCapRank: Int?
    let fullyDilutedValuation: Double?
    let marketCapFdvRatio: Int?
    let totalVolume: Double?
    let high24H: Double?
    let low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let priceChangePercentage7D: Double?
    let priceChangePercentage14D: Double?
    let priceChangePercentage30D: Double?
    let priceChangePercentage60D: Double?
    let priceChangePercentage200D: Double?
    let priceChangePercentage1Y: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let priceChange24HInCurrency: Double?
    let priceChangePercentage1HInCurrency: Double?
    let priceChangePercentage24HInCurrency: Double?
    let priceChangePercentage7DInCurrency: Double?
    let priceChangePercentage14DInCurrency: Double?
    let priceChangePercentage30DInCurrency: Double?
    let priceChangePercentage60DInCurrency: Double?
    let priceChangePercentage200DInCurrency: Double?
    let priceChangePercentage1YInCurrency: Double?
    let marketCapChange24HInCurrency: Double?
    let marketCapChangePercentage24HInCurrency: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let maxSupplyInfinite: Bool?
    let circulatingSupply: Double?
    let sparkline7D: [Double]?
    let lastUpdated: String?
    
    init?(response: CoinDataResponse.MarketData?) {
        guard let response else {
            return nil
        }
        self.currentPrice = response.currentPrice?["usd"] as? Double
        self.totalValueLocked = response.totalValueLocked
        self.mcapToTvlRatio = response.mcapToTvlRatio
        self.fdvToTvlRatio = response.fdvToTvlRatio
        self.ath = response.ath?["usd"] as? Double
        self.athChangePercentage = response.athChangePercentage?["usd"] as? Double
        self.athDate = response.athDate?["usd"] as? String
        self.atl = response.atl?["usd"] as? Double
        self.atlChangePercentage = response.atlChangePercentage?["usd"] as? Double
        self.atlDate = response.atlDate?["usd"] as? String
        self.marketCap = response.marketCap?["usd"] as? Double
        self.marketCapRank = response.marketCapRank
        self.fullyDilutedValuation = response.fullyDilutedValuation?["usd"] as? Double
        self.marketCapFdvRatio = response.marketCapFdvRatio
        self.totalVolume = response.totalVolume?["usd"] as? Double
        self.high24H = response.high24H?["usd"] as? Double
        self.low24H = response.low24H?["usd"] as? Double
        self.priceChange24H = response.priceChange24H
        self.priceChangePercentage24H = response.priceChangePercentage24H
        self.priceChangePercentage7D = response.priceChangePercentage7D
        self.priceChangePercentage14D = response.priceChangePercentage14D
        self.priceChangePercentage30D = response.priceChangePercentage30D
        self.priceChangePercentage60D = response.priceChangePercentage60D
        self.priceChangePercentage200D = response.priceChangePercentage200D
        self.priceChangePercentage1Y = response.priceChangePercentage1Y
        self.marketCapChange24H = response.marketCapChange24H
        self.marketCapChangePercentage24H = response.marketCapChangePercentage24H
        self.priceChange24HInCurrency = response.priceChange24HInCurrency?["usd"]
        self.priceChangePercentage1HInCurrency = response.priceChangePercentage1HInCurrency?["usd"] as? Double
        self.priceChangePercentage24HInCurrency = response.priceChangePercentage24HInCurrency?["usd"] as? Double
        self.priceChangePercentage7DInCurrency = response.priceChangePercentage7DInCurrency?["usd"] as? Double
        self.priceChangePercentage14DInCurrency = response.priceChangePercentage14DInCurrency?["usd"] as? Double
        self.priceChangePercentage30DInCurrency = response.priceChangePercentage30DInCurrency?["usd"] as? Double
        self.priceChangePercentage60DInCurrency = response.priceChangePercentage60DInCurrency?["usd"] as? Double
        self.priceChangePercentage200DInCurrency = response.priceChangePercentage200DInCurrency?["usd"] as? Double
        self.priceChangePercentage1YInCurrency = response.priceChangePercentage1YInCurrency?["usd"] as? Double
        self.marketCapChange24HInCurrency = response.marketCapChange24HInCurrency?["usd"] as? Double
        self.marketCapChangePercentage24HInCurrency = response.marketCapChangePercentage24HInCurrency?["usd"] as? Double
        self.totalSupply = response.totalSupply
        self.maxSupply = response.maxSupply
        self.maxSupplyInfinite = response.maxSupplyInfinite
        self.circulatingSupply = response.circulatingSupply
        self.sparkline7D = response.sparkline7D?.price?.compactMap { $0 }
        self.lastUpdated = response.lastUpdated
    }
}


extension MarketDataDM {
    
    var sparklineColor: Color {
        guard let first = sparkline7D?.first,
              let last  = sparkline7D?.last else {
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
