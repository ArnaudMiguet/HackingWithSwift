//
//  DetailViewController.swift
//  Challenge05
//
//  Created by Arnaud Miguet on 11.12.20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var index: Int!
    weak var tableViewController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = tableViewController.interests[index].caption
        
        if let imageData = try? Data(contentsOf: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(tableViewController.interests[index].image)) {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rename", style: .plain, target: self, action: #selector(renameImage))
    }
    
    // MARK: - User Intents
    
    @objc func renameImage() {
        let ac = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            self?.tableViewController.interests[self?.index ?? 0].caption = ac?.textFields?[0].text ?? "Uncaptioned"
            self?.title =  ac?.textFields?[0].text ?? "Uncaptioned"
            self?.tableViewController.saveInterests()
            self?.tableViewController.tableView.reloadData()
        })
        present(ac, animated: true)
    }
}
