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
            List(viewModel.coinList) { coin in
                HStack {
                    AsyncCachedImage(url: coin.image?.replacingOccurrences(of: "/large/", with: "/small/") ?? "") { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                        case .failure(_):
                            ProgressView()
                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 40, height: 40)
                    
                    Text("\(coin.name ?? "--")")
                }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(.background))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("VR Crypto")
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
