//
//  TableViewController.swift
//  Project04-WebBrowser
//
//  Created by Arnaud Miguet on 30.11.20.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["arnaudmiguet.ch", "hackingwithswift.com", "apple.com"]
    
    override func viewDidLoad() {
        title = "Web Browser"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell")!
        cell.textLabel!.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "detailView"))! as ViewController
        vc.website = websites[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
