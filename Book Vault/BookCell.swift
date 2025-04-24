//
//  BookCell.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/22/25.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var bookProgressView: UIProgressView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with book: Book) {
        titleLabel.text = book.title
        
        // Display the author's name if available, otherwise show "Unknown Author"
        authorLabel.text = book.author ?? "Unknown Author"
        
        // Set the progress on the progress view
        let progress = book.progress
        bookProgressView.setProgress(progress, animated: true)
    }

}
