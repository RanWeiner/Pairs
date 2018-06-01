//
//  HighScore.swift
//  Pairs
//
//  Created by Ran Weiner on 5/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import Foundation

class HighScore {
    var playerName: String!
    var secondsPlayed : Int!
    var minutesPlayed : Int!
    var difficulty: String!
    var score: String!
    
    init(difficulty: String , playerName: String , secondsPlayed : Int){
        self.difficulty = difficulty
        self.secondsPlayed = secondsPlayed
        self.playerName = playerName
        setScore(score : secondsPlayed)
    }
    
    func setScore(score: Int){
        self.score =  String(score) + " sec"
    }
    
}
