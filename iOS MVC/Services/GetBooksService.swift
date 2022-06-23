//
//  GetBooksService.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/21/22.
//

import Foundation

// MARK: - Service
struct GetBooksService: NetworkService {
    var session: NetworkSession
    var urlRequest: URLRequestFactory
    
    init(session: NetworkSession = URLSession.shared, urlRequest: URLRequestFactory = StandardURLRequestFactory(endpoint: StandardEndpoint(path: "/search.json"))) {
        self.session = session
        self.urlRequest = urlRequest
    }
    
    mutating func getBooks(by query: String, completion: @escaping (Result<[Book], Error>) -> Void) -> Void {
        var endpoint = urlRequest.endpoint
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: query))
        endpoint.queryItems = queryItems
        urlRequest.endpoint = endpoint
        
        self.get(completion: completion)
    }
    
}
