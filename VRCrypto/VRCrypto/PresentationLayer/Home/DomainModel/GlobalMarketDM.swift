//
//  GlobalMarketDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//


struct GlobalMarketDM {
    var activeCryptocurrencies: Int?
    var upcomingIcos: Int?
    var ongoingIcos: Int?
    var endedIcos: Int?
    var markets: Int?
    var totalMarketCap: [String: Double]?
    var totalVolume: [String: Double]?
    var marketCapPercentage: [String: Double]?
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?
    
    init?(response: GlobalMarketResponse.DataClass?) {
        guard let response = response else {
            return nil
        }
        self.activeCryptocurrencies = response.activeCryptocurrencies
        self.upcomingIcos = response.upcomingIcos
        self.ongoingIcos = response.ongoingIcos
        self.endedIcos = response.endedIcos
        self.markets = response.markets
        self.totalMarketCap = response.totalMarketCap
        self.totalVolume = response.totalVolume
        self.marketCapPercentage = response.marketCapPercentage
        self.marketCapChangePercentage24HUsd = response.marketCapChangePercentage24HUsd
        self.updatedAt = response.updatedAt
    }
}

extension GlobalMarketDM {
    
    var totalMarketCapINR: String {
        
        guard let inrValue = totalMarketCap?["inr"] else {
            return "-"
        }
                
        return "₹\(inrValue.toCompactName)"
    }
    
    var totalVolumeINR: String {
        
        guard let inrValue = totalVolume?["inr"] else {
            return "-"
        }
                
        return "₹\(inrValue.toCompactName)"
    }
    
    var marketCapPercentageBTC: String {
        
        guard let btcValue = marketCapPercentage?["btc"] else {
            return "-"
        }
                
        return btcValue.toPercentage
    }
}
