//
//  CustomizeCardsViewCell.swift
//  Pairs
//
//  Created by Ran Weiner on 6/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class CustomizeCardsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    private var index : Int?
    
    func setIndex(index : Int) {
        self.index = index
    }
    
    func getIndex() -> Int {
        return self.index!
    }
}
