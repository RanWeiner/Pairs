//
//  CustomizeViewController.swift
//  Pairs
//
//  Created by Ran Weiner on 6/2/18.
//  Copyright © 2018 Ran Weiner. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCell: CustomizeCardsViewCell?
    var cardImages : [UIImage] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardImages = DataManager.sharedInstance.getAllImages()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomizeCardsViewCell
        cell.setIndex(index: indexPath.item)
        
        if (indexPath.item < 6){
                cell.cellLabel.text = Game.EASY
                cell.backgroundColor = UIColor.yellow
        }
        else if (indexPath.item < 8)
        {
            cell.cellLabel.text = Game.MEDIUM
            cell.backgroundColor = UIColor.blue
        }
        else {
            cell.cellLabel.text = Game.HARD
            cell.backgroundColor = UIColor.red
        }
       
        cell.cellImage.image = cardImages[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomizeCardsViewCell
        selectedCell = cell
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source",message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera",style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true,
                             completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Camera not Available", message: "you run on simulator, or your device is not supported", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style:
                    UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library",style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true,
                         completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Upload URL",style: .default, handler: { (action:UIAlertAction) in
            self.uploadFromUrl(cell: cell)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func restoreBtnDefaults(_ sender: UIButton) {
        DataManager.sharedInstance.restoreCardsToDefault()
        cardImages = DataManager.sharedInstance.getAllImages()
        collectionView.reloadData()
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func uploadFromUrl(cell: CustomizeCardsViewCell){
        var textField = UITextField()
       
        let alert = UIAlertController(title: "Upload from URL" , message: "" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Upload" ,style: .default){ (action) in
                                    
        if let url = textField.text {
               if url.isURL() && url.isImage(){
                
                    let web = URL(string: url)
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: web!) {
                            DispatchQueue.main.async {
                                let uploadedImage = UIImage(data : data)
                                DataManager.sharedInstance.saveImage(image: uploadedImage!, index: (self.selectedCell?.getIndex())!)
                                self.selectedCell?.cellImage.image = uploadedImage
                            }
                        }
                        else {
                             self.urlErrorAlert()
                        }
                  }
                  } else{
                    self.urlNotValidErrorAlert()
                  }
                }
        }
        
        
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Enter URL"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert , animated: true ,completion: nil)
    }
    
    func urlErrorAlert(){
        let alert = UIAlertController(title: "Oops!", message: "There is no image in the given url...\nPlease try to enter the full path including \"http://\" ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func urlNotValidErrorAlert(){
        let alert = UIAlertController(title: "Oops!", message: "The format of the given url is invalid, please make sure the url is valid", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        selectedCell?.cellImage.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
        DataManager.sharedInstance.saveImage(image: pickedImage, index: (selectedCell?.getIndex())!)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker:
        UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    

}




extension String {
    func isImage() -> Bool {
        let imageFormats = ["jpg","jpeg","png"]
        
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        
        return false
    }
    
    func getExtension() -> String? {
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty{
            return nil
        }
        
        return ext
    }
    
    func isURL() -> Bool {
        return URL(string: self) != nil
    }
}
