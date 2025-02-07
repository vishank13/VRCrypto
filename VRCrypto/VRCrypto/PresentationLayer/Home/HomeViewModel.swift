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
    
    // MARK: - Properties
    private var model: HomeModel
    private var cancellables = Set<AnyCancellable>()
    
    @ObservationIgnored
    lazy var navBarDep: NavigationBarConfig = {
        .init(title: "VR Crypto",
              titleDisplayMode: .large,
              leadingSystemImage: "arrow.clockwise",
              leadingAction: { [weak self] in
            self?.fetchData()
        },
              trailingSystemImage: "info.circle",
              trailingAction: { [weak self] in
            self?.model.showInfoSheet.toggle()
        })
    }()
    
    // MARK: - Initialization
    init(model: HomeModel = HomeModel()) {
        self.model = model
        super.init()
        self.cancellables = cancellables
        self.fetchData()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Data Fetching
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        self.loaderAppearance(true)
        
        dispatchGroup.enter()
        fetchCoinList {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchGlobalMarket {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.loaderAppearance(false)
        }
    }
    
    private func fetchCoinList(completion: @escaping () -> Void) {
        //        let coinListRes = Bundle.main.decode([CoinListResponse].self,
        //                                             from: "CoinList.json")
        //        coinListDM = coinListRes?.compactMap(CoinListDM.init) ?? []
        //        tempCoinListDM = coinListDM
        
        //        NetworkManager.shared.makeRequest(req: CoinListRequest()) { [weak self] (response: [CoinListResponse]) in
        //            self?.coinListDM = response.compactMap(CoinListDM.init)
        //        }
        
        NetworkManager.shared.getData(req: CoinListRequest())
            .sink { completionStatus in
                switch completionStatus {
                case .failure(let err):
                    print("Coin List API Error: \(err.localizedDescription)")
                case .finished:
                    print("Coin List API Finished")
                }
                completion()
            } receiveValue: { [weak self] (response: [CoinListResponse]) in
                self?.model.coinListDM = response.compactMap(CoinListDM.init)
                self?.model.tempCoinListDM = self?.model.coinListDM ?? []
            }
            .store(in: &cancellables)
    }
    
    private func fetchGlobalMarket(completion: @escaping () -> Void) {
        NetworkManager.shared.getData(req: GlobalMarketRequest())
            .sink { completionStatus in
                switch completionStatus {
                case .failure(let err):
                    print("Global Market API Error: \(err.localizedDescription)")
                case .finished:
                    print("Global Market API Finished")
                }
                completion()
            } receiveValue: { [weak self] (response: GlobalMarketResponse) in
                self?.model.globalMarket = .init(response: response.data)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Search & Sorting
    func handleSearch() {
        if model.searchStr.isEmpty {
            model.tempCoinListDM = model.coinListDM
            return
        }
        
        let lowercasedSearch = model.searchStr.lowercased()
        
        model.tempCoinListDM = model.coinListDM.filter { item in
            item.name?.lowercased().contains(lowercasedSearch) ?? false ||
            item.symbol?.lowercased().contains(lowercasedSearch) ?? false ||
            item.id?.lowercased().contains(lowercasedSearch) ?? false
        }
    }
    
    func handlePriceChange(desc: Bool) {
        model.tempCoinListDM = model.coinListDM.sorted {
            let lhs = $0.priceChange24H ?? 0
            let rhs = $1.priceChange24H ?? 0
            return desc ? lhs > rhs : lhs < rhs
        }
        model.sortByPriceChange = true
        model.sortByPrice = false
    }
    
    func handlePrice(desc: Bool) {
        model.tempCoinListDM = model.coinListDM.sorted {
            let lhs = $0.currentPrice ?? 0
            let rhs = $1.currentPrice ?? 0
            return desc ? lhs > rhs : lhs < rhs
        }
        model.sortByPriceChange = false
        model.sortByPrice = true
    }
    
    func restSorting() {
        model.tempCoinListDM = model.coinListDM
        model.sortByPriceChange = false
        model.sortByPrice = false
    }
}

extension HomeViewModel {
    
    var globalMarket: GlobalMarketDM? {
        get { model.globalMarket }
    }
    
    var coinListDM: [CoinListDM] {
        get { model.coinListDM }
    }
    
    var tempCoinListDM: [CoinListDM] {
        get { model.tempCoinListDM }
    }
    
    var showInfoSheet: Bool {
        get { model.showInfoSheet }
        set { model.showInfoSheet = newValue }
    }
    
    var searchStr: String {
        get { model.searchStr }
        set { model.searchStr = newValue }
    }
    
    var sortByPriceChange: Bool {
        get { model.sortByPriceChange }
    }
    
    var sortByPrice: Bool {
        get { model.sortByPrice }
    }
}
