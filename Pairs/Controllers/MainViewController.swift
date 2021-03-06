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
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        let storyboard = UIStoryboard(name: "Main" , bundle : nil)
        let viewController =   storyboard.instantiateViewController(withIdentifier: "DifficultyViewController")
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func beginEdit(_ sender: UITextField) {
        animateViewMoving(up: true, moveValue: 100)

    }
    @IBAction func editEnd(_ sender: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }

   

}

