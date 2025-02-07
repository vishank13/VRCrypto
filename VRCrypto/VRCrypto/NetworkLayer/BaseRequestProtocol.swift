//
//  BaseRequestProtocol.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation

/// A protocol defining the base structure for API requests.
///
/// `BaseRequestProtocol` ensures that any conforming type provides a URL for making network requests.
///
/// ## Usage Example:
/// ```swift
/// struct CoinListRequest: BaseRequestProtocol {
///     var url: URL? {
///         return ApiPaths.coinsList.url
///     }
/// }
///
/// let request = CoinListRequest()
/// print("Request URL: \(request.url?.absoluteString ?? "Invalid URL")")
/// ```
///
/// This protocol is intended to be used with API request types to standardize URL handling.
protocol BaseRequestProtocol {
    
    /// The URL for the API request.
    var url: URL? { get }
}
