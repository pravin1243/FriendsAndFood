//
//  FFHomeRecipeViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 07/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFHomeRecipeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var recipeTableView:UITableView!

    var recipeArray : [FFEntranceObject] = []
    var recipeArraySliced : ArraySlice<FFEntranceObject> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        recipeTableView.delegate  = self
//        recipeTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    

   override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
          loadrecipes()
    self.navigationItem.rightBarButtonItems = [ ]
       }
    
    
    
       
       func loadrecipes(){ // desserts webservice
           FFLoaderView.showInView(view: self.view)
           FFManagerClass.loadEntranceList(withTypeId: "", success: { response in
               self.recipeArray = response
            self.recipeArraySliced = self.recipeArray.prefix(3)
               FFLoaderView.hideInView(view: self.view)
               DispatchQueue.main.async {
                self.recipeTableView.reloadData()

               }
               
           }) { (error) in
               print(error)
               FFLoaderView.hideInView(view: self.view)
           }
       }
       
       
       
       
       func numberOfSections(in tableView: UITableView) -> Int {
           if self.recipeArraySliced.count > 0 {
               recipeTableView.backgroundView = nil
               return 1
               
           }else {
               let emptyView = UIView()
               let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.recipeTableView.bounds.size.width, height: self.recipeTableView.bounds.size.width))
               emptyLabel.text = "\(StringConstants.Labels.Norecipesfound)"
               emptyLabel.font = UIFont.systemFont(ofSize: 15)
               emptyLabel.textAlignment = .center
               emptyLabel.textColor = UIColor.lightGray
               emptyView.addSubview(emptyLabel)
               
               let imagView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
               imagView.image = #imageLiteral(resourceName: "emptyRecipe")
            imagView.contentMode = UIView.ContentMode.scaleAspectFit
               imagView.center  = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 40)
               emptyView.addSubview(imagView)
               
               self.recipeTableView.backgroundView = emptyView
               return 0
           }
       }
       
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return self.recipeArraySliced.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipeCell") as! FFCategoryDetailTableViewCell
               cell.responseObject = self.recipeArraySliced[indexPath.row]
               cell.refreshCell()
               return cell
           }
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
           }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailVC") as! FFRecipeDetailViewController
           vc.recipeId = recipeArray[indexPath.row].id
           self.navigationController?.pushViewController(vc, animated: true)

       }
    
    @IBAction func seeMoreTapped(_ sender: UIButton){
//        let atTheMomentVC = self.storyboard?.instantiateViewController(withIdentifier: "AtTheMomentVC") as! FFAtTheMomentListViewController
//        self.navigationController?.pushViewController(atTheMomentVC, animated: true)
        let entranceVC = self.storyboard?.instantiateViewController(withIdentifier: "entranceVC") as! FFEntranceListViewController
        entranceVC.isEatWell = false
        entranceVC.fromNonProfessionalHome = 1

        self.navigationController?.pushViewController(entranceVC, animated: true)

    }
           
}
