//
//  FFThirdPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/1/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFThirdPrefernceViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    @IBOutlet weak var categoriesCollectionView:UICollectionView!
    @IBOutlet weak var headLabel:UILabel!
    var universeList:[FFUniverseObject] = []
    var firstdishList:[FFRecipeTypeObject] = []
    var seconddishList:[FFRecipeTypeObject] = []
    var thirddishList:[FFRecipeTypeObject] = []
    var fourthdishList:[FFRecipeTypeObject] = []
    var selectedFirst = ""
    var selectedSecond = ""
    var selectedThird = ""
    var selectedFourth = ""
    var catIDs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView.dataSource  = self
        categoriesCollectionView.delegate = self
        headLabel.text = "\(StringConstants.userPreference.Whichdietsarerightforyou)"
        getUniverse()
        // Do any additional setup after loading the view.
    }
    func getUniverse(){ // dish list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getUniverseList(success: { (response) in
            print(response)
            self.universeList = response
            
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                                
                for i in 0...self.universeList.count - 1{
                    self.getDishes(universeId: "\(self.universeList[i].id ?? 0)", whichOne: i)
                }
                
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func getDishes(universeId: String?, whichOne: Int?){ // dish list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getDishesList(id:universeId, success: { (response) in
            print(response)
            if whichOne == 0{
                self.firstdishList = response

            }else if whichOne == 1{
                self.seconddishList = response

            }else if whichOne == 2{
                self.thirddishList = response

            }else{
                self.fourthdishList = response

            }
            FFLoaderView.hideInView(view: self.view)
            self.categoriesCollectionView.isHidden = false
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
                self.categoriesCollectionView.layoutIfNeeded()
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func callLikeCategoryAPI(){ // like category webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeCategory(isMultiple: true, categoryIDs: catIDs, recipeID: "1", success: { (response) in
            print(response)
            FFLoaderView.hideInView(view: self.view)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFourthPrefernceVC") as! FFFourthPrefernceViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
    }
    

    //MARK: - Collectionview methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return universeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return firstdishList.count
        }else if section == 1{
            return seconddishList.count
        }else if section == 2{
            return thirddishList.count
        }else if section == 3{
            return fourthdishList.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectCell: UICollectionViewCell = UICollectionViewCell()
        if indexPath.section == 0{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
//        cell.backgroundColor = UIColor.red
            for view in cell.subviews {
                view.removeFromSuperview()
            }
        let cellSize = collectionView.bounds.size.width / 2
        let tenth = (10 * cellSize)/100
        let interestImage = UIImageView()
        interestImage.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
            interestImage.layer.borderWidth = 1.0
            interestImage.layer.masksToBounds = false
            interestImage.layer.borderColor = UIColor.gray.cgColor
            interestImage.layer.cornerRadius = interestImage.frame.height/2
            interestImage.clipsToBounds = true

        if let imageList = self.firstdishList[indexPath.row].imageMedium {
                   let imageUrl:URL = URL(string: imageList)!
            interestImage.kf.setImage(with: imageUrl)
               }
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: interestImage.frame.height, width: cellSize - tenth, height: tenth)
        label.text = " \(self.firstdishList[indexPath.row].name!) "
        label.textAlignment = .center
            
            if self.firstdishList[indexPath.row].isSelected == true{
                interestImage.layer.borderColor = UIColor.primary.cgColor
                label.textColor = UIColor.primary
            }else {
                
            }
        cell.addSubview(interestImage)
        cell.addSubview(label)
            
         
            collectCell = cell
        }else if indexPath.section == 1{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
            for view in cell.subviews {
                view.removeFromSuperview()
            }
    //        cell.backgroundColor = UIColor.red
            let cellSize = collectionView.bounds.size.width / 2
            let tenth = (10 * cellSize)/100
            let interestImage = UIImageView()
            interestImage.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
            interestImage.layer.borderWidth = 1.0
                interestImage.layer.masksToBounds = false
                interestImage.layer.borderColor = UIColor.gray.cgColor
                interestImage.layer.cornerRadius = interestImage.frame.height/2
                interestImage.clipsToBounds = true

            if let imageList = self.seconddishList[indexPath.row].imageMedium {
                       let imageUrl:URL = URL(string: imageList)!
                interestImage.kf.setImage(with: imageUrl)
                   }
            
            let label = UILabel()
            label.frame = CGRect(x: 0, y: interestImage.frame.height, width: cellSize - tenth, height: tenth)
            label.text = " \(self.seconddishList[indexPath.row].name!) "
            label.textAlignment = .center
            if self.seconddishList[indexPath.row].isSelected == true{
                interestImage.layer.borderColor = UIColor.primary.cgColor
                label.textColor = UIColor.primary
            }else {
                
            }
            cell.addSubview(interestImage)
            cell.addSubview(label)
                collectCell = cell
            }else if indexPath.section == 2{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
                for view in cell.subviews {
                    view.removeFromSuperview()
                }
        //        cell.backgroundColor = UIColor.red
                let cellSize = collectionView.bounds.size.width / 2
                let tenth = (10 * cellSize)/100
                let interestImage = UIImageView()
                interestImage.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
                interestImage.layer.borderWidth = 1.0
                    interestImage.layer.masksToBounds = false
                    interestImage.layer.borderColor = UIColor.gray.cgColor
                    interestImage.layer.cornerRadius = interestImage.frame.height/2
                    interestImage.clipsToBounds = true

                if let imageList = self.thirddishList[indexPath.row].imageMedium {
                           let imageUrl:URL = URL(string: imageList)!
                    interestImage.kf.setImage(with: imageUrl)
                       }
                
                let label = UILabel()
                label.frame = CGRect(x: 0, y: interestImage.frame.height, width: cellSize - tenth, height: tenth)
                label.text = " \(self.thirddishList[indexPath.row].name!) "
                label.textAlignment = .center
                
                if self.thirddishList[indexPath.row].isSelected == true{
                    interestImage.layer.borderColor = UIColor.primary.cgColor
                    label.textColor = UIColor.primary
                }else {
                    
                }
                cell.addSubview(interestImage)
                cell.addSubview(label)
                    collectCell = cell
                }else{
                    
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
                    for view in cell.subviews {
                        view.removeFromSuperview()
                    }
            //        cell.backgroundColor = UIColor.red
                    let cellSize = collectionView.bounds.size.width / 2
                    let tenth = (10 * cellSize)/100
                    let interestImage = UIImageView()
                    interestImage.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
                    interestImage.layer.borderWidth = 1.0
                        interestImage.layer.masksToBounds = false
                        interestImage.layer.borderColor = UIColor.gray.cgColor
                        interestImage.layer.cornerRadius = interestImage.frame.height/2
                        interestImage.clipsToBounds = true

                    if let imageList = self.fourthdishList[indexPath.row].imageMedium {
                               let imageUrl:URL = URL(string: imageList)!
                        interestImage.kf.setImage(with: imageUrl)
                           }
                    
                    let label = UILabel()
                    label.frame = CGRect(x: 0, y: interestImage.frame.height, width: cellSize - tenth, height: tenth)
                    if let name = self.fourthdishList[indexPath.row].name{
                        label.text = name

                    }
                    label.textAlignment = .center
                    if self.fourthdishList[indexPath.row].isSelected == true{
                        interestImage.layer.borderColor = UIColor.primary.cgColor
                        label.textColor = UIColor.primary
                    }else {
                        
                    }
                    cell.addSubview(interestImage)
                    cell.addSubview(label)
                        collectCell = cell
                    }
        return collectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
//            selectedFirst = "\(self.firstdishList[indexPath.row].id ?? 0)"
            if self.firstdishList[indexPath.row].isSelected == true{
                self.firstdishList[indexPath.row].isSelected = false

            }else{
                self.firstdishList[indexPath.row].isSelected = true

            }
        }else if indexPath.section == 1{
            selectedSecond = "\(self.seconddishList[indexPath.row].id ?? 0)"
            if self.seconddishList[indexPath.row].isSelected == true{
                self.seconddishList[indexPath.row].isSelected = false

            }else{
                self.seconddishList[indexPath.row].isSelected = true
            }
        }else if indexPath.section == 2{
            selectedThird = "\(self.thirddishList[indexPath.row].id ?? 0)"
            if self.thirddishList[indexPath.row].isSelected == true{
                self.thirddishList[indexPath.row].isSelected = false

            }else{
                self.thirddishList[indexPath.row].isSelected = true
            }
        }else if indexPath.section == 3{
            selectedFourth = "\(self.fourthdishList[indexPath.row].id ?? 0)"
            if self.fourthdishList[indexPath.row].isSelected == true{
                self.fourthdishList[indexPath.row].isSelected = false

            }else{
                self.fourthdishList[indexPath.row].isSelected = true
            }
        }else{
            
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
        
        case UICollectionView.elementKindSectionHeader:
          // 3
          guard
            let headerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: "\(PrefernceHeaderReusableView.self)",
              for: indexPath) as? PrefernceHeaderReusableView
            else {
              fatalError("Invalid view type")
          }
            headerView.univereLabel.text = " \(self.universeList[indexPath.section].universe_name!) "
          return headerView

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(section==3) {
            return CGSize(width:collectionView.frame.size.width, height:148)
        }  else {
            return CGSize.zero
        }

    }

    
    
    @objc func skipAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFFourthPrefernceVC") as! FFFourthPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func nextButton(_ sender: UIButton){
        
        for i in 0...self.firstdishList.count - 1{
            if self.firstdishList[i].isSelected == true{
                self.catIDs.append("\(self.firstdishList[i].id ?? 0)")
            }else{
            }
        }
        
        for i in 0...self.seconddishList.count - 1{
            if self.seconddishList[i].isSelected == true{
                self.catIDs.append("\(self.seconddishList[i].id ?? 0)")
            }else{
            }
        }
        
        for i in 0...self.thirddishList.count - 1{
            if self.thirddishList[i].isSelected == true{
                self.catIDs.append("\(self.thirddishList[i].id ?? 0)")
            }else{
            }
        }
        for i in 0...self.fourthdishList.count - 1{
            if self.fourthdishList[i].isSelected == true{
                self.catIDs.append("\(self.fourthdishList[i].id ?? 0)")
            }else{
            }
        }
        
        callLikeCategoryAPI()

        
    }
    

}

