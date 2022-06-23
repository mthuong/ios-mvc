//
//  NetworkService.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/20/22.
//

import Foundation

// MARK: - NetworkService
protocol NetworkService {
    var session: NetworkSession { get set }
    var urlRequest: URLRequestFactory { get set }
}

// MARK: - extension
extension NetworkService {
    internal func get<Resource>(completion: @escaping (Result<[Resource], Error>) -> Void) where Resource : Codable {
        var request = urlRequest.makeURLRequest()
        request.httpMethod = "GET"

        session.loadData(from: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, data.isEmpty == false else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            do {
                let resources = try JSONDecoder().decode((ResponseModel<Resource>).self, from: data)
                completion(.success(resources.docs))
            } catch {
                completion(.failure(error))
            }
        }
    }

    public func post<Resource>(_ resource: Resource, completion: @escaping (Result<ResourceID, Error>) -> Void) where Resource : Encodable {
        var request = urlRequest.makeURLRequest()
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(resource)

        session.loadData(from: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            guard let resourceIdLocation = httpResponse.allHeaderFields["Location"] as? String else {
                completion(.failure(ServiceError.locationHeaderNotFound))
                return
            }

            guard let resourceId = resourceIdLocation.components(separatedBy: "/").last else {
                completion(.failure(ServiceError.resourceIDNotFound))
                return
            }

            if let resourceUUID = UUID(uuidString: resourceId) {
                completion(.success(ResourceID.uuid(resourceUUID)))
            } else if let resourceIntID = Int(resourceId) {
                completion(.success(ResourceID.integer(resourceIntID)))
            } else {
                completion(.failure(ServiceError.unexpectedResourceIDType))
            }
        }
    }

    public mutating func delete<Response>(withID resourceID: ResourceID, completion: @escaping (Result<Response, Error>) -> Void) where Response : Decodable {
        var updatedEndpoint = urlRequest.endpoint

        switch resourceID {
        case .uuid(let uuid):
            updatedEndpoint.path = "\(updatedEndpoint.path)/\(uuid.uuidString)"
        case .integer(let serverID):
            updatedEndpoint.path = "\(updatedEndpoint.path)/\(serverID)"
        }

        urlRequest.endpoint = updatedEndpoint

        var request = urlRequest.makeURLRequest()
        request.httpMethod = "DELETE"

        session.loadData(from: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            guard let data = data, data.isEmpty == false else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }

    public mutating func put<Resource, Response>(_ resourceID: ResourceID, resource: Resource, completion: @escaping (Result<Response, Error>) -> Void) where Resource : Encodable, Response : Decodable {
        var updatedEndpoint = urlRequest.endpoint

        switch resourceID {
        case .uuid(let uuid):
            updatedEndpoint.path = "\(updatedEndpoint.path)/\(uuid.uuidString)"
        case .integer(let serverID):
            updatedEndpoint.path = "\(updatedEndpoint.path)/\(serverID)"
        }

        urlRequest.endpoint = updatedEndpoint

        var request = urlRequest.makeURLRequest()
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(resource)

        session.loadData(from: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            guard let data = data, data.isEmpty == false else {
                completion(.failure(ServiceError.unexpectedResponse))
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

// MARK: - ID model
public enum ResourceID {
    case integer(Int)
    case uuid(UUID)
}

// MARK: - Basic implementation
struct StandardNetworkService: NetworkService {
    var session: NetworkSession
    var urlRequest: URLRequestFactory

    init(session: NetworkSession = URLSession.shared, urlRequest: URLRequestFactory) {
        self.session = session
        self.urlRequest = urlRequest
    }

    init(resourcePath: String) {
        let endpoint = StandardEndpoint(path: resourcePath)
        self.init(urlRequest: StandardURLRequestFactory(endpoint: endpoint))
    }
}
