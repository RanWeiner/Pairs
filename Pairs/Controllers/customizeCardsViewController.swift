//
//  CustomizeCardsViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 6/1/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

//class CustomizeCardsViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {
    class CustomizeCardsViewController: UIViewController {

    var cardsImages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        cardsImages = DataManager.sharedInstance.getDefaultCardsArray()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
        
   /*
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }*/
    

    

 

}
