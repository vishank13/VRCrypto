//
//  VRScrollableTabBar.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 28/02/25.
//

import SwiftUI

enum TabItem: String, CaseIterable, Identifiable {
    case home = "Home"
    case explore = "Explore"
    case profile = "Profile"
    case settings = "Settings"
    case more = "More"
    case favorites = "Favorites"
    case trending = "Trending"
    
    var id: String { self.rawValue }
}

struct VRScrollableTabBar: View {
    
    let tabs: [TabItem]
    
    @Binding var selectedTab: TabItem
    @State private var scrollPosition = ScrollPosition()
    
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(tabs) { tab in
                    getTabItem(for: tab)
                        .id(tab.id)
                        .onTapGesture {
                            selectedTab = tab
                            scrollPosition.scrollTo(id: tab.id,
                                                    anchor: .leading)
                        }
                }
            }
        }
                   .contentMargins(.horizontal,
                                   50,
                                   for: .scrollContent)
                   .scrollPosition($scrollPosition)
                   .onAppear {
                       scrollPosition.scrollTo(id: selectedTab.id,
                                               anchor: .center)
                   }
                   .onChange(of: selectedTab) { tab in
                       withAnimation {
                           scrollPosition.scrollTo(id: tab.id,
                                                   anchor: .center)
                       }
                   }
    }
    
    private func getTabItem(for tab: TabItem) -> some View {
        Text(tab.rawValue)
            .fontWeight(selectedTab == tab ? .bold : .regular)
            .padding(10)
            .background(selectedTab == tab ? Color.blue.opacity(0.2) : Color.clear)
            .cornerRadius(10)
    }
}
