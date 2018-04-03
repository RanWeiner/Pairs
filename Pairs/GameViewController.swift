//
//  GameViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 3/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var diffPassedOver : String!
    var cards = [Card]()
    var gameManager: Game!
    
    
    let cardBackImage = UIImage(named:"backofcard")
    
    /*
    let easyCardImages : [UIImage] = [
        
        
        ]

    let mediumCardImages : [UIImage] = [
        
        
    ]
     
    let hardCardImages : [UIImage] = [
        
        
    ]
 */
    


    
    
    let danielle = "Love of my life"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager = Game(chosenDifficulty : diffPassedOver)
        
        cards = gameManager.allCards
        
    
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {		
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
      
       
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        var id = cards[indexPath.item].cardId
        
        cell.myLabel.text =  String(id)
        cell.cardImage.image = cardBackImage
        
        return cell
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        var index = indexPath.item
        var chosenCard = cards[index]
        
        
        if (chosenCard.isMatched){return}
        
        if chosenCard.isOpen{
            chosenCard.isOpen = false
            cell.cardImage.image = cardBackImage
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            if gameManager.lastIndexPath != nil{
                gameManager.lastIndexPath = nil
            }
            
        }else{
            chosenCard.isOpen = true
            cell.cardImage.image = UIImage(named: "banana")
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            if gameManager.lastIndexPath == nil{
                gameManager.lastIndexPath = indexPath
            }
            else {
                if chosenCard.cardId == cards[gameManager.lastIndexPath!.item].cardId {
                    cards[gameManager.lastIndexPath!.item].isMatched = true
                    chosenCard.isMatched = true
                    gameManager.lastIndexPath = nil
                }
                else{
                    chosenCard.isOpen = false
                    cell.cardImage.image = cardBackImage
                    var lastCell : CollectionViewCell = collectionView.cellForItem(at: gameManager.lastIndexPath!) as! CollectionViewCell
                    lastCell.cardImage.image = cardBackImage
                    cards[gameManager.lastIndexPath!.item].isOpen = false
                    gameManager.lastIndexPath = nil
                }
            }
            
            
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
