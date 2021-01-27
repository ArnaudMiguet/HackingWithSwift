//
//  Card.swift
//  Project17-Flashzilla
//
//  Created by Arnaud Miguet on 27.01.21.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
