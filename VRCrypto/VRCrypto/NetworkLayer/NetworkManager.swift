//
//  NetworkManager.swift
//  VRCrypto
//
//  Created by Vishank Raghav on 30/01/25.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    private let  headers = [
        "accept": "application/json",
        "x-cg-demo-api-key": "CG-mZ4i8Ph6dRDC5ruJNbvQu5sU"
    ]
    
    func makeRequest<T: Codable>(req: BaseRequestProtocol,
                                 completion: @escaping ((T)->Void)) {
        
        guard let url = req.url else {
            print("invalid URL")
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                debugPrint(error as Any)
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode,
                      let data else {
                    debugPrint("Error in status code")
                    return
                }
                
                if let json = try? JSONDecoder().decode(T.self, from: data) {
                    print("\n :::::::::::::::::::::::::::")
                    debugPrint("REQUEST PATH: \(url)")
                    debugPrint("RESPONSE STATUS CODE: \(httpResponse.statusCode)")
                    print("RESPONSE DATA----------")
                    print(String(data: data, encoding: .utf8) ?? "")
                    print("::::::::::::::::::::::::::: \n")
                    completion(json)
                } else {
                    print("FAILED TO DECODE!!!!! \(url)")
                }
            }
        }
        
        dataTask.resume()
    }
    
    func getData<T: Codable>(req: BaseRequestProtocol) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self, let url = req.url else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            print("URL is \(url.absoluteString)")
            
            let request = NSMutableURLRequest(url: url,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTaskPublisher(for: request as URLRequest)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: {  data in
                    print(data)
                    promise(.success(data)
                    ) })
                .store(in: &self.cancellables)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
