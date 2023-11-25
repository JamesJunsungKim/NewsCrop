//
//  APIService.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation
import Combine

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIRequestType {
    var queryItems: [URLQueryItem]? { return nil }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<[Request.Response], APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://jsonplaceholder.typicode.com")!) {
        self.baseURL = baseURL
    }

    func response<Request>(from request: Request) -> AnyPublisher<[Request.Response], APIServiceError> where Request: APIRequestType {
    
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: [Request.Response].self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
