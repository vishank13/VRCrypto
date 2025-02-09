//
//  DetailsView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 07/02/25.
//

import SwiftUI

struct DetailsView: View {
    
    // MARK: - Properties
    @State var viewModel: DetailsViewModel
    
    // MARK: - Body
    var body: some View {
        VRStack(showLoader: $viewModel.showLoader) {
            ScrollView {
                VStack(spacing: 20.0) {
                    headerView
                    lineGraphView
                    coinOverviewView
                    marketDetailsView
                    linksView
                }
                .padding(.horizontal)
            }
        }
        .customNavigationBar(viewModel.navBarDep)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            viewModel.fetchCoinData()
        }
    }
}

#Preview {
    NavigationStack {
        DetailsView(viewModel: DetailsViewModel(model: DetailsModel(coinId: "bitcoin")))
    }
}

extension DetailsView {
    
    private var headerView: some View {
        HStack {
            VRText(viewModel.coinData?.name ?? "--",
                   style: .navTitle)
            
            CachedImageView(url: viewModel.coinData?.image?.small ?? "")
                .frame(width: 50, height: 50)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var lineGraphView: some View {
        if let marketData = viewModel.coinData?.marketData,
           let prices = marketData.sparkline7D {
            VRLineChartView(prices: prices,
                            lineColor: marketData.sparklineColor)
        }
    }
    
    @ViewBuilder
    private var coinOverviewView: some View {
        if let coinData = viewModel.coinData,
           let description = coinData.description {
            VStack {
                VRText("Overview",
                       style: .title)
                
                VRCollapsibleTextView(text: description,
                                      collapsedLines: 4)
                
                LazyVGrid(columns: viewModel.gridColumns, spacing: 20) {
                    VRGridItemView(title: "Symbol",
                                   value: coinData.symbol ?? "-")
                    
                    VRGridItemView(title: "Genesis Date",
                                   value: DateHelper.formatDate(coinData.genesisDate, to: .longDate))
                }
            }
        }
    }
    
    @ViewBuilder
    private var marketDetailsView: some View {
        if let coinData = viewModel.coinData,
           let marketData = coinData.marketData {
            VStack(spacing: 5) {
                VRText("Market Details",
                       style: .title)
                
                // High
                LazyVGrid(columns: viewModel.gridColumns, spacing: 10) {
                    VRGridItemView(title: "All Time High",
                                   value: marketData.ath?.toCurrency ?? "-")
                    
                    VRGridItemView(title: "All Time High Date",
                                   value: DateHelper.formatDate(marketData.athDate, to: .longDate))
                    
                    VRGridItemView(title: "All Time High Change %",
                                   value: marketData.athChangePercentage?.toPercentage ?? "-")
                    
                    VRGridItemView(title: "24Hr High",
                                   value: marketData.high24H?.toCurrency  ?? "-")
                    
                    VRGridItemView(title: "7Days High",
                                   value: marketData.sparkline7D?.max()?.toCurrency  ?? "-")
                }
                
                Divider().padding(.vertical)
                
                // Low
                LazyVGrid(columns: viewModel.gridColumns, spacing: 10) {
                    VRGridItemView(title: "All Time Low",
                                   value: marketData.atl?.toCurrency ?? "-")
                    
                    VRGridItemView(title: "All Time Low Date",
                                   value: DateHelper.formatDate(marketData.atlDate, to: .longDate))
                    
                    VRGridItemView(title: "All Time Low Change %",
                                   value: marketData.atlChangePercentage?.toPercentage ?? "-")
                    
                    VRGridItemView(title: "24Hr Low",
                                   value: marketData.low24H?.toCurrency  ?? "-")
                    
                    VRGridItemView(title: "7Days Low",
                                   value: marketData.sparkline7D?.min()?.toCurrency  ?? "-")
                }
            }
        }
    }
    
    @ViewBuilder
    private var linksView: some View {
        if let links = viewModel.coinData?.links {
            VStack {
                VRText("Links",
                       style: .title)
                
                getLinkView("Homepage", urlString: links.homepage?.first)
                
                getLinkView("Whitepaper", urlString: links.whitepaper)
                
                getLinkView("Official Forum", urlString: links.officialForumURL?.first)
                
                if let github = links.reposURL?.github, !github.isEmpty {
                    VRText("Github",
                           style: .headline)
                    .padding(.top, 5)
                    
                    ForEach(github, id: \.self) { link in
                        getLinkView(urlString: link)
                    }
                }
                
                if let bitbucket = links.reposURL?.bitbucket, !bitbucket.isEmpty {
                    VRText("Bitbucket",
                           style: .headline)
                    .padding(.top, 5)
                    
                    ForEach(bitbucket, id: \.self) { link in
                        getLinkView(urlString: link)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func getLinkView(_ title: String? = nil, urlString: String?) -> some View {
        if let url = URL(string: urlString ?? "") {
            Link(destination: url) {
                VRText(title ?? urlString ?? "",
                       style: .subheadline,
                       foreground: .blue)
            }
        }
    }
}
