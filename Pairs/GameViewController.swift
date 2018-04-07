//
//  GameViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 3/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//
import Foundation
import UIKit

class GameViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    let TileMargin = CGFloat(5.0)
    var diffPassedOver : String!
    
    var cards = [Card]()
    var gameManager: Game!
    
    let cardImages: [UIImage] = [
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
    
    var lastCell : CollectionViewCell?
    
    
    
    
    
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
    
       
        
         cell.myLabel.text = String(cards[indexPath.item].cardId)
        
        let index = indexPath.item
        
        if cards[index].isMatched {
        
            cell.cardImage.image = cardImages[cards[index].cardId]  //show front of the card
            
        } else if cards[index].isOpened {
            cell.cardImage.image = cardImages[cards[index].cardId]  //show front of the card
        }
        else {
            cell.cardImage.image = cardImages[0] //show back of the card
        }
        
        return cell
    }
   
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let currentIndex = indexPath.item
       
        
     

        gameManager.selectCard(index:  currentIndex)
        
        cards = gameManager.allCards //maybe unesseccery
        
        if cards[currentIndex].isMatched {
        
            cell.cardImage.image = cardImages[cards[currentIndex].cardId]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
            lastCell = nil
            
            if gameManager.isGameOver() {
                performSegue(withIdentifier: "endGame", sender: self)
            }

        } else if cards[currentIndex].isOpened {
            if lastCell == nil {
                lastCell = cell
            }
    
            cell.cardImage.image = cardImages[cards[currentIndex].cardId]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        
        else {
            
            if lastCell != nil && lastCell != cell {
                
                cell.cardImage.image = cardImages[cards[currentIndex].cardId]
                CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                
                DispatchQueue.global(qos:.background).asyncAfter(deadline: DispatchTime.now()+1){
                    DispatchQueue.main.async {
                      
                        self.lastCell?.cardImage.image = self.cardImages[0]
                        CollectionViewCell.transition(with: self.lastCell!, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                        
                        cell.cardImage.image = self.cardImages[0]
                        CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                        
                        self.lastCell = nil
                    }
                }
                
                
            }
                
            
            else {
                
                cell.cardImage.image = self.cardImages[0]
                CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                self.lastCell = nil
                
                
            }
          
            }
 
        

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "endGame" {
            let destinationVC = segue.destination as! EndGameViewController
            destinationVC.difficulty = diffPassedOver
            
        }
    }
    
    

    

}
