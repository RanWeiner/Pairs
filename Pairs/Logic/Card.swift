//
//  Card.swift
//  Pairs
//
//  Created by Ran Weiner on 4/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import Foundation
 
struct Card{
    var cardId : Int
    var isOpen = false
    var isMatched = false

    static var identifierFactory = 0

    init() {
        self.cardId = Card.getUniqueIdentifier()
    }
    
 
    static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
}
