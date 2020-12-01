//
//  Petition.swift
//  Project07-WhitehousePetitions
//
//  Created by Arnaud Miguet on 01.12.20.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
