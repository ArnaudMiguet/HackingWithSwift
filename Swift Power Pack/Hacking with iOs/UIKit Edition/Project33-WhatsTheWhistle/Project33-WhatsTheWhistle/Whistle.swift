//
//  Whistle.swift
//  Project33-WhatsTheWhistle
//
//  Created by Arnaud Miguet on 18.01.21.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
