//
//  FFThematicViewController.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/9/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class FFThematicViewController: UIViewController , SwipeMenuViewDataSource, SwipeMenuViewDelegate{

    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
//        options.tabView.underlineView.backgroundColor = UIColor.primary
        options.tabView.style = .segmented

        swipeMenuView.reloadData(options: options)
        
        navigationController?.navigationBar.tintColor = UIColor.white
        self.title = StringConstants.bottomTab.Thematic
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        swipeMenuView.reloadData(options: options)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 2
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String { // set title for swipe menu tabs
        
        if index == 0 {
            return "\(StringConstants.thematic.DishesType)".uppercased()
        }else {
            return "\(StringConstants.thematic.IngredientsFamily)".uppercased()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController { // set view controller for eachh tab
      
        let dishesVC = self.storyboard?.instantiateViewController(withIdentifier: "thematicDishesVC") as! FFThematicDishesTypeViewController
        let ingredientsVC = self.storyboard?.instantiateViewController(withIdentifier: "ThematicIngredientsVC") as! FFThematicIngredientsViewController
        
        if index == 0 {
            addChild(dishesVC)
            return dishesVC
        }else {
            addChild(ingredientsVC)
            return ingredientsVC
        }
    }
    

}
