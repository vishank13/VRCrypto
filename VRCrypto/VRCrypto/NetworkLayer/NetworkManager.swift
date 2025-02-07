//
//  NetworkManager.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation
import Combine

/// `NetworkManager` is a singleton class responsible for handling network requests.
/// It provides methods to fetch data using both completion handlers and Combine's `Future`.
///
/// ### Features:
/// - Uses `URLSession` for networking.
/// - Supports `Combine` for reactive programming.
/// - Caches `Cancellable` instances to prevent memory leaks.
/// - Provides structured error handling.
/// - Logs network responses for debugging.
///
/// Usage:
/// ```swift
/// NetworkManager.shared.makeRequest(req: YourAPIRequest()) { (result: YourModel) in
///     print(result)
/// }
/// ```
///
/// Or using Combine:
/// ```swift
/// NetworkManager.shared.getData(req: YourAPIRequest())
///     .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
///     .store(in: &cancellables)
/// ```
class NetworkManager {
    
    /// Shared singleton instance for centralized network requests.
    static let shared = NetworkManager()
    
    /// Stores Combine subscriptions to prevent memory leaks.
    private var cancellables = Set<AnyCancellable>()
    
    /// Default HTTP request headers.
    private let headers: [String: String] = [
        "accept": "application/json",
        "x-cg-demo-api-key": "CG-mZ4i8Ph6dRDC5ruJNbvQu5"
    ]
    
    /// Private initializer to enforce the singleton pattern.
    private init() {}

    /// Creates a configured `URLRequest` with necessary headers.
    ///
    /// - Parameter url: The target URL.
    /// - Returns: A configured `URLRequest` instance.
    private func createRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    /// Logs network request and response details for debugging.
    ///
    /// - Parameters:
    ///   - url: The requested URL.
    ///   - response: The HTTP response object.
    ///   - data: The raw response data.
    private func logResponse(url: URL, response: HTTPURLResponse, data: Data) {
        print("\n:::::::::::::::::::::::::::")
        debugPrint("REQUEST PATH: \(url)")
        debugPrint("RESPONSE STATUS CODE: \(response.statusCode)")
        print("RESPONSE DATA----------")
        print(String(data: data, encoding: .utf8) ?? "No response body")
        print("::::::::::::::::::::::::::: \n")
    }
    
    /// Validates the HTTP response and extracts data.
    ///
    /// - Parameters:
    ///   - response: The `URLResponse` received from the request.
    ///   - data: The raw response data.
    /// - Throws: A `NetworkError` if validation fails.
    /// - Returns: The validated response data.
    private func validateResponse(_ response: URLResponse?, _ data: Data?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode), let data = data else {
            throw NetworkError.responseError(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
    
    /// Executes a network request using a completion handler.
    ///
    /// - Parameters:
    ///   - req: The API request conforming to `BaseRequestProtocol`.
    ///   - completion: A closure with a decoded model of type `T`.
    ///
    /// Usage:
    /// ```swift
    /// NetworkManager.shared.makeRequest(req: YourAPIRequest()) { (result: YourModel) in
    ///     print(result)
    /// }
    /// ```
    func makeRequest<T: Codable>(req: BaseRequestProtocol, completion: @escaping ((T) -> Void)) {
        
        guard let url = req.url else {
            print("Invalid URL")
            return
        }
        
        let request = createRequest(for: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint("Request error:", error.localizedDescription)
                return
            }
            
            do {
                let validatedData = try self.validateResponse(response, data)
                let json = try JSONDecoder().decode(T.self, from: validatedData)
                
                DispatchQueue.main.async {
                    completion(json)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    self.logResponse(url: url, response: httpResponse, data: validatedData)
                }
            } catch {
                print("Error processing request \(url):", error)
            }
        }.resume()
    }
    
    /// Fetches data using Combine's `Future`, allowing for a reactive programming approach.
    ///
    /// - Parameter req: The API request conforming to `BaseRequestProtocol`.
    /// - Returns: A `Future<T, Error>` publisher containing the decoded response.
    ///
    /// Usage:
    /// ```swift
    /// NetworkManager.shared.getData(req: YourAPIRequest())
    ///     .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
    ///     .store(in: &cancellables)
    /// ```
    func getData<T: Codable>(req: BaseRequestProtocol) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self, let url = req.url else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            print("Fetching data from:", url.absoluteString)
            
            let request = self.createRequest(for: url)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    return try self.validateResponse(response, data)
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
        }
    }
}

/// Enum representing possible network errors.
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case responseError(statusCode: Int)
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .responseError(let statusCode):
            return "Unexpected status code: \(statusCode)"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
