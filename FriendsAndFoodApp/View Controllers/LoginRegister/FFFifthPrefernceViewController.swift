//
//  FFFifthPrefernceViewController.swift
//  FriendsAndFoodApp
//
//  Created by Iskpro Inc. on 12/3/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import TagListView
import DropDown

class FFFifthPrefernceViewController: UIViewController, TagListViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var headLabel:UILabel!
    @IBOutlet weak var subheadLabel:UILabel!
    @IBOutlet weak var skipButton:UIButton!
    @IBOutlet weak var tagListView:TagListView!

    @IBOutlet weak var searchTextField:UITextField!
    let dropDown = DropDown()
    var searchResultIngredietsArray : [FFRecipeTypeObject] = []
    var selectedIngredietsArray:[FFIngredientUploadObject] = []
    var selectedIngredient:FFIngredientUploadObject?
    var ingredientIDs:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        headLabel.text = "\(StringConstants.userPreference.IngredientsthatIdontreallylike)"
        subheadLabel.text = "\(StringConstants.userPreference.Byaddingwhatyoudonlike)"
        skipButton.setTitle("\(StringConstants.userPreference.Everythingsuitsme)", for: .normal)
        tagListView.delegate = self
        searchTextField.delegate = self
        customiseDropDown()

        // Do any additional setup after loading the view.
    }
    
    func callLikeIngredientAPI(){ // like ingredient webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.likeIngredient(isMultiple: true, ingredientIDs: ingredientIDs,recipeID: "1", success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSixthPrefernceVC") as! FFFSixthPrefernceViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    @IBAction func skipAction(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFSixthPrefernceVC") as! FFFSixthPrefernceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextButton(_ sender: UIButton){
        
        callLikeIngredientAPI()
    }

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        self.ingredientIDs.append("\(self.searchResultIngredietsArray[sender.tag].id ?? 0)")

    }
    
    
    func callSearchIngredientAPI(searchText:String){ // search ingredient webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.searchIngredientList(searchText: searchText, success: { (response) in
            print(response)
            self.dropDown.hide()
            self.searchResultIngredietsArray = response
            self.dropDown.dataSource = self.searchResultIngredietsArray.map { $0.name! }
            self.dropDown.reloadAllComponents()
            self.dropDown.show()
            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
        }
        
    }
    
    func customiseDropDown(){ // ingredient  customisation
        dropDown.anchorView = searchTextField
        dropDown.arrowIndicationX = 0
        dropDown.dataSource = searchResultIngredietsArray.map { $0.name! }
        dropDown.selectionAction = { (index: Int, item: String) in
//            self.selectedIngredient = self.getIngredientRequest(ingredient: self.searchResultIngredietsArray[index])
            
            self.searchTextField.text = ""
            self.searchTextField.resignFirstResponder()
            self.dropDown.hide()
            self.tagListView.addTag("\(item)")
            self.ingredientIDs.append("\(self.searchResultIngredietsArray[index].id ?? 0)")
        }
    }
    
    
    @IBAction func didChangeTextField(_ sender: UITextField){ // call ingredient auto suggetsion webservice afer 3 characters
        dropDown.hide()
        if (sender.text?.count)! >= 3 {
            callSearchIngredientAPI(searchText: sender.text!)
        }
        
    }
}
