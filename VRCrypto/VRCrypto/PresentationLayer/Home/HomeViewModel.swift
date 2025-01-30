//
//  HomeViewModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    
    var coinList: [CoinListResponse] = []
    
    init() {
        fetchCoinList()
    }
    
    func fetchCoinList() {
        coinList = Bundle.main.decode([CoinListResponse].self,
                                      from: "CoinList.json")
    }
}
