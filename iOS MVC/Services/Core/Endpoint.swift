//
//  Endpoint.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/20/22.
//

import Foundation

// MARK: - Endpoint
protocol Endpoint {
    var path: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    
    var scheme: String? { get }
    var host: String? { get }
    var port: Int? { get }
    var url: URL? { get }
}

extension Endpoint {
    public var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        components.port = port
        
        return components.url
    }
}

// MARK: - Basic implementation
struct StandardEndpoint: Endpoint {
    public var path: String
    public var queryItems: [URLQueryItem]? = nil
    public var scheme: String? = "http"
    public var host: String? = "localhost"
    public var port: Int? = 8080
    
    public init(path: String) {
        self.path = path
    }
}

//extension StandardEndpoint: ExpressibleByStringLiteral {
//    init(stringLiteral value: StringLiteralType) {
//        path = value
//    }
//}
