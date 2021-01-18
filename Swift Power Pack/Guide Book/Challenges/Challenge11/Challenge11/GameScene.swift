//
//  GameScene.swift
//  Challenge11
//
//  Created by Arnaud Miguet on 17.01.21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var cards: [CardNode]!
    
    var pairs: [String: String]!
    
    let cardSize = CGSize(width: 100.0, height: 150.0)
    
    var selectedCard: Int?
    
    var gameOverLabel: SKLabelNode!
    var isGameOver = false {
        didSet {
            gameOverLabel.alpha = 1
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.lightGray
        createCards()
        
        gameOverLabel = SKLabelNode(text: "You Win !")
        gameOverLabel.fontSize = 18
        gameOverLabel.fontColor = .black
        gameOverLabel.position = CGPoint(x: size.width / 2.0, y: size.height - 40)
        gameOverLabel.alpha = 0
        addChild(gameOverLabel)
    }
    
    func createCards() {
        cards = []
        
        let origin = CGPoint(x: (size.width - (cardSize.width * 4 + 30)) / 2.0, y: (size.height - (cardSize.height * 4 + 30)) / 2.0)
                
        let keys = pairs.keys.shuffled()
        var bag = [String]()
        for i in 0..<8 {
            bag.append(keys[i])
            bag.append(pairs[keys[i]] ?? "")
        }
        bag.shuffle()
        for row in 0..<4 {
            for col in 0..<4 {
                let newCard = CardNode(text: bag[row * 4 + col], cardSize: cardSize)
                newCard.position = CGPoint(x: CGFloat(col) * (cardSize.width + 10) + origin.x + cardSize.middle.x, y: CGFloat(row) * (cardSize.height + 10) + origin.y + cardSize.middle.y)
                cards.append(newCard)
                addChild(newCard)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard !isGameOver else { return }
        let location = touch.location(in: self)
        let touches = nodes(at: location)
        let card = touches.first(where: {$0 is CardNode})
        if let card = card as? CardNode {
            selectedCard(card)
        }
    }
    
    func selectedCard(_ card: CardNode) {
        let index = Int(cards.firstIndex(of: card)!)
        guard !card.isFaceUp else { return }
        
        if selectedCard == nil {
            selectedCard = index
            card.flip()
        } else {
            var isMatched = false
            if pairs.keys.contains(card.text) {
                isMatched = pairs[card.text]! == cards[selectedCard!].text
            } else if pairs.keys.contains(cards[selectedCard!].text) {
                isMatched = pairs[cards[selectedCard!].text] == card.text
            }
            let show = SKAction.run { card.flip(); self.isUserInteractionEnabled = false }
            let wait = SKAction.wait(forDuration: 1)
            let hide = SKAction.run {
                if !isMatched { card.flip() }
                if !isMatched { self.cards[self.selectedCard!].flip() }
                self.selectedCard = nil
                self.isUserInteractionEnabled = true
                
                if self.cards.reduce(true, { $0 && $1.isFaceUp }) {
                    self.isGameOver = true
                }
            }
            run(SKAction.sequence([show, wait, hide]))
        }
    }
}

extension CGSize {
    var middle: CGPoint {
        return CGPoint(x: width / 2.0, y: height / 2.0)
    }
}
