//
//  ViewController.swift
//  Challenge06
//
//  Created by Arnaud Miguet on 07.01.21.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                if let decodedCountries = try? JSONDecoder().decode([Country].self, from: data) {
                    countries = decodedCountries
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewControllerId") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("failed to create viewcontroller")
        }
    }
}

struct Country: Codable {
    var name: String
    var capitalCity: String
    var currency: String
}
