//
//  FFThematicIngredientsInnerViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/11/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFThematicIngredientsInnerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ingredientID:String?
    var ingredientName:String?
    
    @IBOutlet weak var ingredientTableView:UITableView!
    var list:[FFRecipeTypeObject] = []
    
    var prelist:[FFRecipeTypeObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTableView.dataSource = self
        ingredientTableView.delegate = self
        ingredientTableView.tableFooterView = UIView()
        self.navigationItem.title = ingredientName
        
        if let userr = FFBaseClass.sharedInstance.getUser() {
                         self.callIngreidntAPI(user: userr)
                   }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callIngreidntAPI(user: FFUserObject){ // ingredients list webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getIngredientsInnerList(userID: user.id, familyId: self.ingredientID, success: { (response) in
            print(response)
            self.prelist = response
            for i in 0...self.prelist.count - 1 {
                if self.prelist[i].isLike == 1{
                    self.list.append(self.prelist[i])
                }
            }
            for i in 0...self.prelist.count - 1 {
                if self.prelist[i].isLike == 0{
                    self.list.append(self.prelist[i])
                }
            }

            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                self.ingredientTableView.reloadData()
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    //MARK:- TableView functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell")
        let imageView = cell?.viewWithTag(100) as! UIImageView
        let namelabel = cell?.viewWithTag(200) as! UILabel
        let favBtn = cell?.viewWithTag(300) as! UIButton

        let interest = self.list[indexPath.row]
        //        cell.interest = interest
//                cell.refreshCell()
        namelabel.text = interest.name?.capitalizingFirstLetter()
        
            if let imageUrl:URL = URL(string: (interest.small ?? "")){
            imageView.kf.setImage(with: imageUrl.standardizedFileURL)
            }
        

//        let imageUrl:URL = URL(string: (interest.image ?? ""))!
//        imageView.kf.setImage(with:imageUrl )
        if interest.isLike == 0{
            favBtn.isHidden = true
        }else{
            favBtn.isHidden = false
        }
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "IngredientDetailVC") as! FFIngredientDetailController
        if let id = self.list[indexPath.row].id {
            vc.categoryId =  "\(id)"
        }
        vc.isFromIngredient = true
//        vc.categoryName = self.list[indexPath.row].name
//        vc.categoryImage = self.list[indexPath.row].familyImage?.first?.name
        self.navigationController?.pushViewController(vc, animated: true)
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
