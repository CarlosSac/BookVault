//
//  SearchResultsViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/24/25.
//
import UIKit
import Nuke

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bookProgressView: UIProgressView!
    var searchTitle: String?
    var searchAuthor: String?
    var books: [OpenLibraryBook] = []
    var book: Book?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
            super.viewDidLoad()
        print("SearchResultsViewController loaded with title: \(searchTitle ?? "") author: \(searchAuthor ?? "")")
        tableView.dataSource = self
        tableView.delegate = self

        searchBooks(title: searchTitle ?? "", author: searchAuthor) { [weak self] results in
            for book in results {
                print("Book: \(book.title), Authors: \(book.authorName ?? [])")
            }
            DispatchQueue.main.async {
                self?.books = results
                self?.tableView.reloadData()
            }
        }
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TableView will display \(books.count) rows")
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        
        if let url = book.coverURL {
            Nuke.loadImage(with: url, into: cell.bookCoverImageView)
        } else {
            cell.bookCoverImageView.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue",
           let detailVC = segue.destination as? DetailBookViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let openLibraryBook = books[indexPath.row]
            let book = Book(
                title: openLibraryBook.title,
                author: openLibraryBook.authorName?.joined(separator: ", "),
                currentPage: nil,
                numberPages: nil,
                note: openLibraryBook.subjects?.joined(separator: ", "),
                firstPublishYear: openLibraryBook.firstPublishYear,
                subjects: openLibraryBook.subjects,
                coverId: openLibraryBook.coverId,
                editionCount: openLibraryBook.editionCount
            )
            detailVC.book = book
        }
    }

    
    }
