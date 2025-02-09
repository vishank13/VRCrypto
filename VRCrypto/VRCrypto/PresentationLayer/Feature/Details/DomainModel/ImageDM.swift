//
//  ImageDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//


struct ImageDM {
    let thumb: String?
    let small: String?
    let large: String?
    
    init?(response: CoinDataResponse.Image?) {
        guard let response else {
            return nil
        }
        self.thumb = response.thumb
        self.small = response.small
        self.large = response.large
    }
}
