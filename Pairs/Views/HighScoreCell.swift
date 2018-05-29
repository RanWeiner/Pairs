//
//  HighScoreCell.swift
//  Pairs
//
//  Created by Ran Weiner on 5/29/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var highScoreRecord: HighScore?
    
    
    func setHighScore(hsRank : Int ,hs : HighScore){
        self.highScoreRecord = hs
        name.text = hs.playerName
        score.text = hs.score
        rank.text = String(hsRank)
    }
    
}
