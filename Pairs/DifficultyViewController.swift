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

    @IBAction func buttonPressed(_ sender: Any) {
        //navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
        navigationController?.pushViewController(GameViewController() , animated: true)
        //performSegue(withIdentifier: "startGame", sender: self)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.diffPassedOver = diffChosen
        
        }
    }
 */
    
}

