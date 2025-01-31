//
//  HomeViewModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    
    var coinListDM: [CoinListDM] = []
    
    init() {
        fetchCoinList()
    }
    
    func fetchCoinList() {
        let coinListRes = Bundle.main.decode([CoinListResponse].self,
                                      from: "CoinList.json")
        coinListDM = coinListRes.compactMap(CoinListDM.init)
    }
}
