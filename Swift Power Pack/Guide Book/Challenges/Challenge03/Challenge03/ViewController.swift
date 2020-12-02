//
//  ViewController.swift
//  Challenge03
//
//  Created by Arnaud Miguet on 02.12.20.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItems))

        // Nav bar styling
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Data loading
        shoppingItems = UserDefaults.standard.array(forKey: "ViewController.shoppingList") as? [String] ?? []
    }
    
    /// Used to add an item to the shopping list
    ///
    /// Called by the add bar button item and presents an alert to add an item
    @objc func addItem() {
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            if let newItemText = ac?.textFields?[0].text {
                self?.shoppingItems.insert(newItemText, at: 0)
                self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                UserDefaults.standard.setValue(self?.shoppingItems, forKey: "ViewController.shoppingList")
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    /// Used to clear all items in the shopping list
    @objc func clearItems() {
        let ac = UIAlertController(title: "Clear list", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] action in
            self?.shoppingItems = []
            self?.tableView.reloadData()
            UserDefaults.standard.setValue(self?.shoppingItems, forKey: "ViewController.shoppingList")
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    // MARK: - table view delegation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }
}

