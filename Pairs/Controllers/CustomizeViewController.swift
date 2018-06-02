//
//  CustomizeViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 6/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {
    

    var cardImages : [UIImage] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardImages = DataManager.sharedInstance.getDefaultCardsArray()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomizeCardsViewCell
        cell.cellLabel.text = String(indexPath.item)
        cell.cellImage.image = cardImages[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomizeCardsViewCell
        
    
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}
