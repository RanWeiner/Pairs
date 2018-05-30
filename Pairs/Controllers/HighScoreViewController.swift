//
//  HighScoreViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 5/30/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
  
    
    @IBOutlet weak var tableView: UITableView!
    
  
    var highScoresArray = [HighScoreRecord]()
    let tableName = Player.sharedInstance.playerDifficulty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
         self.navigationController?.popToRootViewController(animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return highScoresArray.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HighScoreCell
        
        let record = highScoresArray[indexPath.row]
        
        cell.setHighScore(hsRank: indexPath.row + 1, hs: record)
       
        return cell
    }

}
