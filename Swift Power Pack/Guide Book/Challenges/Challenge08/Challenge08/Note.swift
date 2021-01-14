//
//  Note.swift
//  Challenge08
//
//  Created by Arnaud Miguet on 14.01.21.
//

import Foundation

struct Note: Codable {
    
    var id: UUID
    var content: String
    
    var title: String {
        String(content.prefix(while: {!$0.isNewline}))
    }
    
}
