//
//  ViewController.swift
//  Challenge08
//
//  Created by Arnaud Miguet on 14.01.21.
//

import UIKit

class ViewController: UITableViewController, DetailDelegate {
    
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        if let notesData = UserDefaults.standard.data(forKey: "notes") {
            notes = (try? JSONDecoder().decode([Note].self, from: notesData)) ?? []
        } else {
            notes = []
        }
        navigationItem.leftBarButtonItem = editButtonItem;
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNote))
    }
    
    func updateNote(_ note: Note) {
        notes[notes.firstIndex(where: {$0.id == note.id})!] = note
        guard let notesData = try? JSONEncoder().encode(notes) else { return }
        UserDefaults.standard.setValue(notesData, forKey: "notes")
        tableView.reloadData()
    }
    
    @objc func createNote() {
        guard let targetVC = storyboard?.instantiateViewController(identifier: "NoteViewController") as? NoteViewController else { return }
        notes.append(Note(id: UUID(), content: ""))
        targetVC.note = notes.last
        targetVC.delegate = self
        navigationController?.pushViewController(targetVC, animated: true)
        
        tableView.reloadData()
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].content.replacingOccurrences(of: "\n", with: " ")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let targetVC = storyboard?.instantiateViewController(identifier: "NoteViewController") as? NoteViewController else { return }
        targetVC.note = notes[indexPath.row]
        targetVC.delegate = self
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            guard let notesData = try? JSONEncoder().encode(notes) else { return }
            UserDefaults.standard.setValue(notesData, forKey: "notes")
        }
    }
}

