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
    
    var body: some View {
        VRStack(showLoader: $viewModel.showLoader) {
            VStack {
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
                
                if viewModel.tempCoinListDM.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchStr)
                } else {
                    List(viewModel.tempCoinListDM) { coin in
                        HStack(alignment: .center) {
                            CachedImageVew(url: coin.smallImage)
                                .frame(width: 50, height: 50)
                            
                            VStack {
                                HStack {
                                    Text(coin.name ?? "--")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text(coin.currentPrice?.toCurrency ?? "")
                                        .font(.headline)
                                }
                                
                                HStack {
                                    Text(coin.symbol ?? "--")
                                        .font(.callout)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text(coin.priceChange24H?.toCurrency ?? "")
                                        
                                        Image(systemName: coin.priceChangePercentage24H ?? 0 > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                                        
                                        Text(coin.priceChangePercentage24H?.toPercentage ?? "")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(coin.priceChangePercentage24H ?? 0 > 0 ? Color(.vrGreen) : Color(.vrRed))
                                }
                            }
                            .lineLimit(1)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.vrBackground))
                    }
                    .contentMargins(.bottom, 40, for: .scrollContent)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .overlay(alignment: .bottomLeading) {
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
                                .frame(width: 1)
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
                                .frame(width: 1)
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
            }
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
        }
        .sheet(isPresented: $showInfoSheet) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Vishank Raghav")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.accentColor)
                    .padding(.vertical)
                
                ScrollView {
                    
                }
            }
            .padding(.vertical)
            .background(Color(.vrBackground))
            .presentationDetents([.fraction(0.5), .fraction(0.92)])
        }
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
