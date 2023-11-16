//
//  FFStepThreeViewController.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 12/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Kingfisher

class FFStepThreeViewController: FFAddRecipeBaseController, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet weak var addImageBtn:UIButton!
    @IBOutlet weak var imageCollectionview:UICollectionView!
    @IBOutlet weak var scrollview:UIScrollView!
    
    @IBOutlet weak var collectionviewHeightConstraint: NSLayoutConstraint!
    var imagearray = [Any]()
    var imagePicker = UIImagePickerController()
    
    var deleteArray = [String]()
    
    @IBOutlet weak var publicBtn:UIButton!
    @IBOutlet weak var privateBtn:UIButton!
    @IBOutlet weak var publicView:UIView!
    @IBOutlet weak var privateView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        customiseBtn(button: publicBtn)
        customiseBtn(button: privateBtn)

        
        imageCollectionview.dataSource = self
        imageCollectionview.delegate = self
    
        if recipeRequest?.isEdit == true {
            populateData()
        }
        recipeRequest?.isPrivate = 0

        hideOrShowTick(btn: publicBtn, shouldShow: true)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        adjustImageAndTitleOffsetsForButton(button: addImageBtn)
    }

    
    func customiseBtn(button: UIButton){
        
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        button.layer.borderWidth = 0.5
        
        button.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: UIControl.State.normal)
        button.setTitleColor(UIColor.primary, for: UIControl.State.selected)
    }
    
    func hideOrShowTick(btn:UIButton, shouldShow:Bool ){ // show/hide selection tick mark
        
        let superview = btn.superview
        let tick = superview?.viewWithTag(100) as! UIImageView
        tick.isHidden = !shouldShow
        
        if shouldShow == true {
            btn.layer.borderColor = UIColor.primary.cgColor
        }else {
            btn.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
    }
    
    @IBAction func publicBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        
//        publicView.isHidden = false
//        privateView.isHidden = true
        recipeRequest?.isPrivate = 0
        publicBtn.isSelected = false
        privateBtn.isSelected = false
        
        hideOrShowTick(btn: publicBtn, shouldShow: false)
        hideOrShowTick(btn: privateBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }
    
    @IBAction func privateBtnTapped(_ sender : UIButton) { // dificulty buton selection action
//        publicView.isHidden = true
//        privateView.isHidden = false
        recipeRequest?.isPrivate = 1

        publicBtn.isSelected = false
        privateBtn.isSelected = false
        
        hideOrShowTick(btn: publicBtn, shouldShow: false)
        hideOrShowTick(btn: privateBtn, shouldShow: false)
        
        sender.isSelected = true
        hideOrShowTick(btn: sender, shouldShow: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateData(){
        self.imagearray = (recipeRequest?.images)!
        imageCollectionview.layoutIfNeeded()
        imageCollectionview.reloadData()
        self.collectionviewHeightConstraint.constant = self.imageCollectionview.contentSize.height
    }
    
    func adjustImageAndTitleOffsetsForButton (button: UIButton) {
        
        let spacing: CGFloat = 6.0
        
        let imageSize = button.imageView!.frame.size
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
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
            if self.imagearray.count > 0{
                self.addImageBtn.setTitle("Add another photo", for: .normal)
            }
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
        
       
        picker.dismiss(animated: true, completion: nil)
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagearray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
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
        
        return cell
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
        let cellWidth = collectionView.bounds.width
        return CGSize(width: cellWidth, height: cellWidth)
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
    
    @IBAction func addRecipeBtnTapped(_ sender: Any){ // add recipe buttin action
      
        
        if imagearray.count > 0 {
            
        }else {
            FFBaseClass.sharedInstance.showAlert(mesage: "\(StringConstants.recipes.Addatleastoneimage)", view: self)
            return
        }
       
        if imagearray.count > 0 && imagearray[0] is FFImageObject {
            recipeRequest?.img0 = (imagearray[0] as! FFImageObject).name
        }
        if imagearray.count > 1 && imagearray[1] is FFImageObject {
            recipeRequest?.img1 = (imagearray[1] as! FFImageObject).name
        }
         if imagearray.count > 2 && imagearray[2] is FFImageObject {
            recipeRequest?.img2 = (imagearray[2] as! FFImageObject).name
        }
         if imagearray.count > 3 && imagearray[3] is FFImageObject {
            recipeRequest?.img3 = (imagearray[3] as! FFImageObject).name
        }
         if imagearray.count > 4 && imagearray[4] is FFImageObject {
            recipeRequest?.img4 = (imagearray[4] as! FFImageObject).name
        }
         if imagearray.count > 5 && imagearray[5] is FFImageObject {
            recipeRequest?.img5 = (imagearray[5] as! FFImageObject).name
        }
        
        if deleteArray.count > 0 {
            recipeRequest?.deleteUrls = deleteArray.joined(separator: ",")
        }
        recipeRequest?.ok = "1"
        
        print(self.recipeRequest)
                
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.postRecipe(recipeRequest: self.recipeRequest, success: { (response) in
            print(response)
//             self.navigationController?.popToRootViewController(animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyRecipesVC") as! FFMyRecipesViewController
            self.navigationController?.pushViewController(vc, animated: true)
            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
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

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.1
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}
