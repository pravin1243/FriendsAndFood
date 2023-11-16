//
//  FFAddStoreStepThreeVC.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 04/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFAddStoreStepThreeVC: FFSuggestStoreBaseController,UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var addImageBtn:UIButton!
    @IBOutlet weak var imageCollectionview:UICollectionView!
    @IBOutlet weak var collectionviewHeightConstraint: NSLayoutConstraint!
    var imagearray = [Any]()
    var imagePicker = UIImagePickerController()
    var deleteArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectionview.dataSource = self
        imageCollectionview.delegate = self

        // Do any additional setup after loading the view.
    }
    

     override func viewWillAppear(_ animated: Bool) {
             adjustImageAndTitleOffsetsForButton(button: addImageBtn)
         }
        
        func adjustImageAndTitleOffsetsForButton (button: UIButton) { // vertically align text and image in uibutton
            
            let spacing: CGFloat = 6.0
            
            let imageSize = button.imageView!.frame.size
            
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
            
            let titleSize = button.titleLabel!.frame.size
            button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
            customiseBtn(button: button)
            
        }
        func customiseBtn(button: UIButton){
             
             button.layer.cornerRadius = 4
             button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
             button.layer.borderWidth = 0.5
             
            button.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
            button.setTitleColor(UIColor.primary, for: UIControl.State.selected)
         }
         
        @IBAction func adBtnPresssed(_ sender :Any){ // slect image button action
               imagePicker.delegate = self
               
               if imagearray.count > 6 {
                   FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.addStore.max6images)", view: self)
                   return
               }
        
               let alert = UIAlertController(title: "\(StringConstants.addStore.ChooseanImage)", message: nil, preferredStyle: .actionSheet)
               alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.Takeanimage)", style: .default, handler: { _ in
                   self.openCamera()
               }))
               
               alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.Searchinthegallery)", style: .default, handler: { _ in
                   self.openGallary()
               }))
               
               alert.addAction(UIAlertAction.init(title: "\(StringConstants.addStore.Cancel)", style: .cancel, handler: nil))
               
               self.present(alert, animated: true, completion: nil)
           }
           
           func openCamera()
           {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
               {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                   imagePicker.allowsEditing = true
                   self.present(imagePicker, animated: true, completion: nil)
               }
               else
               {
                   let alert  = UIAlertController(title: "\(StringConstants.addStore.Warning)", message: "\(StringConstants.addStore.Youdonthavecamera)", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "\(StringConstants.addStore.OK)", style: .default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
           }
           
           func openGallary()
           {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
               imagePicker.allowsEditing = true
               self.present(imagePicker, animated: true, completion: nil)
           }

        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        let image             = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let photoURL          = NSURL(fileURLWithPath: documentDirectory)
                
                var imageName: String = "IMG_\(Date().timeIntervalSinceReferenceDate)"
                imageName = imageName.replacingOccurrences(of: ".", with: "")
                imageName.append(".jpg")
                
                let localPath         = photoURL.appendingPathComponent(imageName)
                
                if !FileManager.default.fileExists(atPath: localPath!.path) {
                    do {
                        try image.pngData()?.write(to: localPath!)
                        print("file saved")
                    }catch {
                        print("error saving file")
                    }
                }
                else {
                    print("file already exists")
                }
                
        //        let imgData = image.UIImageJPEGRepresentation(compressionQuality: 0.2)

                
                let imageData = image.jpeg(.low) ?? Data()
                
                FFLoaderView.showInView(view: self.view)
        FFManagerClass.uploadRestImageData(imageName: imageName, imageData: imageData, success: { (resp) in
                    print(resp)
                    FFLoaderView.hideInView(view: self.view)
                    self.imagearray.append((resp.files?.first)!)
        //            self.uploadedImageArray.append((resp.files?.first)!)
                    self.imageCollectionview.reloadData()
                    self.imageCollectionview.layoutIfNeeded()
                    self.collectionviewHeightConstraint.constant = self.imageCollectionview.contentSize.height
                }) { (error) in
                    FFLoaderView.hideInView(view: self.view)
                    FFBaseClass.sharedInstance.showError(error: error, view: self)
                    print(error)
                }
                
                
               
                picker.dismiss(animated: true, completion: nil)
            }
            
            

            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                if collectionView == imageCollectionview{
                return imagearray.count
                }else{
                    return 0
                }
                
    }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                var collectCell: UICollectionViewCell = UICollectionViewCell()
              if collectionView == imageCollectionview{

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeImageCell", for: indexPath)
                
                let imageView = cell.viewWithTag(100) as! UIImageView
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                let imageUrl:URL?
                
                let item = imagearray[indexPath.row]
                if item is FFImageObject {
                    imageUrl  = URL(string: (item as! FFImageObject).url!)!
                }else {
                    imageUrl = URL(string: (imagearray[indexPath.row] as! FFRecipeTypeObject).name as! String)!
                }
                
                
                imageView.kf.setImage(with: imageUrl)
                let closeBtn = cell.viewWithTag(200) as! UIButton
                closeBtn.titleLabel?.tag = indexPath.row
                closeBtn.addTarget(self, action: #selector(closeImageBtnPressed(_:)), for: .touchUpInside)
                collectCell = cell
              }
                return collectCell
            }
            
            @objc func closeImageBtnPressed(_ sender: UIButton){ // delete image button action
                
                let item = imagearray[(sender.titleLabel?.tag)!]
               
                if item is FFImageObject {
                    
                }else {
                    let itemObj:FFRecipeTypeObject = item as! FFRecipeTypeObject
                    if let id = itemObj.id {
                     deleteArray.append("\(id)")
                    }
                }
                imagearray.remove(at: (sender.titleLabel?.tag)! )
                
                imageCollectionview.reloadData()
                imageCollectionview.layoutIfNeeded()
               self.collectionviewHeightConstraint.constant = self.imageCollectionview.contentSize.height
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if collectionView == imageCollectionview{

                let cellWidth = collectionView.bounds.width
                return CGSize(width: cellWidth, height: cellWidth)
                }else{
                    let cellSize = collectionView.bounds.size.width / 3
                    return CGSize(width: cellSize, height: 100)

                }
            }
            
                func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //        selectedTheme = self.interestList[indexPath.row].stringId!
                    
                }
        
        
        
        
        
        @IBAction func nextBtnTapped(_ sender : Any){
                if imagearray.count > 0 && imagearray[0] is FFImageObject {
                           storeRequest?.image = (imagearray[0] as! FFImageObject).name
                       }
                
                FFLoaderView.showInView(view: self.view)
                FFManagerClass.suggestStore(storeRequest: self.storeRequest, success: { (response) in
                    print(response)
//                     self.navigationController?.popToRootViewController(animated: true)
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreListVC") as! FFStoreListingViewController
//                    self.navigationController?.popToViewController(vc, animated: true)
                    FFLoaderView.hideInView(view: self.view)
                }) { (error) in
                    print(error)
                    FFLoaderView.hideInView(view: self.view)
                    FFBaseClass.sharedInstance.showError(error: error, view: self)
                }

            
        }
        

}
