//
//  DetailsViewModel.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI
import Combine

@Observable
class DetailsViewModel: VRViewModel {
    
    // MARK: - Properties
    private var model: DetailsModel
    private var cancellables = Set<AnyCancellable>()
    
    @ObservationIgnored
    lazy var navBarDep: NavigationBarConfig = {
        .init(title: "Coin Details")
    }()
    
    @ObservationIgnored
    lazy var gridColumns: [GridItem] = {
        Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    }()
    
    // MARK: - Initialization
    init(model: DetailsModel) {
        self.model = model
        super.init()
        self.cancellables = cancellables
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func fetchCoinData() {
//        self.loaderAppearance(true)
//        guard let coinDataRes = Bundle.main.decode(CoinDataResponse.self,
//                                                   from: "CoinData.json") else {
//            return
//        }
//        
//        model.coinData = CoinDataDM(response: coinDataRes)
//        self.loaderAppearance(false)
        guard let id = model.coinId else {
            return
        }
        self.loaderAppearance(true)
        NetworkManager.shared.getData(req: CoinDataRequest(coinID: id))
            .sink { completionStatus in
                switch completionStatus {
                case .failure(let err):
                    print("Coin Data API Error: \(err.localizedDescription)")
                case .finished:
                    print("Coin Data API Finished")
                }
            } receiveValue: { [weak self] (response: CoinDataResponse) in
                self?.model.coinData = CoinDataDM(response: response)
                self?.loaderAppearance(false)
            }
            .store(in: &cancellables)
    }
}

extension DetailsViewModel {
    
    var coinData: CoinDataDM? {
        get { model.coinData }
    }
}
