//
//  HighScoreViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 5/30/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
  
    @IBOutlet weak var tableLabel: UILabel!
   
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var hardBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var easyBtn: UIButton!
    
    var highScoresArray = [HighScoreRecord]()
    var tableName = Player.sharedInstance.playerDifficulty

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableLabel.text = tableName
        highScoresArray = DataManager.sharedInstance.getAllRecordsByDifficulty(difficulty: tableName)
        
        toggleButton(difficulty: tableName)
        setButtons()
        
        
     
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func setButtons(){
        easyBtn.addTarget(self, action: #selector(easyBtnPressed), for: .touchUpInside)
        mediumBtn.addTarget(self, action: #selector(mediumBtnPressed), for: .touchUpInside)
        hardBtn.addTarget(self, action: #selector(hardBtnPressed), for: .touchUpInside)
    }
    
    
    
    func toggleButton(difficulty : String){
        switch difficulty {
        case "Easy":
            easyBtn.isSelected = true
            mediumBtn.isSelected = false
            hardBtn.isSelected = false
        case "Medium":
            easyBtn.isSelected = false
            mediumBtn.isSelected = true
            hardBtn.isSelected = false
        case "Hard":
            easyBtn.isSelected = false
            mediumBtn.isSelected = false
            hardBtn.isSelected = true
            
        default:
            print("Error in toggle")
        }
    }
    
    
    @objc func easyBtnPressed() {
        if (easyBtn.isSelected) {
            return
        }
        tableName = "Easy"
        toggleButton(difficulty: tableName)
        tableLabel.text = tableName
        highScoresArray = DataManager.sharedInstance.getAllRecordsByDifficulty(difficulty: tableName)
        tableView.reloadData()
    }
   
    @objc func mediumBtnPressed() {
        if (mediumBtn.isSelected) {
            return
        }
        tableName = "Medium"
        toggleButton(difficulty: tableName)
        tableLabel.text = tableName
        highScoresArray = DataManager.sharedInstance.getAllRecordsByDifficulty(difficulty: tableName)
        tableView.reloadData()
    }
    
    @objc func hardBtnPressed() {
        if (hardBtn.isSelected) {
            return
        }
        tableName = "Hard"
        toggleButton(difficulty: tableName)
        tableLabel.text = tableName
        highScoresArray = DataManager.sharedInstance.getAllRecordsByDifficulty(difficulty: tableName)
        tableView.reloadData()
    }
    

    
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


