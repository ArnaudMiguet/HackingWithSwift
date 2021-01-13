//
//  GameScene.swift
//  Challenge07
//
//  Created by Arnaud Miguet on 13.01.21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var remainingBullets = 5
    var bulletsView: [SKSpriteNode]!
    
    var reloadLabel: SKLabelNode!
    
    var timer: Timer!
    var countdown = 60 {
        didSet {
            timerLabel.text = "\(countdown)"
        }
    }
    var timerLabel: SKLabelNode!
    
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = size
        background.position = size.middle
        background.zPosition = -1
        addChild(background)
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        timerLabel.horizontalAlignmentMode = .center
        timerLabel.fontSize = 48
        timerLabel.text = "60"
        addChild(timerLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: size.width - 50, y: size.height - 50)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        bulletsView = []
        for i in 0..<5 {
            let newBullet = SKSpriteNode(imageNamed: "bulletFull")
            newBullet.position = CGPoint(x: 16 + 346 / 16 + 70 * i, y: 16 + 800 / 16)
            newBullet.size = CGSize(width: 346 / 8, height: 800 / 8)
            addChild(newBullet)
            bulletsView.append(newBullet)
        }
        
        reloadLabel = SKLabelNode(fontNamed: "Chalkduster")
        reloadLabel.text = "Reload"
        reloadLabel.position = CGPoint(x: size.width - 20, y: 20)
        reloadLabel.horizontalAlignmentMode = .right
        reloadLabel.fontSize = 48
        reloadLabel.name = "reload"
        addChild(reloadLabel)
        
        spawnTarget(onRow: 0)
        spawnTarget(onRow: 1)
        spawnTarget(onRow: 2)
    }
    
    @objc func tickTimer() {
        countdown -= 1
        
        if countdown == 0 {
            timer.invalidate()
            isGameOver = true
            for node in children {
                if node.name == "target" {
                    node.run(SKAction.fadeAlpha(by: -1, duration: 0.5)) {
                        node.removeFromParent()
                    }
                }
            }
            let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
            gameOverLabel.fontSize = 48
            gameOverLabel.position = size.middle
            gameOverLabel.text = "GameOver"
            addChild(gameOverLabel)
        }
    }
    
    func spawnTarget(onRow row: Int) {
        let isGoodTarget = Bool.random()
        let randomSize = Int.random(in: 80...170)
        let newTarget = TargetNode(imageNamed: isGoodTarget ? "targetGood" : "targetBad")
        newTarget.isGood = isGoodTarget
        newTarget.row = row
        newTarget.speedValue = randomSize
        newTarget.size = CGSize(width: randomSize, height: randomSize)
        newTarget.position = CGPoint(x: row % 2 == 0 ? -100.0 : size.width + 100, y: 200.0 + 200.0 * CGFloat(row))
        newTarget.name = "target"
        let action = SKAction.moveBy(x: (row % 2 == 0 ? 1 : -1) * (size.width + 300.0), y: 0, duration: Double(randomSize) / 5.0 * 0.1)
        newTarget.run(action)
        addChild(newTarget)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.name == "target" {
                guard let node = node as? TargetNode else { return }
                if node.position.x < -100 || node.position.x > size.width + 100 {
                    spawnTarget(onRow: node.row)
                    node.removeFromParent()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "reload" {
                guard !isGameOver else { return }
                remainingBullets = 5
                let _ = bulletsView.map { $0.texture = SKTexture(imageNamed: "bulletFull") }
                return
            } else if node.name == "target" {
                guard !isGameOver else { return }
                guard remainingBullets > 0 else { return }
                guard let targetNode = node as? TargetNode else { return }
                score += targetNode.isGood ? targetNode.speedValue / 10 : -50
                spawnTarget(onRow: targetNode.row)
                targetNode.name = "fadingTarget"
                targetNode.run(SKAction.fadeAlpha(by: -1, duration: 0.5)) {
                    targetNode.removeFromParent()
                }
            }
        }
        guard remainingBullets > 0 else { return }
        guard !isGameOver else { return }
        
        remainingBullets -= 1
        
        bulletsView[remainingBullets].texture = SKTexture(imageNamed: "bulletEmpty")
    }
}

extension CGSize {
    var middle: CGPoint {
        CGPoint(x: self.width / 2, y: self.height / 2)
    }
}

class TargetNode: SKSpriteNode {
    var speedValue: Int!
    var isGood: Bool!
    var row: Int!
}
