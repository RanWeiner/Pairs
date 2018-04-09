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

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    lazy var gameManager : Game = Game(chosenDifficulty: self.diffPassedOver)
    
    var countdownTimer = Timer()
    var seconds: Int = 60
    
    var allCells = [CollectionViewCell]()
    
    var diffPassedOver : String!
    
    var cards = [Card]()
    
    //var gameManager: Game!
    
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
        playerNameLabel.text = Player.sharedInstance.name
       // gameManager = Game(chosenDifficulty : diffPassedOver)
        cards = gameManager.allCards
        startTimer()
        
    }

    override func didReceiveMemoryWarning() {		
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameManager.numOfCols
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameManager.numOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let index = gameManager.numOfCols * indexPath.section + indexPath.item
    
       print(gameManager.numOfRows)
         print( "cols")
        print(gameManager.numOfCols)
        
         cell.myLabel.text = String(cards[index].cardId)
        
        
        
      
        
        if cards[index].isMatched {
        
            cell.cardImage.image = cardImages[cards[index].cardId]  //show front of the card
            
        } else if cards[index].isOpened {
            cell.cardImage.image = cardImages[cards[index].cardId]  //show front of the card
        }
        else {
            cell.cardImage.image = cardImages[0] //show back of the card
        }
        
        allCells.append(cell)
        return cell
        
    }
   
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let index = gameManager.numOfCols * indexPath.section + indexPath.item
        
        print(index)
    

        gameManager.selectCard(index:  index)
        
        cards = gameManager.allCards //maybe unesseccery
        
        if cards[index].isMatched {
        
            cell.cardImage.image = cardImages[cards[index].cardId]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
            lastCell = nil
            
            if gameManager.isGameOver() {
                performSegue(withIdentifier: "endGame", sender: self)
            }

        } else if cards[index].isOpened {
            if lastCell == nil {
                lastCell = cell
            }
    
            cell.cardImage.image = cardImages[cards[index].cardId]
            CollectionViewCell.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        
        else {
            
            if lastCell != nil && lastCell != cell {
                
                cell.cardImage.image = cardImages[cards[index].cardId]
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
    
    func startTimer(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
    }
    
 @objc func updateTime(){
        timerLabel.text = "\(self.seconds)"
        if seconds > 0 {
            seconds -= 1
        }
        else {
            countdownTimer.invalidate()
            gameOver()
        }
    }
    
    
    
    func gameOver(){
        
        let alert = UIAlertController(title: "Oh No!", message: "You run out of time, better luck next time!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in
            self.performSegue(withIdentifier: "selectDifficulty", sender: self)
        }))
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    

    

}
