//
//  Move.swift
//  Project34-FourInARow
//
//  Created by Arnaud Miguet on 18.01.21.
//

import UIKit
import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    
    init(column: Int) {
        self.column = column
    }
}
