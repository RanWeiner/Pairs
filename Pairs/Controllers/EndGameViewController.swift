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
    
    
    @IBAction func highScoreBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main" , bundle : nil)
        let viewController =   storyboard.instantiateViewController(withIdentifier: "HighScoreViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func mainMenuBtnPressed(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)

    }

}
