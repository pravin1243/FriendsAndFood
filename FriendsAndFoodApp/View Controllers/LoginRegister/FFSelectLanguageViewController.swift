//
//  FFSelectLanguageViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/7/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import DropDown
class FFSelectLanguageViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var selectLanguageLabel:UILabel!
    @IBOutlet weak var selectCountryLabel:UILabel!
    @IBOutlet weak var languageTextField:UITextField!

    @IBOutlet weak var countryCollectionView:UICollectionView!
    @IBOutlet weak var countryCollectionViewHeightConstraint:NSLayoutConstraint!
    let dropDown = DropDown()
    var countryList:[FFPlaceObject] = []
    var langList:[FFLanguageObject] = []
    var languageId: String?
    var selectedCountry: String?
    var deviceLangauge: String?
    var selectedLangCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Languages"

        countryCollectionView.dataSource  = self
        countryCollectionView.delegate = self

        
        selectLanguageLabel.text = "\(StringConstants.selectLanguages.Selectyourlanguage)"
        selectCountryLabel.text = "\(StringConstants.selectLanguages.Selectyourcountryfromthelist)"

        languageTextField.delegate = self
        loadLanguages()
        let langStr = Locale.current.languageCode
        print("Current device language is \(langStr ?? "")")
        deviceLangauge = Locale.current.languageCode
        // Do any additional setup after loading the view.
    }
    
    func customiseDropDown(){ // ingredient  customisation
        dropDown.anchorView = languageTextField
        dropDown.arrowIndicationX = 0
        dropDown.dataSource = langList.map { $0.name! }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.languageTextField.text = "\(item)"
            self.selectedLangCode = "\(self.langList[index].code ?? "")"

            self.languageId = "\(self.langList[index].id ?? 0)"
            self.languageTextField.resignFirstResponder()
            self.dropDown.hide()
            self.loadCountriesByLanguages()
        }
    }
    
    @IBAction func didChangeLanguageTextField(_ sender: UITextField){
           dropDown.hide()
           if (sender.text?.count)! >= 1 {
//               getCountriesList(searchText: sender.text!)
           }
       }
    
    func loadLanguages(){ // language list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getLanguages(success: { (responce) in
            print(responce)
            FFLoaderView.hideInView(view: self.view)
            self.langList = responce
            for i in 0...self.langList.count - 1{
                
                if self.deviceLangauge == self.langList[i].code{
                    self.languageTextField.text = "\(self.langList[i].name ?? "")"
                    self.selectedLangCode = "\(self.langList[i].code ?? "")"
                    self.languageId = "\(self.langList[i].id ?? 0)"
                    self.loadCountriesByLanguages()
                    
                }
            }
            self.customiseDropDown()
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    
    func loadCountriesByLanguages(){ // language list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getCountryByLanguages(languageId: self.languageId , success: { (responce) in
            print(responce)
            self.countryList = responce
            FFLoaderView.hideInView(view: self.view)
            self.countryCollectionView.reloadData()
            
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            print(error)
        }
        
    }
    
    func addCountryLanguages(){ // add country and language  webservice
        if let user = FFBaseClass.sharedInstance.getUser() {
            if let userid = user.id {
                FFLoaderView.showInView(view: self.view)
                FFManagerClass.addCountryLanguages(userId: "\(userid)",countryId: selectedCountry,languageId: languageId , success: { (responce) in
                    print(responce)
                    FFLoaderView.hideInView(view: self.view)
                    
                    
                    let language = self.selectedLangCode
                             UserDefault.standard.setSelectedLanguage(language: self.selectedLangCode ?? "")

                             if language == "fr"{
                                 self.callChangeLanguageService(.french)
                             }else if language == "en"{
                                 self.callChangeLanguageService(.english)
                             }else if language == "it"{
                                 self.callChangeLanguageService(.italian)
                             }else if language == "de"{
                                 self.callChangeLanguageService(.german)
                             }else if language == "es"{
                                 self.callChangeLanguageService(.spanish)
                             }
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
//                    self.navigationController?.pushViewController(vc, animated: true)

                }) { (error) in
                    FFLoaderView.hideInView(view: self.view)
                    FFBaseClass.sharedInstance.showError(error: error, view: self)
                    print(error)
                }
            }
        }
    
        
    }
    
    func callChangeLanguageService(_ lang: Localization){

          Localization.language = lang
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! FFTabViewController
            self.navigationController?.pushViewController(vc, animated: true)

          }

    //MARK: - Collectionview methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath)
//        cell.backgroundColor = UIColor.red
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        

        let cellSize = collectionView.bounds.size.width / 3
        let tenth = (10 * cellSize)/100

        let backView = UIView()
        backView.frame = CGRect(x: 0, y: 0, width: cellSize - tenth, height: cellSize - tenth)
        backView.layer.cornerRadius = 8
        backView.layer.borderWidth = 0.5
        backView.layer.borderColor = UIColor.lightGray.cgColor
        let backViewWitdh = backView.frame.width

        let imageHeight = (35 * cellSize)/100
        let imageWidth = (80 * backViewWitdh)/100
        let interestImage = UIImageView()
        interestImage.frame = CGRect(x: (backViewWitdh - imageWidth)/2, y: (backViewWitdh - imageWidth)/2, width: imageWidth, height: imageHeight)
        interestImage.layer.cornerRadius = 8
        if let imageList = self.countryList[indexPath.row].flag {
                   let imageUrl:URL = URL(string: imageList)!
            interestImage.kf.setImage(with: imageUrl)
               }
        let label = UILabel()
        label.frame = CGRect(x: (backViewWitdh - imageWidth)/2, y: interestImage.frame.height + (backViewWitdh - imageWidth)/2 , width: imageWidth, height: 50)
        if let name = self.countryList[indexPath.row].name{
            label.text = name
        }
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 3
//
        if selectedCountry == "\(self.countryList[indexPath.row].countryid ?? 0)" {
            backView.layer.borderColor = UIColor.primary.cgColor
            label.textColor = UIColor.primary
        }else {

        }
//        cell.addSubview(label)
        backView.addSubview(interestImage)
        backView.addSubview(label)

        cell.addSubview(backView)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCountry = "\(self.countryList[indexPath.row].countryid ?? 0)"
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.bounds.size.width / 3
        let tenth = (10 * cellSize)/100
        return CGSize(width: cellSize - tenth, height: cellSize - tenth)
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
//            footerView.confirmButton.setTitle("\(StringConstants.userPreference.Everythingsuitsme)", for: .normal)

            footerView.confirmButton.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)

          return footerView
        default:
          // 4
            fatalError("Unexpected element kind")
        }
    }
    
    
    @objc func confirmButton(_ sender: UIButton){
        addCountryLanguages()
    }
    
    @IBAction func languageButton(_ sender: UIButton){
        dropDown.show()
    }

}
