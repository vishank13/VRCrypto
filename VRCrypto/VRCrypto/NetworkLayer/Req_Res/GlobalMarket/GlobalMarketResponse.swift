//
//  GlobalMarketResponse.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import Foundation

struct GlobalMarketResponse: Codable {
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    struct DataClass: Codable {
        let activeCryptocurrencies: Int?
        let upcomingIcos: Int?
        let ongoingIcos: Int?
        let endedIcos: Int?
        let markets: Int?
        let totalMarketCap: [String: Double]?
        let totalVolume: [String: Double]?
        let marketCapPercentage: [String: Double]?
        let marketCapChangePercentage24HUsd: Double?
        let updatedAt: Int?
        
        enum CodingKeys: String, CodingKey {
            case activeCryptocurrencies = "active_cryptocurrencies"
            case upcomingIcos = "upcoming_icos"
            case ongoingIcos = "ongoing_icos"
            case endedIcos = "ended_icos"
            case markets = "markets"
            case totalMarketCap = "total_market_cap"
            case totalVolume = "total_volume"
            case marketCapPercentage = "market_cap_percentage"
            case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
            case updatedAt = "updated_at"
        }
    }
}
