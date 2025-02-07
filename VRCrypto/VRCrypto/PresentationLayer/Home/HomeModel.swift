//
//  HomeModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

struct HomeModel {
    
    var globalMarket: GlobalMarketDM?
    var coinListDM: [CoinListDM] = []
    var tempCoinListDM: [CoinListDM] = []
    
    var showInfoSheet = false
    var searchStr: String = ""
    var sortByPriceChange: Bool = false
    var sortByPrice: Bool = false
    
}
