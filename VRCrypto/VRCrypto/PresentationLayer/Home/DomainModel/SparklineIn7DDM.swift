//
//  SparklineIn7DDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//


struct SparklineIn7DDM {
    var price: [Double]?
    
    init?(response: CoinListResponse.SparklineIn7D?) {
        guard let response else {
            return
        }
        self.price = response.price
    }
}
