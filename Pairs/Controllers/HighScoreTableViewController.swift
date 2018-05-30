//
//  TableViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 5/29/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit


class HighScoreTableViewController: UITableViewController {

    var highScoresArray = [HighScoreRecord]()
    let tableName = Player.sharedInstance.playerDifficulty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (DataManager.sharedInstance.isTableFull(difficulty: tableName) == false) {
            highScoresArray = DataManager.sharedInstance.getAllRecords(difficulty: tableName)
        }
        
        //if (currentTableRecords > 0){
           // highScoresArray = DataManager.sharedInstance.getAllRecords(difficulty: Player.sharedInstance.playerDifficulty)
      //  }
        
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoresArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath) as! HighScoreCell
        
        let record = highScoresArray[indexPath.row]
        
        cell.setHighScore(hsRank: indexPath.row, hs: record)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

  

}
