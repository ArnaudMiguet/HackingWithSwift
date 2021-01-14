//
//  NoteViewController.swift
//  Challenge08
//
//  Created by Arnaud Miguet on 14.01.21.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var contentTextView: UITextView!
    
    var note: Note!
    
    var delegate: DetailDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = note.title
        contentTextView.text = note.content
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func updateForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            contentTextView.contentInset = .zero
        } else {
            contentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        contentTextView.scrollIndicatorInsets = contentTextView.contentInset
        
        let selectedRange = contentTextView.selectedRange
        
        contentTextView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func shareAction() {
        note.content = contentTextView.text
        let controller = UIActivityViewController(activityItems: [note.content], applicationActivities: [])
        controller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(controller, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        note.content = contentTextView.text
        delegate.updateNote(note)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note.content = textView.text
        delegate.updateNote(note)
    }
}

protocol DetailDelegate {
    func updateNote(_ note: Note)
}
