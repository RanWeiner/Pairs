//
//  EndGameViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 4/7/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    var difficulty : String!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "startOver" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.diffPassedOver = difficulty
           
        }
            
        else  if segue.identifier == "mainMenu" {
            //let destinationVC = segue.destination as! ViewController
        }
       
    }
    
    @IBAction func startOverBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "startOver", sender: self)
    }
    
    @IBAction func mainMenuBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "mainMenu", sender: self)
    }

}