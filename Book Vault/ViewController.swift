//
//  ViewController.swift
//  Book Vault
//
//  Created by Carlos Sac on 4/20/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Book \(indexPath.row + 1)"
        return cell
    }
    

    @IBOutlet weak var libraryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryTableView.dataSource = self
        
    }


}

