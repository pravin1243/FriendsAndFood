//
//  FFThematicIngredientsViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFThematicIngredientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ingredeintList :[FFRecipeTypeObject] = []
    @IBOutlet weak var ingredientsTableVeiw:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableVeiw.dataSource  = self
        ingredientsTableVeiw.delegate = self
        ingredientsTableVeiw.estimatedRowHeight = 200
        
        getIngredients()
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: self, action: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    func getIngredients(){ // ingredients webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getIngredientsList(success: { (response) in
            print(response)
            self.ingredeintList = response
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
//                self.tableVeiw.reloadData()
                self.ingredientsTableVeiw.reloadData()
                self.ingredientsTableVeiw.layoutIfNeeded()
                
            }
        }) { (error) in
            FFLoaderView.hideInView(view: self.view)
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
        
    }
    
    //MARK:- TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredeintList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DishCell",  for:indexPath) as! FFDishTableViewCell

        let interest = self.ingredeintList[indexPath.row]
        cell.interest = interest
        cell.refreshCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThematicIngredients2VC") as! FFThematicIngredientsInnerViewController
        vc.ingredientID = "\(self.ingredeintList[indexPath.row].id ?? 0)"
        vc.ingredientName = self.ingredeintList[indexPath.row].name
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
