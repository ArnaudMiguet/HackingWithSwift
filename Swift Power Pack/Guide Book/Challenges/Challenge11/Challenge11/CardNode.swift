//
//  CardNode.swift
//  Challenge11
//
//  Created by Arnaud Miguet on 17.01.21.
//

import UIKit
import SpriteKit

class CardNode: SKSpriteNode {

    var text: String!
    
    var isFaceUp = false
    
    var backFace: SKTexture!
    var frontFace: SKTexture!
    
    convenience init(text: String, cardSize: CGSize) {
        let totalSize = cardSize
        let cardSize = CGRect(origin: .zero, size: totalSize).insetBy(dx: 5, dy: 5).size
        let originOfCard = CGPoint(x: 5, y: 5)
        let renderer = UIGraphicsImageRenderer(size: totalSize)
        
        let img = renderer.image { ctx in
            ctx.cgContext.addPath(UIBezierPath(roundedRect: CGRect(origin: originOfCard, size: cardSize), cornerRadius: 5).cgPath)
            ctx.cgContext.setLineWidth(3)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        self.init(texture: SKTexture(image: img), size: cardSize)
        
        self.backFace = SKTexture(image: img)
        
        let frontImg = renderer.image { ctx in
            ctx.cgContext.addPath(UIBezierPath(roundedRect: CGRect(origin: originOfCard, size: cardSize), cornerRadius: 5).cgPath)
            ctx.cgContext.setLineWidth(3)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: paragraphStyle]
            let attributedString = NSAttributedString(string: text, attributes: attrs)
            attributedString.draw(in: CGRect(x: 0, y: 30, width: totalSize.width, height: 25))
        }
        
        self.frontFace = SKTexture(image: frontImg)
        
        self.text = text
    }
    
    func flip() {
        isFaceUp.toggle()
        
        let newTexture: SKTexture!
        if isFaceUp {
            newTexture = frontFace
        } else {
            newTexture = backFace
        }
        let animation = SKAction.sequence([SKAction.scaleX(to: 0.01, duration: 0.1), SKAction.setTexture(newTexture), SKAction.scaleX(to: 1, duration: 0.1)])
        self.run(animation)
    }
}
