//
//  ViewController.swift
//  Challenge10
//
//  Created by Arnaud Miguet on 15.01.21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage?
    
    var firstText: String?
    var secondText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme Creator"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(presentShare))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createMeme))
    }

    @objc func presentShare() {
        guard let image = image else { return }
        
        let actionController = UIActivityViewController(activityItems: [image.jpegData(compressionQuality: 0.8)!], applicationActivities: [])
        actionController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(actionController, animated: true)
    }
    
    @objc func createMeme() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        self.image = image
        
        let ac = UIAlertController(title: "Set top text :", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
            self?.firstText = ac?.textFields?[0].text
            
            let ac = UIAlertController(title: "Set bottom text :", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] action in
                self?.secondText = ac?.textFields?[0].text
                DispatchQueue.main.async {
                    self?.startRendering()
                }
            })
            self?.present(ac, animated: true)
        })
        present(ac, animated: true)
    }
    
    func startRendering() {
        guard let image = image else { return }
        guard let topText = firstText else { return }
        guard let botText = secondText else { return }
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let img = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
                        
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle, .font: UIFont.systemFont(ofSize: 128), .strokeWidth: 4, .strokeColor: UIColor.black]
            let attrsOverlay: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle, .font: UIFont.systemFont(ofSize: 128), .foregroundColor: UIColor.white]
            let attributedTopString = NSAttributedString(string: topText, attributes: attrs)
            let attributedBotString = NSAttributedString(string: botText, attributes: attrs)
            let attributedTopStringOverlay = NSAttributedString(string: topText, attributes: attrsOverlay)
            let attributedBotStringOverlay = NSAttributedString(string: botText, attributes: attrsOverlay)
            
            attributedTopString.draw(in: CGRect(x: 0, y: 16, width: image.size.width, height: 200))
            attributedBotString.draw(in: CGRect(x: 0, y: image.size.height - 200 - 16, width: image.size.width, height: 200))
            attributedTopStringOverlay.draw(in: CGRect(x: 0, y: 16, width: image.size.width, height: 200))
            attributedBotStringOverlay.draw(in: CGRect(x: 0, y: image.size.height - 200 - 16, width: image.size.width, height: 200))
        }
        
        imageView.image = img
    }
}

