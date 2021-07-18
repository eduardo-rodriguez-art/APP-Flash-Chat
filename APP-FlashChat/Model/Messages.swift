//
//  Messages.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 17/07/21.
//

import Foundation

struct Messages {
    var sender: String
    var body: String
    
    init(sender: String, body: String) {
        self.sender = sender
        self.body = body
    }
}
