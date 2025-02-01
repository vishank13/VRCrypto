//
//  HomeViewModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI
import Combine

@Observable
class HomeViewModel: VRViewModel {
    
    var globalMarket: GlobalMarketDM?
    var coinListDM: [CoinListDM] = []
    var tempCoinListDM: [CoinListDM] = []
    
    var searchStr: String = ""
    var sortByPriceChange: Bool = false
    var sortByPrice: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        fetchData()
    }
    
    deinit {
        let _ = cancellables.compactMap({$0.cancel()})
    }
    
    func fetchData() {
        fetchCoinList()
        fetchGlobalMarket()
    }
    
    func fetchCoinList() {
//        let coinListRes = Bundle.main.decode([CoinListResponse].self,
//                                      from: "CoinList.json")
//        coinListDM = coinListRes?.compactMap(CoinListDM.init) ?? []
//        tempCoinListDM = coinListDM
        self.loaderAppearance(true)
//        NetworkManager.shared.makeRequest(req: CoinListRequest()) { [weak self] (response: [CoinListResponse]) in
//            self?.loaderAppearance(false)
//            self?.coinListDM = response.compactMap(CoinListDM.init)
//        }
        
        NetworkManager.shared.getData(req: CoinListRequest())
            .sink { [weak self] completion in
                self?.loaderAppearance(false)
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] (response: [CoinListResponse]) in
                self?.coinListDM = response.compactMap(CoinListDM.init)
                self?.tempCoinListDM = response.compactMap(CoinListDM.init)
            }.store(in: &cancellables)
    }
    
    func fetchGlobalMarket() {
        self.loaderAppearance(true)
        NetworkManager.shared.getData(req: GlobalMarketRequest())
            .sink {  [weak self] completion in
                self?.loaderAppearance(false)
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] (response: GlobalMarketResponse) in
                self?.globalMarket = .init(response: response.data)
            }.store(in: &cancellables)
        
    }
    
    func handleSearch() {
        if searchStr.isEmpty {
            tempCoinListDM = coinListDM
            return
        }
        
        tempCoinListDM = coinListDM.filter { item in
            return item.name?.lowercased().contains(searchStr.lowercased()) ?? false ||
            item.symbol?.lowercased().contains(searchStr.lowercased()) ?? false ||
            item.id?.lowercased().contains(searchStr.lowercased()) ?? false
        }
    }
    
    func handlePriceChange(desc: Bool) {
        tempCoinListDM = coinListDM.sorted(by: {
            if desc {
                return $0.priceChange24H ?? 0 > $1.priceChange24H ?? 0
            } else {
                return $0.priceChange24H ?? 0 < $1.priceChange24H ?? 0
            }
        })
        sortByPriceChange = true
        sortByPrice = false
    }
    
    func handlePrice(desc: Bool) {
        tempCoinListDM = coinListDM.sorted(by: {
            if desc {
                return $0.currentPrice ?? 0 > $1.currentPrice ?? 0
            } else {
                return $0.currentPrice ?? 0 < $1.currentPrice ?? 0
            }
        })
        
        sortByPriceChange = false
        sortByPrice = true
    }
    
    func restSorting() {
        tempCoinListDM = coinListDM
        sortByPriceChange = false
        sortByPrice = false
    }
}
