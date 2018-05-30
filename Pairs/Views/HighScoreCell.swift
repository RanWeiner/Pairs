//
//  HighScoreCell.swift
//  Pairs
//
//  Created by Ran Weiner on 5/29/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {


    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var highScoreRecord: HighScoreRecord?
    
    
    func setHighScore(hsRank : Int ,hs : HighScoreRecord){
        
        self.highScoreRecord = hs
        nameLabel.text = hs.name
        scoreLabel.text = hs.score
        rankLabel.text = String(hsRank)
    }
    
}
