//
//  Game.swift
//  Pairs
//
//  Created by Ran Weiner on 4/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import Foundation

class Game{
    static let GAME_DURATION = 60
    let difficulties = ["Easy","Medium","Hard"]
    let numOfOfCardsByDifficulty = [12 , 16 , 20]
    let numOfRowsByDiff = [3,4,5]
    let numOfCols = 4
    
    var allCards = [Card]()
    
    var lastIndex : Int = -1
    
    var difficulty : String = ""
    var numOfPairs : Int
    var numOfRows : Int

    
    init(chosenDifficulty : String){
        self.difficulty = chosenDifficulty
        
        switch (chosenDifficulty) {
        case difficulties[0]:
            self.numOfPairs = numOfOfCardsByDifficulty[0]/2
            self.numOfRows = numOfRowsByDiff[0]
            
        case difficulties[1]:
            self.numOfPairs = numOfOfCardsByDifficulty[1]/2
            self.numOfRows = numOfRowsByDiff[1]
            
        case difficulties[2]:
            self.numOfPairs = numOfOfCardsByDifficulty[2]/2
            self.numOfRows = numOfRowsByDiff[2]
            
        default:
            //error
            self.numOfPairs = 0
            self.numOfRows = 0
        }
        
        setCards()
        
    }
    
    
    
    func setCards(){
        var items = [Card]()
        
        for _ in 1...numOfPairs{
            let card = Card()
            items.append(card)
            items.append(card)
        }
        
        //shuffle
        for _ in 1...items.count{
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            allCards.append(items[rand])
            items.remove(at: rand)
        }
    }
    
    
    func hasMatch(cardIndex : Int) -> Bool{
       
        if allCards[cardIndex].cardId == allCards[lastIndex].cardId {
            return true
        }
        return false
    }
    
    
    
    func isGameOver() -> Bool{
        if numOfPairs == 0 {
            return true
        }
        return false
    }
    
    
    
    func showCard(cardIndex : Int){
         allCards[cardIndex].isOpened = true
    }
    
    
    
    func closeCard(cardIndex : Int){
        allCards[cardIndex].isOpened = false
    }
    
    func isTableFull( tableName : String) -> Bool {
        return DataManager.sharedInstance.isTableFull(difficulty: tableName)
    }
    
    func betterThenLowestScore(seconds: Int ,  difficulty : String) -> Bool {
        
        if (isTableFull(tableName: difficulty) == true){
        
            let lowestScore = DataManager.sharedInstance.fetchLowestRecordScore(difficulty: difficulty)
            print(lowestScore)
            if (seconds >= lowestScore){
                return false
            }
        }
        return true
    }
    
    
    
    func addRecord(hs: HighScore){
        if (isTableFull(tableName: hs.difficulty)){
            DataManager.sharedInstance.deleteLowestRecord(difficulty: Player.sharedInstance.playerDifficulty)
        }
        DataManager.sharedInstance.saveRecordToTable(hs: hs)
    }
 
    
    
    func selectCard(index : Int){
        
        let selectedCard = allCards[index]
        
        if selectedCard.isMatched {return}
        
        
        //card open
        if selectedCard.isOpened{
            closeCard(cardIndex: index)
            lastIndex = -1
           
            
        //card closed
        } else {
            showCard(cardIndex: index)
            
            if lastIndex == -1 {
                lastIndex = index
                }
                
            else {
                if hasMatch(cardIndex: index){
                  
                    allCards[index].isMatched = true
                    allCards[lastIndex].isMatched = true
                    lastIndex = -1
                    
                    numOfPairs-=1
                 
                }
          
                else {
                    closeCard(cardIndex: index)
                    closeCard(cardIndex: lastIndex)
                    lastIndex = -1

            }
        
            }
    
    
}
}
}
            
         
    
    
    
  
    
    

