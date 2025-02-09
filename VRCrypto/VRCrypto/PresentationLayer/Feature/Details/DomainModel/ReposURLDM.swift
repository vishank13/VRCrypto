//
//  ReposURLDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//


struct ReposURLDM {
    let github: [String]?
    let bitbucket: [String]?
    
    init?(response: CoinDataResponse.ReposURL?) {
        guard let response else {
            return nil
        }
        self.github = response.github?.compactMap { $0 }
        self.bitbucket = response.bitbucket?.compactMap { $0 }
    }
}