//
//  ViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 3/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var diffPicker: UIPickerView!
  
    let difficulties = ["Easy" , "Medium", "Hard"]
    var diffChosen : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diffPicker.delegate = self
        diffPicker.dataSource = self
        diffChosen = difficulties[0]
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return difficulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        diffChosen = difficulties[row]
       
       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func highScoresBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main" , bundle : nil)
        let viewController =   storyboard.instantiateViewController(withIdentifier: "HighScoreViewController") 
        Player.sharedInstance.playerDifficulty = diffChosen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main" , bundle : nil)
        let viewController =   storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        Player.sharedInstance.playerDifficulty = diffChosen
        navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    @IBAction func customizeCardsBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main" , bundle : nil)
        let viewController =   storyboard.instantiateViewController(withIdentifier: "CustomizeViewController")
        Player.sharedInstance.playerDifficulty = diffChosen
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

