//
//  ViewController.swift
//  Project07-WhitehousePetitions
//
//  Created by Arnaud Miguet on 01.12.20.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Challenge 01
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        // Challenge 02
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(showSearchAlert))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString = navigationController?.tabBarItem?.tag == 0 ? "https://www.hackingwithswift.com/samples/petitions-1.json" : "https://www.hackingwithswift.com/samples/petitions-2.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showSearchAlert() {
        let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] action in
            if let search = ac?.textFields?[0].text {
                self?.performSelector(inBackground: #selector(self?.filter), with: search)
            }
        })
        present(ac, animated: true)
    }
    
    @objc func filter(with searchString: String) {
        if searchString == "" {
            self.filteredPetitions = self.petitions
        } else {
            self.filteredPetitions = self.petitions.filter {$0.title.contains(searchString)}
        }
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Challenge 02 changed this
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Challenge 02 changed this :
        cell.textLabel?.text = filteredPetitions[indexPath.row].title
        cell.detailTextLabel?.text = filteredPetitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        // Challenge 02 changed this :
        vc.detailItem = filteredPetitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

