//
//  DetailViewController.swift
//  Project01 - Storm Viewer
//
//  Created by Arnaud Miguet on 29.11.20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    /// The image to load, based on selection in table view
    var selectedImage: String?
    
    // Challenge #03
    var selectedImagePosition: Int?
    var totalNumberOfImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedImagePosition = selectedImagePosition, let totalNumberOfImages = totalNumberOfImages {
            title = "Picture \(selectedImagePosition) of \(totalNumberOfImages)"
        } else {
            title = "Picture"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Challenge 02 from Project 03
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommend))

        // Load the image and push it to the UIImageView
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc
    func recommend() {
        let vc = UIActivityViewController(activityItems: ["You should try Strom Viewer !"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    // Allow user to hide nav bar when on detail view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
