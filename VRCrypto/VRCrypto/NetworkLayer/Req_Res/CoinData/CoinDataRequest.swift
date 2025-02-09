//
//  CoinDataRequest.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

import Foundation

struct CoinDataRequest: BaseRequestProtocol {
    
    var coinID: String
    
    init(coinID: String) {
        self.coinID = coinID
    }
    
    var url: URL? {
        ApiPaths.coinData(coinID).url
    }
    
}

