//
//  ApiPaths.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation

enum ApiPaths {

    case coinsList
    case globalMarket
}

extension ApiPaths {
    
    private var host: String {
        "api.coingecko.com"
    }
    
    private var path: String {
        switch self {
        case .coinsList:
            "/api/v3/coins/markets"
        case .globalMarket:
            "/api/v3/global"
        }
    }
    
    private var queryItems: [String: String]? {
        switch self {
        case .coinsList:
            return ["vs_currency":"INR",
                    "order":"market_cap_desc",
                    "per_page":"250",
                    "sparkline":"true",
                    "price_change_percentage":"24h",
                    "precision":"2"]
        default:
            return nil
        }
    }
    
    var url: URL? {
        var urlComp = URLComponents()
        
        urlComp.scheme = "https"
        urlComp.host = self.host
        urlComp.path = self.path
        
        var reqQueryItems = [URLQueryItem]()
        
        let _ = queryItems?.compactMap { item in
            reqQueryItems.append(URLQueryItem(name: item.key,
                                              value: item.value))
        }
        
        urlComp.queryItems = reqQueryItems
        
        return urlComp.url
    }
}
