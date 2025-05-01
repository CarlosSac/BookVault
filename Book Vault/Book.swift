//
//  Book.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/22/25.
//

import UIKit


struct Book: Codable {


    var title: String
    var author: String?
    var currentPage: Int?
    var numberPages: Int?
    var note: String?
    var firstPublishYear: Int?
    var subjects: [String]?
    var coverId: Int?
    var editionCount: Int?
    var id: String = UUID().uuidString
    
    var coverURL: URL? {
        guard let coverId = coverId else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-L.jpg")
    }

    // Initialize a new book
    init(
        title: String,
        author: String? = nil,
        currentPage: Int? = nil,
        numberPages: Int? = nil,
        note: String? = nil,
        firstPublishYear: Int? = nil,
        subjects: [String]? = nil,
        coverId: Int? = nil,
        editionCount: Int? = nil
    ) {
        self.title = title
        self.author = author
        self.currentPage = currentPage
        self.numberPages = numberPages
        self.note = note
        self.firstPublishYear = firstPublishYear
        self.subjects = subjects
        self.coverId = coverId
        self.editionCount = editionCount
    }
    
    var progress: Float {
        guard let currentPage = currentPage, let numberPages = numberPages, numberPages > 0 else {
            return 0.0
        }
        return Float(currentPage) / Float(numberPages)
    }
}

// MARK: - Book + UserDefaults
extension Book {

    static func save(_ books: [Book]) {
        let defaults = UserDefaults.standard
        if let encodedData = try? JSONEncoder().encode(books) {
            defaults.set(encodedData, forKey: "books")
        } else {
        }
    }

    static func getBooks() -> [Book] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "books") {
            if let decodedBooks = try? JSONDecoder().decode([Book].self, from: data) {
                return decodedBooks
            } else {
            }
        } else {
        }
        return []
    }

    func save() {
        var books = Book.getBooks()
        if let index = books.firstIndex(where: { $0.id == self.id }) {
            books[index] = self
        } else {
            books.append(self)
        }
        Book.save(books)
    }
    
}
