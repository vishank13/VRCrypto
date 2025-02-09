//
//  ApiPaths.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation

/// Enum representing different API endpoints for the CoinGecko API.
///
/// `ApiPaths` helps in constructing URLs dynamically for various API requests.
/// It supports different endpoints and handles query parameters efficiently.
///
/// ## Example Usage:
/// ```swift
/// if let url = ApiPaths.coinsList.url {
///     print("Coins List API URL: \(url)")
/// }
/// ```
///
/// ## Supported Endpoints:
/// - `coinsList`: Fetches market data for coins.
/// - `globalMarket`: Fetches global market data.
enum ApiPaths {

    case coinsList
    case globalMarket
    case coinData(String)
}

extension ApiPaths {
    
    /// The API base host.
    private var host: String {
        "api.coingecko.com"
    }
    
    /// The endpoint path for each API request.
    private var path: String {
        switch self {
        case .coinsList:
            return "/api/v3/coins/markets"
        case .globalMarket:
            return "/api/v3/global"
        case .coinData(let coinId):
            return "/api/v3/coins/\(coinId)"
        }
    }
    
    /// Query parameters required for specific API requests.
    private var queryItems: [String: String]? {
        switch self {
        case .coinsList:
            return [
                "vs_currency": "usd",
                "order": "market_cap_desc",
                "per_page": "250",
                "sparkline": "true",
                "price_change_percentage": "24h",
                "precision": "2"
            ]
        case .coinData(_):
            return [
                "localization":"false",
                "tickers":"false",
                "market_data":"true",
                "community_data":"false",
                "developer_data":"false",
                "sparkline":"true"
            ]
        default:
            return nil
        }
    }
    
    /// Constructs and returns the complete API URL.
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.host
        urlComponents.path = self.path
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return urlComponents.url
    }
}
