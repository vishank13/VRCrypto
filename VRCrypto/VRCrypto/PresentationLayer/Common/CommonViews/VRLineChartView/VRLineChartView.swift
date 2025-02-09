//
//  VRLineChartView.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 08/02/25.
//

import SwiftUI

/// A customizable **Line Chart View** to visualize price data over time.
///
/// This SwiftUI component takes an array of prices and plots them as a **smooth animated line graph**.
/// It automatically calculates the **min, mid, and max values** and overlays them for better readability.
///
/// The chart supports **custom line colors, animation, and visual styling** with rounded corners and shadow effects.
///
/// # Example Usage:
/// ```swift
/// VRLineChartView(prices: [1000.5, 1055.2, 980.4, 1102.8, 1075.3])
///     .frame(height: 200)  // Set chart height
/// ```
///
/// - Author: Vishank Raghav
/// - Version: 1.0
///
struct VRLineChartView: View {
    
    /// The array of **crypto prices** over a given period.
    var prices: [Double]
    
    /// The **color of the line** in the graph. Default is **blue**.
    var lineColor: Color = .blue
    
    /// The **thickness** of the line. Default is **2.0**.
    var lineWidth: CGFloat = 2.0
    
    /// The **duration of the animation** in seconds. Default is **1.0**.
    var animationDuration: Double = 2.0
    
    /// **State variable** to control the **animation progress**.
    @State private var animatedProgress: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let maxPrice = prices.max() ?? 1  // Avoid division by zero
            let minPrice = prices.min() ?? 0
            let midPrice = (maxPrice + minPrice) / 2
            let priceRange = maxPrice - minPrice
            
            let width = geometry.size.width
            let height = geometry.size.height
            let stepX = width / CGFloat(prices.count - 1)  // Horizontal spacing
            
            ZStack {
                /// **Overlay lines for Min, Mid & Max values**
                overlayLine(height: height, price: minPrice)
                overlayLine(height: height, price: midPrice)
                overlayLine(height: height, price: maxPrice)
                
                /// **Line Chart Path**
                Path { path in
                    for (index, price) in prices.enumerated() {
                        let x = stepX * CGFloat(index)
                        let y = height - ((CGFloat(price - minPrice) / CGFloat(priceRange)) * height)
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .trim(from: 0, to: animatedProgress)
                .stroke(lineColor, lineWidth: lineWidth)
                .shadow(color: lineColor.opacity(0.5),
                        radius: 3, x: 0, y: 0)
                .animation(.easeInOut(duration: animationDuration), value: animatedProgress)
                .onAppear {
                    animatedProgress = 1  // Trigger animation on appear
                }
            }
        }
        .frame(height: 200)  // Default chart height
        .padding(.vertical)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color(.vrWhiteBlack)))
    }
    
    /// **Creates an overlay line with a label** for min, mid, or max price levels.
    ///
    /// - Parameters:
    ///   - height: The total height of the chart.
    ///   - price: The price value where the overlay should be placed.
    ///   - label: A string label displayed on the overlay line.
    /// - Returns: A `View` containing the overlay line and label.
    private func overlayLine(height: CGFloat, price: Double) -> some View {
        GeometryReader { _ in
            let minPrice = prices.min() ?? 0
            let maxPrice = prices.max() ?? 1
            let priceRange = maxPrice - minPrice
            
            let yPosition = height - ((CGFloat(price - minPrice) / CGFloat(priceRange)) * height)
            
            return AnyView(
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.secondary.opacity(0.5))
                        .offset(y: yPosition)
                    
                    VRText(price.toCurrency,
                           style: .caption,
                           foreground: .secondary)
                        .offset(y: yPosition - 10)
                        .padding(.leading, 5)
                }
            )
        }
    }
}
