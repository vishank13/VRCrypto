//
//  DetailsModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

struct DetailsModel {
    var coinId: String?
    var coinData: CoinDataDM?
    
    init(coinId: String?) {
        self.coinId = coinId
    }
}
