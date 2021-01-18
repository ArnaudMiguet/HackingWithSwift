//
//  PairsTableViewController.swift
//  Challenge11
//
//  Created by Arnaud Miguet on 18.01.21.
//

import UIKit
import LocalAuthentication

class PairsTableViewController: UITableViewController {
    
    var pairs: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "pairs"
        self.view.isUserInteractionEnabled = false
        
        if let pairs = UserDefaults.standard.dictionary(forKey: "pairs") as? [String: String] {
            self.pairs = pairs
            print("Retrieved pairs")
        } else {
            pairs = [:]
            print("failed to read pairs")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPair))
        
        authenticateUser()
    }
    
    @objc func addPair() {
        let ac = UIAlertController(title: "New Pair", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let firstText = ac?.textFields?[0].text else { return }
            guard let secondText = ac?.textFields?[1].text else { return }
            
            self?.pairs[firstText] = secondText
            
            UserDefaults.standard.setValue(self?.pairs, forKey: "pairs")
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func authenticateUser() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself !"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            self?.view.isUserInteractionEnabled = true
                        } else {
                            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default) { action in
                                self?.navigationController?.popViewController(animated: true)
                            })
                            self?.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(ac, animated: true)
            }
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pairs.keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PairCell", for: indexPath)
        let title = pairs.keys.sorted()[indexPath.row]
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = pairs[title]!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let title = pairs.keys.sorted()[indexPath.row]
            pairs.removeValue(forKey: title)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            UserDefaults.standard.setValue(self.pairs, forKey: "pairs")
        }
    }
}
