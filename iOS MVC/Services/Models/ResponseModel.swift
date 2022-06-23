//
//  ResponseModel.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/22/22.
//

import Foundation

// MARK: - Response
struct ResponseModel <T: Codable>: Codable {
    let numFound, start: Int
    let numFoundExact: Bool
    let responseModelNumFound: Int
    let q: String
    let offset: JSONNull?
    let docs: [T]
    
    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact
        case responseModelNumFound = "num_found"
        case q, offset, docs
    }
}

// MARK: ResponseModel convenience initializers and mutators

extension ResponseModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ResponseModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        numFound: Int? = nil,
        start: Int? = nil,
        numFoundExact: Bool? = nil,
        responseModelNumFound: Int? = nil,
        q: String? = nil,
        offset: JSONNull? = nil,
        docs: [T]? = nil
    ) -> ResponseModel {
        return ResponseModel(
            numFound: numFound ?? self.numFound,
            start: start ?? self.start,
            numFoundExact: numFoundExact ?? self.numFoundExact,
            responseModelNumFound: responseModelNumFound ?? self.responseModelNumFound,
            q: q ?? self.q,
            offset: offset ?? self.offset,
            docs: docs ?? self.docs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
