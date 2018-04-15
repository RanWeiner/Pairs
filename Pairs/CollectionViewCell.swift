//
//  CollectionViewCell.swift
//  Pairs
//
//  Created by Ran Weiner on 3/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!

    
    var canBeClicked : Bool = true
    var isMatched: Bool = false
    

    
}
