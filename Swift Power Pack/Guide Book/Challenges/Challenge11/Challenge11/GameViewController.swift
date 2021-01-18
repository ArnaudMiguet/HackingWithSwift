//
//  GameViewController.swift
//  Challenge11
//
//  Created by Arnaud Miguet on 17.01.21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pairs Game !"
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                if let pairs = UserDefaults.standard.dictionary(forKey: "pairs") as? [String: String] {
                    scene.pairs = pairs
                    print("Retrieved pairs")
                } else {
                    let pairs = ["Paris": "France", "London": "England", "Berlin": "Germany", "Rome": "Italy", "Madrid": "Spain", "Washington": "USA", "Dublin": "Ireland", "Moscow": "Russia"]
                    UserDefaults.standard.setValue(pairs, forKey: "pairs")
                    scene.pairs = pairs
                    print("Saved pairs")
                }
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEdit))
    }
    
    @objc func showEdit() {
        if let tvc = storyboard?.instantiateViewController(identifier: "PairsTable") as? PairsTableViewController {
            navigationController?.pushViewController(tvc, animated: true)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
