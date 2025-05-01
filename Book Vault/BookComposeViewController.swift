
//  BookComposeViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/22/25.
//

import UIKit

class BookComposeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var currentPageTextField: UITextField!
    @IBOutlet weak var pageNumberTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!

    var bookToEdit: Book?
       var onComposeBook: ((Book) -> Void)?

       override func viewDidLoad() {
           super.viewDidLoad()
           pageNumberTextField.delegate = self
           currentPageTextField.delegate = self

           if let book = bookToEdit {
               titleTextField.text = book.title
               authorTextField.text = book.author
               currentPageTextField.text = book.currentPage?.description
               pageNumberTextField.text = book.numberPages?.description
               self.title = "Edit Book"
           }
       }

       @IBAction func didTapDoneButton(_ sender: Any) {
           print("Done button tapped") 
           guard let title = titleTextField.text, !title.isEmpty else {
               presentAlert(title: "Error", message: "Title is required.")
               return
           }

           var book: Book
           if let editBook = bookToEdit {
               book = editBook
               book.title = title
               book.author = authorTextField.text
               book.currentPage = Int(currentPageTextField.text ?? "")
               book.numberPages = Int(pageNumberTextField.text ?? "")
           } else {
               book = Book(
                   title: title,
                   author: authorTextField.text,
                   currentPage: Int(currentPageTextField.text ?? ""),
                   numberPages: Int(pageNumberTextField.text ?? "")
               )
           }
           print("Composed book: \(book)") // Debug log
           onComposeBook?(book)
           dismiss(animated: true)
       }

       @IBAction func didTapCancelButton(_ sender: Any) {
           dismiss(animated: true)
       }

       private func presentAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the replacement string is numeric or empty (for backspace)
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
   }






