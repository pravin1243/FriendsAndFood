//
//  FFEatWellListViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/8/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFEatWellListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var interestList:[FFRecipeTypeObject] = []
    @IBOutlet weak var tableView:UITableView!
    let cellSpacingHeight: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringConstants.bottomTab.EatWell
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInterests(){ // eat well list webservice
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getInterestList(success: { (response) in
            print(response)
            self.interestList = response
            FFLoaderView.hideInView(view: self.view)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
            FFLoaderView.hideInView(view: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInterests()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK:- TableView Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return 1
        }else{
            return interestList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
            let namelabel = cell?.viewWithTag(200) as! UILabel
            namelabel.text = "\(interestList.count) recettes disponibles, ajoutez les vôtres !"

            returnCell = cell!
        }
        if indexPath.section == 1{

        let cell  = tableView.dequeueReusableCell(withIdentifier: "EatWellCell")

        let imageView = cell?.viewWithTag(100) as! UIImageView
        let namelabel = cell?.viewWithTag(200) as! UILabel
        let interest = self.interestList[indexPath.row]
//        cell.interest = interest
//        cell.refreshCell()
        namelabel.text = interest.name
        let imageUrl:URL = URL(string: interest.imageSmall!)!
        imageView.kf.setImage(with:imageUrl )
            returnCell = cell!

        }
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 230.0
        }else{
//        return UITableViewAutomaticDimension
            return 100.0

        }
    }
    
    // Set the spacing between sections
//       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1{
//           return cellSpacingHeight
//        }else{
//            return 0
//        }
//       }
//
//       // Make the background color show through
//       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1{
//
//           let headerView = UIView()
//           headerView.backgroundColor = UIColor.clear
//           return headerView
//        }else{
//            return nil
//        }
//       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "EatWellDetailVC") as! FFEatWellRecipeViewController
//        vc.isEatWell = true
        vc.interestId = String(interestList[indexPath.row].id ?? 0)
        vc.recipeName = interestList[indexPath.row].name
        vc.isFromSideMenu = false
        vc.isFav = interestList[indexPath.row].checked == 0 ? false : true
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
