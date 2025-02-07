//
//  HomeView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @State private var viewModel = HomeViewModel()
    @State private var priceChangeDesc = true
    @State private var priceDesc = true
    @State private var showSort = false
    
    // MARK: - Body
    var body: some View {
        VRStack(showLoader: $viewModel.showLoader) {
            VStack {
                globalMarketInfo
                searchTextFieldView
                if viewModel.tempCoinListDM.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchStr)
                } else {
                    coinListView
                }
            }
            .animation(.smooth, value: viewModel.searchStr.isEmpty)
        }
        .customNavigationBar(viewModel.navBarDep)
        .sheet(isPresented: $viewModel.showInfoSheet) {
            InfoSheetView
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    
    @ViewBuilder
    private var globalMarketInfo: some View {
        if viewModel.searchStr.isEmpty {
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
    }
    
    private func getInfoView(_ title: String,
                             _ value: String?) -> some View {
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
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .padding(10)
        .background(Capsule().fill(Color(.vrWhiteBlack)))
        .padding(.horizontal)
    }
    
    private var coinListView: some View {
        List(viewModel.tempCoinListDM) { coin in
            HStack {
                CachedImageVew(url: coin.smallImage)
                    .frame(width: 50, height: 50)
                
                VRDoubleLineRowView(dataRow: coin)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color(.vrBackground))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .contentMargins(.bottom, 40, for: .scrollContent)
        .onScrollPhaseChange { _, new in
            showSort = (new == .idle)
        }
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
        .modifier(SheetTitleModifier(title: "Vishank Raghav"))
    }
    
    private var sortingIslandView: some View {
        HStack {
            sortingButton(title: "Price",
                          isActive: viewModel.sortByPrice,
                          isDescending: priceDesc) {
                if !viewModel.sortByPriceChange {
                    priceDesc.toggle()
                }
                viewModel.handlePrice(desc: priceDesc)
            }
            
            dividerView
            
            sortingButton(title: "Price Change",
                          isActive: viewModel.sortByPriceChange,
                          isDescending: priceChangeDesc) {
                if !viewModel.sortByPrice {
                    priceChangeDesc.toggle()
                }
                viewModel.handlePriceChange(desc: priceChangeDesc)
            }
            
            dividerView
            
            Button("Reset") {
                viewModel.restSorting()
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(Color.accentColor)
            .disabled(!(viewModel.sortByPriceChange || viewModel.sortByPrice))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Capsule().fill(Color(.vrWhiteBlack)))
        .padding()
    }
    
    private func sortingButton(title: String,
                               isActive: Bool,
                               isDescending: Bool,
                               action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                Image(systemName: "arrow.up")
                    .rotationEffect(Angle(degrees: isDescending ? 0 : 180))
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(isActive ? Color.accentColor : Color.secondary)
        }
    }
    
    private var dividerView: some View {
        Rectangle()
            .frame(width: 1, height: 15)
            .foregroundStyle(Color.accentColor)
    }
}
