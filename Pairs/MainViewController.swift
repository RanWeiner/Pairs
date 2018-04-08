//
//  MainViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 4/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Please fill out yout name in order to continue", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
       present(alert, animated: true, completion: nil)
    
       
    }

    @IBAction func nextButton(_ sender: UIButton) {
       
        guard let text = nameTextField.text, !text.isEmpty else {
            showAlert()
            return
        }
        
        Player.sharedInstance.name = text
        performSegue(withIdentifier: "selectDifficulty", sender: self)
        
    }

   

}

