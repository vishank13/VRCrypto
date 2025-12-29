//
//  SettingsView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 28/02/25.
//

import SwiftUI

struct SettingsView: View {
    
    @State var currentTab: TabItem = .favorites
    
    var body: some View {
        VStack {
            VRScrollableTabBar(tabs: TabItem.allCases,
                               selectedTab: $currentTab)
            
            TabView(selection: $currentTab) {
                ForEach(TabItem.allCases) { tab in
                    Text("Content for: \(tab.rawValue)")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .tag(tab)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
    }
}

#Preview {
    SettingsView()
}
