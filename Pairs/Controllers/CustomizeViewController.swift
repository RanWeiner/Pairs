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
    private let numberOfItemsPerRow: CGFloat = 3.0
    private let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom:
        2.0, right: 2.0)
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
                cell.backgroundColor = UIColor(red: 1, green: 223/255, blue: 186/255, alpha: 1)
        }
        else if (indexPath.item < 8)
        {
            cell.cellLabel.text = Game.MEDIUM
            cell.backgroundColor = UIColor(red: 186/255, green: 1, blue: 201/255, alpha: 1)
        }
        else {
            cell.cellLabel.text = Game.HARD
            cell.backgroundColor = UIColor(red: 186/255, green: 225/255, blue: 1, alpha: 1)
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
                                let resizedImage = uploadedImage?.resizeImage(targetSize: CGSize(width: 99, height: 141))
                                DataManager.sharedInstance.saveImage(image: resizedImage!, index: (self.selectedCell?.getIndex())!)
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
        
        let resizedImage = pickedImage.resizeImage(targetSize: CGSize(width: 99, height: 141))
        selectedCell?.cellImage.image = resizedImage
        picker.dismiss(animated: true, completion: nil)
        DataManager.sharedInstance.saveImage(image: resizedImage, index: (selectedCell?.getIndex())!)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker:
        UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    

}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


extension CustomizeViewController : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (numberOfItemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / numberOfItemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
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
