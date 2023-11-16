//
//  FFReviewListViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/25/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFReviewListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var reviewTableView:UITableView!
    var reviewList:[FFReviewObject] = []
    var recipeId:Int?
    var totalCount:String?
    @IBOutlet weak var reviewCountlabel:UILabel!
    var storeId:Int?
    var restaurantId:Int?

    var fromWere: String?
    var  reviewTitle: String?
    @IBOutlet weak var seeMoreButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        if fromWere == "store"{
            loadStoreReviews()
            self.title = reviewTitle
            
        }else if fromWere == "restaurant"{
            loadRestaurantReviews()
            self.title = reviewTitle

        }else{
            self.title = "Recipe"

            loadReviews()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TableView functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! FFReviewTableViewCell
        cell.reviewObject = reviewList[indexPath.row]
        cell.refreshCell()
        return cell
    }
    
    func loadReviews(){ // review list fetch webservice
        if let recipID = recipeId {
            let stringId = "\(recipID)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getRecipeReviewList(recipeId: stringId, maxResults: self.totalCount, success: { (response:FFBaseResponseModel) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.reviewList = response.reviewList ?? []
                self.reviewTableView.reloadData()
                if let reviewCount = self.totalCount {
                    if reviewCount == "1"{
                        self.reviewCountlabel.text = "\(reviewCount) \(StringConstants.Labels.reviewonthisrecipe)"

                    }else{
                        self.reviewCountlabel.text = "\(reviewCount) \(StringConstants.Labels.reviewsonthisrecipe)"
                    }
                }
                self.reviewTableView.layoutIfNeeded()
                
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                
            }
            
        }
        
        
        
    }
    
    func loadStoreReviews(){ // review list fetch webservice
        if let storeId = storeId {
            let stringId = "\(storeId)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getStoreReviewList(storeId: stringId, maxResults: self.totalCount, success: { (response:FFBaseResponseModel) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.reviewList = response.reviewList ?? []
                self.reviewTableView.reloadData()
                self.totalCount = "\(response.totalCountInt ?? 0)"
                if response.totalCountInt ?? 0 < 11{
                    self.seeMoreButton.isHidden = true
                }
                if let reviewCount = self.totalCount {
                  self.reviewCountlabel.text = "\(reviewCount) reviews on this store"
                }
                self.reviewTableView.layoutIfNeeded()
                
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                
            }
            
        }
        
        
        
    }
    
    func loadRestaurantReviews(){ // review list fetch webservice
        if let restaurantId = restaurantId {
            let stringId = "\(restaurantId)"
            FFLoaderView.showInView(view: self.view)
            FFManagerClass.getRestaurantReviewList(restaurantId: stringId, maxResults: self.totalCount, success: { (response:FFBaseResponseModel) in
                print(response)
                FFLoaderView.hideInView(view: self.view)
                self.reviewList = response.reviewList ?? []
                self.reviewTableView.reloadData()
                
                self.totalCount = "\(response.totalCountInt ?? 0)"
                if response.totalCountInt ?? 0 < 11{
                    self.seeMoreButton.isHidden = true
                }
                if let reviewCount = self.totalCount {
                    
                  self.reviewCountlabel.text = "\(reviewCount) reviews on this restaurant"
                }
                self.reviewTableView.layoutIfNeeded()
                
            }) { (error) in
                print(error)
                FFLoaderView.hideInView(view: self.view)
                FFBaseClass.sharedInstance.showError(error: error, view: self)
                
            }
            
        }
        
        
        
    }

    
    @IBAction func seeMoreTapped(_ sender: UIButton){
        var currentCount = Int(totalCount ?? "")
        currentCount = (currentCount ?? 0) + 10
        totalCount = "\(currentCount ?? 0)"
        if fromWere == "store"{
                loadStoreReviews()
                self.title = reviewTitle
                
            }else if fromWere == "restaurant"{
                loadRestaurantReviews()
                self.title = reviewTitle

            }else{
                self.title = "Recipe"

                loadReviews()
            }
    }

}
