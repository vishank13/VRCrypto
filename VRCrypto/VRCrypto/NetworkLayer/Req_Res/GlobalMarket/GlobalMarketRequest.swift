//
//  GlobalMarketRequest.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 01/02/25.
//

import Foundation

struct GlobalMarketRequest: BaseRequestProtocol {
    
    var url: URL? {
        ApiPaths.globalMarket.url
    }
    
}
