//
//  HomeView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: HomeViewModel = HomeViewModel()
    @State var priceChangeDesc: Bool = true
    @State var priceDesc: Bool = true
    @State var showInfoSheet: Bool = false
    @State var showSort: Bool = false
    
    var body: some View {
        VRStack(showLoader: $viewModel.showLoader) {
            VStack {
                if viewModel.searchStr.isEmpty {
                    globalMarketInfo
                }
                
                searchTextFieldView
                
                if viewModel.tempCoinListDM.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchStr)
                } else {
                    coinListView
                }
            }
            .animation(.smooth, value: viewModel.searchStr.isEmpty)
        }
        .navigationTitle("VR Crypto")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfoSheet.toggle()
                } label : {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color.accentColor)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.fetchData()
                } label : {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .sheet(isPresented: $showInfoSheet) {
            InfoSheetView
                .modifier(SheetTitleModifier(title: "Vishank Raghav"))
        }
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    
    private var globalMarketInfo: some View {
        HStack {
            getInfoView("Total Market Cap",
                        viewModel.globalMarket?.totalMarketCapINR)
            
            getInfoView("Total Volume",
                        viewModel.globalMarket?.totalVolumeINR)
            
            getInfoView("Market Cap %",
                        viewModel.globalMarket?.marketCapPercentageBTC)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    private func getInfoView(_ title: String, _ value: String?) -> some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.accentColor)
            Text(value ?? "")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var searchTextFieldView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.accentColor)
            
            TextField("Search", text: $viewModel.searchStr)
                .autocorrectionDisabled(true)
                .onChange(of: viewModel.searchStr) {
                    viewModel.handleSearch()
                }
            if !viewModel.searchStr.isEmpty {
                Button {
                    viewModel.searchStr.removeAll()
                } label : {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .padding(10)
        .background {
            Capsule()
                .fill(Color(.vrWhiteBlack))
        }
        .padding(.horizontal)
    }
    
    private var coinListView: some View {
        List(viewModel.tempCoinListDM) { coin in
            HStack(alignment: .center) {
                CachedImageVew(url: coin.smallImage)
                    .frame(width: 50, height: 50)
                
                VRDoubleLineRowView(dataRow: coin)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color(.vrBackground))
        }
        .contentMargins(.bottom, 40, for: .scrollContent)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .onScrollPhaseChange({ old, new in
            if new == .idle {
                showSort = true
            } else {
                showSort = false
            }
        })
        .overlay(alignment: .bottomLeading) {
            if showSort {
                sortingIslandView
            }
        }
    }
    
    private var InfoSheetView: some View {
        ScrollView {
            Text("About Me!")
        }
    }
    
    private var sortingIslandView: some View {
        HStack {
            Button {
                if !viewModel.sortByPriceChange {
                    priceDesc.toggle()
                }
                viewModel.handlePrice(desc: priceDesc)
            } label : {
                HStack {
                    Text("Price")
                    
                    Image(systemName: "arrow.up")
                        .rotationEffect(Angle(degrees: priceDesc ? 0 : 180))
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.sortByPrice ?  Color.accentColor : Color.secondary)
                
            }
            
            Rectangle()
                .frame(width: 1, height: 15)
                .foregroundStyle(Color.accentColor)
            
            Button {
                if !viewModel.sortByPrice {
                    priceChangeDesc.toggle()
                }
                viewModel.handlePriceChange(desc: priceChangeDesc)
            } label : {
                HStack {
                    Text("Price Change")
                    
                    Image(systemName: "arrow.up")
                        .rotationEffect(Angle(degrees: priceChangeDesc ? 0 : 180))
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.sortByPriceChange ?  Color.accentColor : Color.secondary)
                
            }
            
            Rectangle()
                .frame(width: 1, height: 15)
                .foregroundStyle(Color.accentColor)
            
            Button {
                viewModel.restSorting()
            } label : {
                Text("Reset")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                
            }
            .disabled(!(viewModel.sortByPriceChange || viewModel.sortByPrice))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background {
            Capsule()
                .fill(Color(.vrWhiteBlack))
        }
        .padding()
    }
}
