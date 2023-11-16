//
//  FFSecondPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 11/30/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFSecondPrefernceViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    var interestList:[FFRecipeTypeObject] = []

    @IBOutlet weak var interestCollectionView:UICollectionView!
    @IBOutlet weak var interestCollectionViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var headLabel:UILabel!
    var selectedTheme = ""
    var interstIDs: [String] = []
    var isAPIRequest: Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()
        interestCollectionView.dataSource  = self
        interestCollectionView.delegate = self
        getInterests()
        headLabel.text = "\(StringConstants.userPreference.Whichdietsarerightforyou)"
        // Do any additional setup after loading the view.
    }
    
    
    func getInterests(){ // interetst list webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getInterestList(success: { (response) in
            print(response)
            self.isAPIRequest = true
            self.interestList = response
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                self.interestCollectionView.reloadData()
            }
            
            
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    //MARK: - Collectionview methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
//        cell.backgroundColor = UIColor.red
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        let cellSize = collectionView.bounds.size.width / 2
        let tenth = (10 * cellSize)/100
        let interestImage = UIImageView()
        interestImage.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
        interestImage.layer.cornerRadius = 4
        interestImage.layer.borderWidth = 1.0
        interestImage.layer.borderColor = UIColor.gray.cgColor
      
        if let imageList = self.interestList[indexPath.row].imageMedium {
                   let imageUrl:URL = URL(string: imageList)!
            interestImage.kf.setImage(with: imageUrl)
               }
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: interestImage.frame.height, width: cellSize - tenth, height: tenth)
        if let name = self.interestList[indexPath.row].name{
            label.text = name

        }
        if self.interestList[indexPath.row].isSelected == true{
            interestImage.layer.borderColor = UIColor.primary.cgColor
            label.textColor = UIColor.primary

        }else{

        }
        cell.addSubview(interestImage)
        cell.addSubview(label)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedTheme = "\(self.interestList[indexPath.row].id ?? 0)"
        if self.interestList[indexPath.row].isSelected == true{
            self.interestList[indexPath.row].isSelected = false

        }else{
            self.interestList[indexPath.row].isSelected = true

        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.bounds.size.width / 2
        let tenth = (10 * cellSize)/100

        return CGSize(width: cellSize - tenth, height: cellSize)
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        // 2
        case UICollectionView.elementKindSectionFooter:
          // 3
          guard
            let footerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: "\(PrefernceCollectionReusableView.self)",
              for: indexPath) as? PrefernceCollectionReusableView
            else {
              fatalError("Invalid view type")
          }
            footerView.skipButton.setTitle("\(StringConstants.userPreference.Everythingsuitsme)", for: .normal)

            footerView.skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
            footerView.nextButton.addTarget(self, action: #selector(nextButton), for: .touchUpInside)
            
   
          return footerView

        default:
          // 4
            fatalError("Unexpected element kind")
        }
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        if isAPIRequest!{
//        return CGSize(width: collectionView.bounds.width, height: 148)
//        }else{
//            return CGSize(width: 0,height: 0)
//        }
//    }
        
    
    @objc func skipAction(_ sender: UIButton){
        gotToNext()
    }
    
    @objc func nextButton(_ sender: UIButton){
        
        for i in 0...self.interestList.count - 1{
            if self.interestList[i].isSelected == true{
                self.interstIDs.append("\(self.interestList[i].id ?? 0)")
            }else{
            }
        }
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeInterest(isMultiple: true, interstIDs: interstIDs, interstID: "1", success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            self.gotToNext()
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func gotToNext(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFThirdPrefernceVC") as! FFThirdPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
