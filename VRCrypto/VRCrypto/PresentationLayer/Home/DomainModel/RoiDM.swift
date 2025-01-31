//
//  RoiDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

struct RoiDM {
    var times: Double?
    var currency: String?
    var percentage: Double?
    
    init?(response: CoinListResponse.Roi?) {
        guard let response else {
            return
        }
        self.times = response.times
        self.currency = response.currency
        self.percentage = response.percentage
    }
}
