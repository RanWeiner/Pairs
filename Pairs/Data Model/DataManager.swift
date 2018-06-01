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
    
    static let sharedInstance = DataManager()
    
    var records : [HighScoreRecord]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    
    
  
    func saveRecordToTable(hs: HighScore) -> Bool{
   
        
        let entity = NSEntityDescription.entity(forEntityName: "HighScoreRecord" , in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(hs.playerName, forKey: "name")
        manageObject.setValue(hs.score, forKey: "score")
        manageObject.setValue(hs.difficulty, forKey: "difficulty")
        manageObject.setValue(hs.secondsPlayed, forKey: "seconds")
        
        do{
            try context.save()
            return true
        }catch{
            print("error saving record!")
            return false
        }
    }
    
    
    
   /*
    func fetchRecords(tableName : String) -> [HighScoreRecord] {
        var allRecords = [HighScoreRecord]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        
        request.returnsObjectsAsFaults = false
      
        
        do {
            allRecords = try context.fetch(request) as! [HighScoreRecord]
            
        } catch {
            print("error fetching easy records!")
        }
        return allRecords
    }
    */
    
    
   /*
    func saveRecord(hs : HighScore){
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        do{
            let newRecord = HighScoreRecord(context: context)
            newRecord.name = hs.playerName
            newRecord.difficulty = hs.difficulty
            newRecord.score = hs.score
            
            records?.append(newRecord)
        
        try context.save()
        } catch {
            print("error saving records!")
        }
    
       
    }
 */
   
    
    func isTableEmpty(difficulty : String) -> Bool{
        return false
    }
    
    func isTableFull(difficulty : String) -> Bool {
        return false
    }
    
    func getAllRecordsByDifficulty(difficulty : String) -> [HighScoreRecord]{
        
        var allRecords = [HighScoreRecord]()
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty = %@", difficulty)
        do{
           allRecords = try  context.fetch(request)
        }catch {
            print("Error fetching data from context!")
        }
    
        return allRecords
    }
    
    func fetchLowestRecord(tableName : String) -> Any? {
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName : tableName)
        userFetch.fetchLimit = 1
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "seconds", ascending: true)]
        
        userFetch.predicate = NSPredicate(format: "name = %@", "John")
        let lowest = try! context.fetch(userFetch)
        return lowest.first
    }
    
    
}
