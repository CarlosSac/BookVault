//
//  AddBookViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/24/25.
//
import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    @IBAction func didTapSearchButton(_ sender: Any) {
        //(sender as? UIButton)?.isEnabled = false
        let title = titleTextField.text ?? ""
        let author = authorTextField.text
        performSegue(withIdentifier: "ShowSearchResults", sender: (title, author))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSearchResults",
           let destinationVC = segue.destination as? SearchResultsViewController,
           let (title, author) = sender as? (String, String?) {
            destinationVC.searchTitle = title
            destinationVC.searchAuthor = author
        }
    }
    
    @IBAction func didTapAddManuallyButton(_ sender: Any) {
    }
    
}
