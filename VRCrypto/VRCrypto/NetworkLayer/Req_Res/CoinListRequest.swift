//
//  CoinListRequest.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 31/01/25.
//

import Foundation

struct CoinListRequest: BaseRequestProtocol {
    
    var url: URL? {
        ApiPaths.coinsMarket.url
    }
    
}
