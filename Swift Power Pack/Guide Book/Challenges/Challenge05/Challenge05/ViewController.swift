//
//  ViewController.swift
//  Challenge05
//
//  Created by Arnaud Miguet on 11.12.20.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var interests = [Interest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.value(forKey: "interests") as? Data {
            interests = (try? JSONDecoder().decode([Interest].self, from: data)) ?? [Interest]()
        } else {
            print("no data found")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addInterest))
    }
    
    func saveInterests() {
        if let data = try? JSONEncoder().encode(interests) {
            UserDefaults.standard.setValue(data, forKey: "interests")
        } else { print("could not encode interests") }
    }
    
    // MARK: - User intents
    
    @objc func addInterest() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController else { return }
        vc.index = selectedIndex
        vc.tableViewController = self
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = interests[indexPath.row].caption
        return cell
    }
    
    // MARK: - Picker view delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let id = UUID()
        let imageData = image.jpegData(compressionQuality: 0.8)
        let docsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = docsPath.appendingPathComponent(id.uuidString)
        try? imageData?.write(to: imagePath)
        let interest = Interest(caption: "Uncaptioned", image: id.uuidString)
        interests.append(interest)
        tableView.reloadData()
        saveInterests()
        dismiss(animated: true)
    }
}

