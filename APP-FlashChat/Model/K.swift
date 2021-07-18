//
//  K.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 17/07/21.
//

//K Constantes

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageTableViewCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
