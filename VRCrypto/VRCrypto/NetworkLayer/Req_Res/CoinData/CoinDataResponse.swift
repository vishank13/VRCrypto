//
//  CoinDataResponse.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

import Foundation

struct CoinDataResponse: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let webSlug: String?
    let assetPlatformID: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String?]?
    let previewListing: Bool?
    let publicNotice: String?
    let additionalNotices: [String?]?
    let description: Description?
    let links: Links?
    let image: Image?
    let countryOrigin: String?
    let genesisDate: String?
    let sentimentVotesUpPercentage: Double?
    let sentimentVotesDownPercentage: Double?
    let watchlistPortfolioUsers: Int?
    let marketCapRank: Int?
    let marketData: MarketData?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case webSlug = "web_slug"
        case assetPlatformID = "asset_platform_id"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories = "categories"
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case description = "description"
        case links = "links"
        case image = "image"
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case lastUpdated = "last_updated"
    }
    
    struct Description: Codable {
        let en: String?
        
        enum CodingKeys: String, CodingKey {
            case en = "en"
        }
    }
    
    struct Image: Codable {
        let thumb: String?
        let small: String?
        let large: String?
        
        enum CodingKeys: String, CodingKey {
            case thumb = "thumb"
            case small = "small"
            case large = "large"
        }
    }
    
    struct Links: Codable {
        let homepage: [String?]?
        let whitepaper: String?
        let blockchainSite: [String?]?
        let officialForumURL: [String?]?
        let chatURL: [String?]?
        let announcementURL: [String?]?
        let snapshotURL: String?
        let twitterScreenName: String?
        let facebookUsername: String?
        let bitcointalkThreadIdentifier: String?
        let telegramChannelIdentifier: String?
        let subredditURL: String?
        let reposURL: ReposURL?
        
        enum CodingKeys: String, CodingKey {
            case homepage = "homepage"
            case whitepaper = "whitepaper"
            case blockchainSite = "blockchain_site"
            case officialForumURL = "official_forum_url"
            case chatURL = "chat_url"
            case announcementURL = "announcement_url"
            case snapshotURL = "snapshot_url"
            case twitterScreenName = "twitter_screen_name"
            case facebookUsername = "facebook_username"
            case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
            case telegramChannelIdentifier = "telegram_channel_identifier"
            case subredditURL = "subreddit_url"
            case reposURL = "repos_url"
        }
    }
    
    struct ReposURL: Codable {
        let github: [String?]?
        let bitbucket: [String?]?
        
        enum CodingKeys: String, CodingKey {
            case github = "github"
            case bitbucket = "bitbucket"
        }
    }
    
    struct MarketData: Codable {
        let currentPrice: [String: Double?]?
        let totalValueLocked: Double?
        let mcapToTvlRatio: Double?
        let fdvToTvlRatio: Double?
        let ath: [String: Double?]?
        let athChangePercentage: [String: Double?]?
        let athDate: [String: String]?
        let atl: [String: Double?]?
        let atlChangePercentage: [String: Double?]?
        let atlDate: [String: String]?
        let marketCap: [String: Double?]?
        let marketCapRank: Int?
        let fullyDilutedValuation: [String: Double?]?
        let marketCapFdvRatio: Int?
        let totalVolume: [String: Double?]?
        let high24H: [String: Double?]?
        let low24H: [String: Double?]?
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
        let priceChange24HInCurrency: [String: Double]?
        let priceChangePercentage1HInCurrency: [String: Double?]?
        let priceChangePercentage24HInCurrency: [String: Double?]?
        let priceChangePercentage7DInCurrency: [String: Double?]?
        let priceChangePercentage14DInCurrency: [String: Double?]?
        let priceChangePercentage30DInCurrency: [String: Double?]?
        let priceChangePercentage60DInCurrency: [String: Double?]?
        let priceChangePercentage200DInCurrency: [String: Double?]?
        let priceChangePercentage1YInCurrency: [String: Double?]?
        let marketCapChange24HInCurrency: [String: Double?]?
        let marketCapChangePercentage24HInCurrency: [String: Double?]?
        let totalSupply: Double?
        let maxSupply: Double?
        let maxSupplyInfinite: Bool?
        let circulatingSupply: Double?
        let sparkline7D: Sparkline7D?
        let lastUpdated: String?
        
        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case totalValueLocked = "total_value_locked"
            case mcapToTvlRatio = "mcap_to_tvl_ratio"
            case fdvToTvlRatio = "fdv_to_tvl_ratio"
            case ath = "ath"
            case athChangePercentage = "ath_change_percentage"
            case athDate = "ath_date"
            case atl = "atl"
            case atlChangePercentage = "atl_change_percentage"
            case atlDate = "atl_date"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case marketCapFdvRatio = "market_cap_fdv_ratio"
            case totalVolume = "total_volume"
            case high24H = "high_24h"
            case low24H = "low_24h"
            case priceChange24H = "price_change_24h"
            case priceChangePercentage24H = "price_change_percentage_24h"
            case priceChangePercentage7D = "price_change_percentage_7d"
            case priceChangePercentage14D = "price_change_percentage_14d"
            case priceChangePercentage30D = "price_change_percentage_30d"
            case priceChangePercentage60D = "price_change_percentage_60d"
            case priceChangePercentage200D = "price_change_percentage_200d"
            case priceChangePercentage1Y = "price_change_percentage_1y"
            case marketCapChange24H = "market_cap_change_24h"
            case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
            case priceChange24HInCurrency = "price_change_24h_in_currency"
            case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
            case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
            case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
            case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
            case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
            case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
            case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
            case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
            case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
            case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
            case totalSupply = "total_supply"
            case maxSupply = "max_supply"
            case maxSupplyInfinite = "max_supply_infinite"
            case circulatingSupply = "circulating_supply"
            case sparkline7D = "sparkline_7d"
            case lastUpdated = "last_updated"
        }
    }
    
    struct Sparkline7D: Codable {
        let price: [Double]?

        enum CodingKeys: String, CodingKey {
            case price = "price"
        }
    }
}
