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
   // let cardImages = ["backofcard" , "banana" , "apple" , "coconut", "grape" , "kiwi" , "orange" ,  "pear" , "pinapple" , "strawberry" , "watermelon" ]
    
    var cardImages: [UIImage] = [
        UIImage(named: "backofcard")!,
        UIImage(named: "banana")!,
        UIImage(named: "apple")!,
        UIImage(named: "coconut")!,
        UIImage(named: "grape" )!,
        UIImage(named: "kiwi")!,
        UIImage(named: "orange")!,
        UIImage(named: "pear")!,
        UIImage(named: "pinapple")!,
        UIImage(named: "strawberry")!,
        UIImage(named: "watermelon")!
    ]
    
    
    
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
        
        var id = cards[indexPath.item].cardId // just for debugging
        cell.myLabel.text =  String(id)
        
        var allCards = gameManager.allCards
        
        if allCards[indexPath.item].isMatched || allCards[indexPath.item].isOpen{
            cell.cardImage.image = cardImages[allCards[indexPath.item].cardId]  //show front of the card
        }
        else {
            cell.cardImage.image = cardImages[0] //show back of the card
        }
        
        return cell
    }
   
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let index = indexPath.item
       
        gameManager.selectCard(index: index)
        
        var allCards = gameManager.allCards
        
        if allCards[index].isMatched || allCards[index].isOpen {
            
            cell.cardImage.image = cardImages[allCards[index].cardId]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)

        }
        
        else {
            cell.cardImage.image = cardImages[0]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
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
