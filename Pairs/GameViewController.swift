//
//  GameViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 3/28/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var diffPassedOver : String!
    let items = ["0","1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(diffPassedOver)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {		
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.myLabel.text = items[indexPath.item]
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
