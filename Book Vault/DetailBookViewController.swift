//
//  DetailBookViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 5/1/25.
//

import UIKit
import Nuke

class DetailBookViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var editionLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var bookCoverImageView: UIImageView!

    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author ?? "Unknown"
        yearLabel.text = book.firstPublishYear != nil ? "\(book.firstPublishYear!)" : "N/A"
        editionLabel.text = book.editionCount != nil ? "\(book.editionCount!) editions" : "N/A"
        pagesLabel.text = book.numberPages != nil ? "\(book.numberPages!) pages" : "N/A"
        notesLabel.text = book.subjects?.joined(separator: ", ") ?? book.note ?? "Add your notes"
        if let url = book.coverURL {
            Nuke.loadImage(with: url, into: bookCoverImageView)
        } else {
            bookCoverImageView.image = nil
        }
    }
    @IBAction func didTapAddBookButton(_ sender: Any) {
        guard let book = book else { return }
        book.save()
        navigationController?.popViewController(animated: true)
        
    }
    

}



