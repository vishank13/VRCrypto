//
//  LinksDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//


struct LinksDM {
    let homepage: [String]?
    let whitepaper: String?
    let blockchainSite: [String]?
    let officialForumURL: [String]?
    let chatURL: [String]?
    let announcementURL: [String]?
    let snapshotURL: String?
    let twitterScreenName: String?
    let facebookUsername: String?
    let bitcointalkThreadIdentifier: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    let reposURL: ReposURLDM?
    
    init?(response: CoinDataResponse.Links?) {
        guard let response else {
            return nil
        }
        self.homepage = response.homepage?.compactMap { $0 }
        self.whitepaper = response.whitepaper
        self.blockchainSite = response.blockchainSite?.compactMap { $0 }
        self.officialForumURL = response.officialForumURL?.compactMap { $0 }
        self.chatURL = response.chatURL?.compactMap { $0 }
        self.announcementURL = response.announcementURL?.compactMap { $0 }
        self.snapshotURL = response.snapshotURL
        self.twitterScreenName = response.twitterScreenName
        self.facebookUsername = response.facebookUsername
        self.bitcointalkThreadIdentifier = response.bitcointalkThreadIdentifier
        self.telegramChannelIdentifier = response.telegramChannelIdentifier
        self.subredditURL = response.subredditURL
        self.reposURL = .init(response: response.reposURL)
    }
}
