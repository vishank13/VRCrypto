//
//  CoinDataDM.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//


struct CoinDataDM {
    let id: String?
    let symbol: String?
    let name: String?
    let webSlug: String?
    let assetPlatformID: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let publicNotice: String?
    let additionalNotices: [String]?
    let description: String?
    let links: LinksDM?
    let image: ImageDM?
    let countryOrigin: String?
    let genesisDate: String?
    let sentimentVotesUpPercentage: Double?
    let sentimentVotesDownPercentage: Double?
    let watchlistPortfolioUsers: Int?
    let marketCapRank: Int?
    let marketData: MarketDataDM?
    let lastUpdated: String?
    
    init(response: CoinDataResponse) {
        self.id = response.id
        self.symbol = response.symbol
        self.name = response.name
        self.webSlug = response.webSlug
        self.assetPlatformID = response.assetPlatformID
        self.blockTimeInMinutes = response.blockTimeInMinutes
        self.hashingAlgorithm = response.hashingAlgorithm
        self.categories = response.categories?.compactMap { $0 }
        self.previewListing = response.previewListing
        self.publicNotice = response.publicNotice
        self.additionalNotices = response.additionalNotices?.compactMap { $0 }
        self.description = response.description?.en?.stripHTML
        self.links = .init(response: response.links)
        self.image = .init(response: response.image)
        self.countryOrigin = response.countryOrigin
        self.genesisDate = response.genesisDate
        self.sentimentVotesUpPercentage = response.sentimentVotesUpPercentage
        self.sentimentVotesDownPercentage = response.sentimentVotesDownPercentage
        self.watchlistPortfolioUsers = response.watchlistPortfolioUsers
        self.marketCapRank = response.marketCapRank
        self.marketData = .init(response: response.marketData)
        self.lastUpdated = response.lastUpdated
    }
}
