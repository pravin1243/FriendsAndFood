//
//  FFThematicDishesTypeViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFThematicDishesTypeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var dishTableView:UITableView!
    
    var dishList:[FFRecipeTypeObject] = []
    var universeList:[FFUniverseObject] = []
    @IBOutlet weak var firstUniverseButton:UIButton!
    @IBOutlet weak var secondUniverseButton:UIButton!
    @IBOutlet weak var thirdUniverseButton:UIButton!
    @IBOutlet weak var fourthUniverseButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        dishTableView.isHidden = true
        dishTableView.dataSource = self
        dishTableView.delegate = self
        dishTableView.tableFooterView = UIView()

        DispatchQueue.main.async {
            self.getUniverse()
            self.getDishes(universeId: "")

        }
        
        self.firstUniverseButton.layer.borderColor = UIColor.primary.cgColor
        self.firstUniverseButton.layer.borderWidth = 1.0
        self.secondUniverseButton.layer.borderColor = UIColor.primary.cgColor
        self.secondUniverseButton.layer.borderWidth = 1.0
        self.thirdUniverseButton.layer.borderColor = UIColor.primary.cgColor
        self.thirdUniverseButton.layer.borderWidth = 1.0
        self.fourthUniverseButton.layer.borderColor = UIColor.primary.cgColor
        self.fourthUniverseButton.layer.borderWidth = 1.0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDishes(universeId: String?){ // dish list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getDishesList(id:universeId, success: { (response) in
            print(response)
            self.dishList = response
            FFLoaderView.hideInView(view: self.view)
            self.dishTableView.isHidden = false
            DispatchQueue.main.async {
                self.dishTableView.reloadData()
                self.dishTableView.layoutIfNeeded()
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    func getUniverse(){ // dish list webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getUniverseList(success: { (response) in
            print(response)
            self.universeList = response
            
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                self.firstUniverseButton.setTitle(self.universeList[0].universe_name, for: .normal)
                self.secondUniverseButton.setTitle(self.universeList[1].universe_name, for: .normal)
                self.thirdUniverseButton.setTitle(self.universeList[2].universe_name, for: .normal)
                self.fourthUniverseButton.setTitle(self.universeList[3].universe_name, for: .normal)
            }
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
    
    //MARK:- TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return dishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! FFDishTableViewCell

        let interest = self.dishList[indexPath.row]
        cell.interest = interest
        cell.refreshCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailVC") as! FFCategoryDetailViewController
//        vc.categoryName = self.dishList[indexPath.row].name
//        vc.categoryImage = self.dishList[indexPath.row].image
//        vc.categoryId = self.dishList[indexPath.row].stringId
        vc.categoryId = "\(self.dishList[indexPath.row].id ?? 0)"

        vc.isFromIngredient = false
        
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
    
    @IBAction func firstUniverseButtonAction(_ sender: UIButton){
        
        getDishes(universeId: "\(self.universeList[0].id ?? 0)")
        
        self.firstUniverseButton.backgroundColor = UIColor.primary
        self.firstUniverseButton.setTitleColor(UIColor.white, for: .normal)
        
        self.secondUniverseButton.backgroundColor = UIColor.white
        self.secondUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.thirdUniverseButton.backgroundColor = UIColor.white
        self.thirdUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.fourthUniverseButton.backgroundColor = UIColor.white
        self.fourthUniverseButton.setTitleColor(UIColor.primary, for: .normal)

    }
    
    @IBAction func secondUniverseButtonAction(_ sender: UIButton){
        getDishes(universeId: "\(self.universeList[1].id ?? 0)")

        self.secondUniverseButton.backgroundColor = UIColor.primary
        self.secondUniverseButton.setTitleColor(UIColor.white, for: .normal)
        
        self.firstUniverseButton.backgroundColor = UIColor.white
        self.firstUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.thirdUniverseButton.backgroundColor = UIColor.white
        self.thirdUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.fourthUniverseButton.backgroundColor = UIColor.white
        self.fourthUniverseButton.setTitleColor(UIColor.primary, for: .normal)

    }
    
    @IBAction func thirdUniverseButtonAction(_ sender: UIButton){
        getDishes(universeId: "\(self.universeList[2].id ?? 0)")

        self.thirdUniverseButton.backgroundColor = UIColor.primary
        self.thirdUniverseButton.setTitleColor(UIColor.white, for: .normal)
        
        self.firstUniverseButton.backgroundColor = UIColor.white
        self.firstUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.secondUniverseButton.backgroundColor = UIColor.white
        self.secondUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.fourthUniverseButton.backgroundColor = UIColor.white
        self.fourthUniverseButton.setTitleColor(UIColor.primary, for: .normal)

    }
    
    @IBAction func fourthUniverseButtonAction(_ sender: UIButton){
        getDishes(universeId: "\(self.universeList[3].id ?? 0)")

        self.fourthUniverseButton.backgroundColor = UIColor.primary
        self.fourthUniverseButton.setTitleColor(UIColor.white, for: .normal)
        
        self.firstUniverseButton.backgroundColor = UIColor.white
        self.firstUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.secondUniverseButton.backgroundColor = UIColor.white
        self.secondUniverseButton.setTitleColor(UIColor.primary, for: .normal)
        self.thirdUniverseButton.backgroundColor = UIColor.white
        self.thirdUniverseButton.setTitleColor(UIColor.primary, for: .normal)

    }

}
