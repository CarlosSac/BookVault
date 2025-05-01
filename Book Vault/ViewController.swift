//
//  ViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/20/25.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var libraryTableView: UITableView!
    
    var books = [Book]()

     override func viewDidLoad() {
         super.viewDidLoad()
         libraryTableView.dataSource = self
         libraryTableView.delegate = self
         refreshBooks()
  
     }

     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         refreshBooks()
     }

     @IBAction func didTapNewBookButton(_ sender: Any) {
         performSegue(withIdentifier: "ComposeSegue", sender: nil)
     }


     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ComposeSegue",
            let navController = segue.destination as? UINavigationController,
            let composeVC = navController.topViewController as? BookComposeViewController {
             composeVC.bookToEdit = sender as? Book
             composeVC.onComposeBook = { [weak self] book in
                 print("onComposeBook closure called")
    
                 book.save()
                 self?.refreshBooks()
             }
         }
     }

     private func refreshBooks() {
         books = Book.getBooks()
         //print("Books retrieved: \(books)")
         emptyStateLabel.isHidden = !books.isEmpty
         libraryTableView.reloadData()
     }
 }

 extension ViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return books.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
         let book = books[indexPath.row]
         cell.configure(with: book)
         return cell
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         let selectedBook = books[indexPath.row]
         performSegue(withIdentifier: "ComposeSegue", sender: selectedBook)
     }
 }




