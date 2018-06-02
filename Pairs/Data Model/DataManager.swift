//
//  DataManager.swift
//  Pairs
//
//  Created by Ran Weiner on 5/29/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    let MAX_RECORDS_FOR_DIFFICULTY = 10
    
    let backOfCardImage: UIImage = UIImage(named: "backofcard")!
    
    let defaultCardsImages: [UIImage] = [UIImage(named: "banana")!,UIImage(named: "apple")!,UIImage(named: "coconut")!, UIImage(named: "grape" )!,UIImage(named: "kiwi")!,UIImage(named: "orange")!,UIImage(named: "pear")!,UIImage(named: "pinapple")!,UIImage(named: "strawberry")!,UIImage(named: "watermelon")!]
    
    var activeCards : [UIImage] = [UIImage(named: "banana")!,UIImage(named: "apple")!,UIImage(named: "coconut")!, UIImage(named: "grape" )!,UIImage(named: "kiwi")!,UIImage(named: "orange")!,UIImage(named: "pear")!,UIImage(named: "pinapple")!,UIImage(named: "strawberry")!,UIImage(named: "watermelon")!]
    
    static let sharedInstance = DataManager()
    
    var records : [HighScoreRecord]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    
    
    func getDefaultCardsArray() -> [UIImage] {
        return self.defaultCardsImages
    }
  
    func saveRecordToTable(hs: HighScore){
   
        
        let entity = NSEntityDescription.entity(forEntityName: "HighScoreRecord" , in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(hs.playerName, forKey: "name")
        manageObject.setValue(hs.score, forKey: "score")
        manageObject.setValue(hs.difficulty, forKey: "difficulty")
        manageObject.setValue(hs.secondsPlayed, forKey: "seconds")
        
        do{
            try context.save()
            
        }catch{
            print("Error saving highscore")
        }
    }
    
    
    
  
    
    func deleteLowestRecord(difficulty : String){
        var recordsRequested = [HighScoreRecord]()
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty = %@", difficulty)
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor.init(key: "seconds", ascending: false)]
        do {
            recordsRequested = try context.fetch(request)
            let lowest = recordsRequested.first
            context.delete(lowest!)
            try context.save()
            
        } catch  {
            print("Error removing data from context!")
        }
        

    }
    
    
    
    func isTableFull(difficulty : String) -> Bool {
        
        var count: Int = 0
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "difficulty = %@", difficulty)
        
        do {
            count = try context.count(for: request)
        } catch {
            print("Error counting data")
        }
        
        return count >= MAX_RECORDS_FOR_DIFFICULTY
    }
    
    
    
    func getAllRecordsByDifficulty(difficulty : String) -> [HighScoreRecord]{
        
        var allRecords = [HighScoreRecord]()
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty = %@", difficulty)
        request.sortDescriptors = [NSSortDescriptor.init(key: "seconds" , ascending: true)]
        
        do{
           allRecords = try  context.fetch(request)
        }catch {
            print("Error fetching data from context!")
        }
    
        return allRecords
    }
    
    
    
    
    func fetchLowestRecordScore(difficulty : String) -> Int {
        var recordsRequested = [HighScoreRecord]()
        var lowest : HighScoreRecord
        var lowestScore = -1
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty = %@", difficulty)
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor.init(key: "seconds", ascending: false)]
        do {
            recordsRequested = try context.fetch(request)
            lowest = recordsRequested.first!
            lowestScore = Int(lowest.seconds)
        } catch  {
             print("Error fetching highscores from context!")
        }
        
        return lowestScore
    }
    
    func getAllImages() -> [UIImage]{
        updateAllImages()
        return activeCards
    }
    
    
    func restoreCardsToDefault() {
        self.activeCards = self.defaultCardsImages
    }
    
    func updateAllImages() {
        let request = NSFetchRequest<Images>(entityName: "Images")
        do {
           
            let allImages = try context.fetch(request)
        
            for image in allImages {
                
                let index = Int(image.arrayIndex)
                let filePath = image.filePath
                
                if FileManager.default.fileExists(atPath: filePath!){
                    let contentsOfFilePath = UIImage(contentsOfFile: filePath!)
                    
                    activeCards[index] = contentsOfFilePath!
                }
              
            
            }
        }catch {
            print("Error fetching Images from context!")
        }
    }
    
}
