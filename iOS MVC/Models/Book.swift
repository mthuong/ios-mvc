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
    let key, type, title, titleSuggest: String
    let numberOfPagesMedian: Int
    let isbn: [String]
    let coverEditionKey: String
    let coverI: Int
    let language, authorKey, authorName, subject: [String]
    let time: [String]

    enum CodingKeys: String, CodingKey {
        case key, type, title
        case titleSuggest = "title_suggest"
        case numberOfPagesMedian = "number_of_pages_median"
        case isbn
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case language
        case authorKey = "author_key"
        case authorName = "author_name"
        case subject, time
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

    func with(
        key: String? = nil,
        type: String? = nil,
        title: String? = nil,
        titleSuggest: String? = nil,
        numberOfPagesMedian: Int? = nil,
        isbn: [String]? = nil,
        coverEditionKey: String? = nil,
        coverI: Int? = nil,
        language: [String]? = nil,
        authorKey: [String]? = nil,
        authorName: [String]? = nil,
        subject: [String]? = nil,
        time: [String]? = nil
    ) -> Book {
        return Book(
            key: key ?? self.key,
            type: type ?? self.type,
            title: title ?? self.title,
            titleSuggest: titleSuggest ?? self.titleSuggest,
            numberOfPagesMedian: numberOfPagesMedian ?? self.numberOfPagesMedian,
            isbn: isbn ?? self.isbn,
            coverEditionKey: coverEditionKey ?? self.coverEditionKey,
            coverI: coverI ?? self.coverI,
            language: language ?? self.language,
            authorKey: authorKey ?? self.authorKey,
            authorName: authorName ?? self.authorName,
            subject: subject ?? self.subject,
            time: time ?? self.time
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
