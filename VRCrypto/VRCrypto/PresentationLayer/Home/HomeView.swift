//
//  HomeView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VRStack {
            List(viewModel.coinListDM) { coin in
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
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("VR Crypto")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                } label : {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color.accentColor)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label : {
                    Image(systemName: "suitcase")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
