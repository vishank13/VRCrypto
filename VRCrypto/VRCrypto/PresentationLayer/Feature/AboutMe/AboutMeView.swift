//
//  AboutMeView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 09/02/25.
//

import SwiftUI

struct AboutMeView: View {
    
    var body: some View {
        VRStack {
            ScrollView {
                VStack(spacing: 25) {
                    Image(.profilePicture)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                    // Name & Role
                    VStack {
                        VRText("Vishank Raghav",
                               style: .navTitle,
                               alignment: .center)
                        
                        VRText("iOS Developer | 4yrs+ Experience",
                               style: .headline,
                               alignment: .center)
                        
                        // Social Links
                        HStack {
                            if let link = URL(string: "www.linkedin.com/in/vishank-raghav") {
                                Link(destination: link) {
                                    VRText("LinkedIn",
                                           style: .subheadline,
                                           alignment: .center,
                                           foreground: .blue)
                                }
                            }
                            
                            if let link = URL(string: "https://github.com/vishank13") {
                                Link(destination: link) {
                                    VRText("github",
                                           style: .subheadline,
                                           alignment: .center,
                                           foreground: .blue)
                                }
                            }
                        }
                    }
                    
                    // About Description
                    VRText("Experienced iOS Developer with expertise in building high-performance, user-centric applications across banking, travel, healthcare, and finance. Proficient in Swift, SwiftUI, UIKit, and Core Data, with strong skills in developing reusable components, transaction workflows, data synchronization, and real-time updates. Ensures compliance with industry standards (GDPR, PCI) and delivers reliable apps through rigorous testing. Adept at collaborating in agile environments and integrating RESTful APIs for seamless user experiences. Passionate about performance, scalability, and best coding practices. Open to discussions on mobile app development and SwiftUI innovations.",
                           style: .callout,
                           alignment: .center)
                    .multilineTextAlignment(.center)
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AboutMeView()
    }
}
