//
//  DetailViewController.swift
//  Challenge06
//
//  Created by Arnaud Miguet on 07.01.21.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = country.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailItemCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Capitale: \(country.capitalCity)"
        case 1:
            cell.textLabel?.text = "Monnaie: \(country.currency)"
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
    
}
