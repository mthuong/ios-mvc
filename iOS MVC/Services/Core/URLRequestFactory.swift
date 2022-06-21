//
//  URLRequestFactory.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/20/22.
//

import Foundation

// MARK: - ServiceRequest
protocol URLRequestFactory {
    func makeURLRequest() -> URLRequest
    var defaultHeaders: [String: String] { get }
    var endpoint: Endpoint { get set }
}

extension URLRequestFactory {
    public var defaultHeaders: [String: String] {
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }
}

// MARK: - Default URL request factory
struct StandardURLRequestFactory: URLRequestFactory {
    public var endpoint: Endpoint
    
    public func makeURLRequest() -> URLRequest {
        guard let url = endpoint.url else {
            fatalError("Unable to make url request")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = defaultHeaders
        
        return urlRequest
    }
}
