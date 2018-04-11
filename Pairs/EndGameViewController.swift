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

    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = Player.sharedInstance.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      /*  if segue.identifier == "startOver" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.diffPassedOver = difficulty
           
        }
        */
         if segue.identifier == "mainMenu" {
            //let destinationVC = segue.destination as! ViewController
        }
       
    }
 */
    
    @IBAction func startOverBtnPressed(_ sender: UIButton) {
        //restart game
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func mainMenuBtnPressed(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)

    }

}
