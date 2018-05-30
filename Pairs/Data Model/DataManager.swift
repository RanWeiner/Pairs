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

class DataManager{
    
    static let sharedInstance = DataManager()
    
    var records : [HighScoreRecord]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    
    
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
    /*
    func getWorstRecord(difficulty : String) -> HighScoreRecord? {
        
    }*/
    
    func isTableEmpty(difficulty : String) -> Bool{
        return false
    }
    
    func isTableFull(difficulty : String) -> Bool {
        return false
    }
    
    func getAllRecords(difficulty : String) -> [HighScoreRecord]{
        var allRecords = [HighScoreRecord]()
        let request : NSFetchRequest<HighScoreRecord> = HighScoreRecord.fetchRequest()
        do{
           allRecords = try  context.fetch(request)
        }catch {
            print("Error fetching data from context!")
        }
        
        return allRecords
       
        
    }
    
    
}
