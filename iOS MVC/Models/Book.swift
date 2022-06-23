//
//  Book.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/19/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let book = try Book(json)

import Foundation


// MARK: - Book
struct Book: BaseModel {
    let key, type, title, titleSuggest: String?
    let editionCount, firstPublishYear, numberOfPagesMedian: Int?
    let coverEditionKey: String?
    let authorName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case key, type, title
        case titleSuggest = "title_suggest"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case numberOfPagesMedian = "number_of_pages_median"
        case coverEditionKey = "cover_edition_key"
        case authorName = "author_name"
    }
}

// MARK: Book convenience initializers and mutators

extension Book {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Book.self, from: data)
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
        key: String?? = nil,
        type: String?? = nil,
        title: String?? = nil,
        titleSuggest: String?? = nil,
        editionCount: Int?? = nil,
        firstPublishYear: Int?? = nil,
        numberOfPagesMedian: Int?? = nil,
        coverEditionKey: String?? = nil,
        authorName: [String]?? = nil
    ) -> Book {
        return Book(
            key: key ?? self.key,
            type: type ?? self.type,
            title: title ?? self.title,
            titleSuggest: titleSuggest ?? self.titleSuggest,
            editionCount: editionCount ?? self.editionCount,
            firstPublishYear: firstPublishYear ?? self.firstPublishYear,
            numberOfPagesMedian: numberOfPagesMedian ?? self.numberOfPagesMedian,
            coverEditionKey: coverEditionKey ?? self.coverEditionKey,
            authorName: authorName ?? self.authorName
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
