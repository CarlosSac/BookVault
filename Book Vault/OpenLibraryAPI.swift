//
//  OpenLibraryAPI.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/24/25.
//

import Foundation

struct OpenLibraryBook: Decodable {
    let title: String
    let authorName: [String]?
    let coverId: Int?
    let firstPublishYear: Int?
    let subjects: [String]?
    
    var coverURL: URL? {
        guard let coverId = coverId else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-L.jpg")
    }
    private enum CodingKeys: String, CodingKey {
        case title
        case authorName = "author_name"
        case coverId = "cover_i"
        case firstPublishYear = "first_publish_year"
        case subjects
    }
}

struct OpenLibraryResponse: Decodable {
    let docs: [OpenLibraryBook]
}

func searchBooks(title: String, author: String?, completion: @escaping ([OpenLibraryBook]) -> Void) {
    var urlComponents = URLComponents(string: "https://openlibrary.org/search.json")!
    var queryItems = [URLQueryItem(name: "title", value: title),
                      URLQueryItem(name: "limit", value: "10")]
    if let author = author, !author.isEmpty {
        queryItems.append(URLQueryItem(name: "author", value: author))
    }
    urlComponents.queryItems = queryItems
    
    let url = urlComponents.url!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data,
              let result = try? JSONDecoder().decode(OpenLibraryResponse.self, from: data) else {
            completion([])
            return
        }
        completion(result.docs)
    }
    task.resume()
}
