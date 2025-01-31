//
//  VRCryptoApp.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import SwiftUI

@main
struct VRCryptoApp: App {

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Home", systemImage: "list.bullet") {
                    NavigationStack {
                        HomeView()
                    }
                }
                
                Tab("Portfolio", systemImage: "suitcase") {
                    NavigationStack {
                        Text("Portfolio")
                    }
                }
            }
        }
    }
}
