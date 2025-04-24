//
//  Book.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/22/25.
//

import UIKit

// The Book model
struct Book: Codable {

    // The book's title
    var title: String

    // Optional properties for additional book details
    var author: String?
    var currentPage: Int?
    var numberPages: Int?

    // A note about the book
    var note: String?

    // A unique identifier for the book
    var id: String = UUID().uuidString

    // Initialize a new book
    init(title: String, author: String? = nil, currentPage: Int? = nil, numberPages: Int? = nil, note: String? = nil) {
        self.title = title
        self.author = author
        self.currentPage = currentPage
        self.numberPages = numberPages
        self.note = note
  
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
