//
//  BookCell.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/22/25.
//

import UIKit
import Nuke

class BookCell: UITableViewCell {
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookProgressView: UIProgressView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author ?? "Unknown Author"
        let progress = book.progress
        bookProgressView.setProgress(progress, animated: true)
        bookCoverImageView.image = nil
        
        if let url = book.coverURL {
            Nuke.loadImage(with: url, into: bookCoverImageView)
        } else {
            bookCoverImageView.image = UIImage(systemName: "book")
        }
    }
    
    func configure(with openLibraryBook: OpenLibraryBook) {
        titleLabel.text = openLibraryBook.title
        authorLabel.text = openLibraryBook.authorName?.joined(separator: ", ") ?? "Unknown Author"
        bookProgressView.isHidden = true
        bookCoverImageView.image = nil
    }
    


}
