//
//  FFDeclareOwnerRestaurantViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 01/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown

class FFDeclareOwnerRestaurantViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UITextFieldDelegate {
    
    var allDayDisplay: String?
    var morningDisplay: String?
    var eveningDisplay: String?
    
    var allDayFromDisplay: String?
    var morningFromDisplay: String?
    var eveningFromDisplay: String?

    var allDayToDisplay: String?
    var morningToDisplay: String?
    var eveningToDisplay: String?

    var isClosed:Int? = -1
    var isAllDay: Bool? = false

    var storeID:Int?
    var isStore: Int?
    @IBOutlet weak var screenTitle:UILabel!

    @IBOutlet weak var functionHeadHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var functionHeightConstraint:NSLayoutConstraint!


    @IBOutlet weak var kitchenTypeHeadHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var kitchenTypeHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var priceHeadHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var priceHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var dietHeadHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var dietCollectionView:UICollectionView!
    @IBOutlet weak var dietCollectionViewHeightConstraint:NSLayoutConstraint!
    let dropDown = DropDown()
    @IBOutlet weak var daysCollectionView:UICollectionView!
    @IBOutlet weak var daysHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var shiftCollectionView:UICollectionView!
    @IBOutlet weak var shiftHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var fromTimeCollectionView:UICollectionView!
    @IBOutlet weak var fromHeightCollectionConstraint:NSLayoutConstraint!
    @IBOutlet weak var fromHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var fromLabelHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var selectTimeLabelHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var toTimeCollectionView:UICollectionView!
    @IBOutlet weak var toHeightCollectionConstraint:NSLayoutConstraint!
    @IBOutlet weak var toHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var toLabelHeightConstraint:NSLayoutConstraint!

    @IBOutlet weak var functionTextField:UITextField!
    @IBOutlet weak var phoneTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var websitetTextField:UITextField!
    @IBOutlet weak var facebookTextField:UITextField!
    @IBOutlet weak var specialityTextField:UITextField!
    @IBOutlet weak var priceRangeTextField:UITextField!

    var specilaityList:[FFPlaceObject] = []
    var selectedSpeciality:FFPlaceObject?

    var allInterestList:[FFAllInterestObject] = []
    var currentTextField:UITextField?

    var dietArray = [String]()
    var daysArray = [String]()
    var shiftArray = [String]()
    var lunchfromArray = [String]()
    var allDayArray = [String]()
    var dinnerfromArray = [String]()
    var dinnertoArray = [String]()

    var selectedSpecilaity:FFPlaceObject?
    var dietString:String?

    var functionList:[FFPlaceObject] = []
    var selectedFunction:FFPlaceObject?
    var selectedDay: Int? = 0
    var selectedShift: Int? = -1
    var selectedFrom: Int? = -1
    var selectedTo: Int? = -1
    var isChecked:Bool? = true
    @IBOutlet weak var openBtn:UIButton!
    @IBOutlet weak var closeBtn:UIButton!

    @IBOutlet weak var openLBl:UILabel!
    @IBOutlet weak var closeLBl:UILabel!

    @IBOutlet weak var fromView:UIView!
    @IBOutlet weak var toView:UIView!
    var fromHeigt: CGFloat?
    var toHeigt: CGFloat?

    @IBOutlet weak var fromStackView:UIView!

    @IBOutlet weak var toStackView:UIView!

    let collectionViewHeaderFooterReuseIdentifier = "MyHeaderFooterClass"

    @IBOutlet weak var storeOpenLabel:UILabel!
    var daysOpenHour:[FFDisplayHourModel]? = [FFDisplayHourModel]()

    var lunchFromHourArray:[fromToTime]? = [fromToTime]()
    var dinnerFromHourArray:[fromToTime]? = [fromToTime]()
    var alldayFromHourArray:[fromToTime]? = [fromToTime]()

    var lunchToHourArray:[fromToTime]? = [fromToTime]()
    var dinnerToHourArray:[fromToTime]? = [fromToTime]()
    var alldayToHourArray:[fromToTime]? = [fromToTime]()

    var restaurantID:Int?

    
    var timeObject:fromToTime?
    var timeArray:[fromToTime]? = [fromToTime]()
    var restaurantdetail:[FFRestaurantObject]?
    var storeRequest = FFSuggestStorePostModel()
    var storedetail:FFStoreObject?
    var restaurantRequest = FFAddRestaurantRequestModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        if isStore == 1{
            kitchenTypeHeadHeightConstraint.constant = 0
            kitchenTypeHeightConstraint.constant = 0
            priceHeadHeightConstraint.constant = 0
            priceHeightConstraint.constant = 0
            dietCollectionViewHeightConstraint.constant = 0
            dietHeadHeightConstraint.constant = 0
            screenTitle.text = "Declare Store Owner"
        }else{
            
            getFunctionList()
            getSpecialities()
            getAllInterests()

        }
        

        dietCollectionView.dataSource  = self
        dietCollectionView.delegate = self
        daysCollectionView.dataSource  = self
        daysCollectionView.delegate = self
        shiftCollectionView.dataSource  = self
        shiftCollectionView.delegate = self
        fromTimeCollectionView.dataSource  = self
        fromTimeCollectionView.delegate = self
        toTimeCollectionView.dataSource  = self
        toTimeCollectionView.delegate = self

        functionTextField.delegate = self
        priceRangeTextField.delegate = self
        specialityTextField.delegate = self

        
        
        shiftArray = ["All Day","Lunch", "Dinner"]
        lunchfromArray = ["6.00", "6.30", "7.00", "7.30", "8.00", "8.30","9.00", "9.30", "10.00", "10.30", "11.00", "11.30","12.00", "12.30","13.00", "13.30","14.00", "14.30"]
        allDayArray = ["6.00", "6.30", "7.00", "7.30", "8.00", "8.30","9.00", "9.30", "10.00", "10.30", "11.00", "11.30","12.00", "12.30","13.00", "13.30","14.00"]
        dinnerfromArray = ["14.00", "14.30", "15.00", "15.30", "16.00", "16.30","17.00", "17.30", "18.00", "18.30", "19.00", "19.30","20.00", "20.30","21.00", "21.30","22.00", "22.30","23.00", "23.30","23.59"]
        dinnertoArray = ["14.00", "14.30", "15.00", "15.30", "16.00", "16.30","17.00", "17.30", "18.00", "18.30", "19.00", "19.30","20.00", "20.30","21.00", "21.30","22.00", "22.30","23.00", "23.30","23.59"]
        
        for i in 0...lunchfromArray.count - 1{
            lunchFromHourArray?.append(fromToTime(fromTime: lunchfromArray[i], toTime: "", isChecked: 0))
            lunchToHourArray?.append(fromToTime(fromTime: "", toTime: lunchfromArray[i], isChecked: 0))

        }
        for i in 0...dinnerfromArray.count - 1{
            dinnerFromHourArray?.append(fromToTime(fromTime: dinnerfromArray[i], toTime: "", isChecked: 0))
            dinnerToHourArray?.append(fromToTime(fromTime: "", toTime: dinnerfromArray[i], isChecked: 0))

        }
        for i in 0...allDayArray.count - 1{
           alldayFromHourArray?.append(fromToTime(fromTime: allDayArray[i], toTime: "", isChecked: 0))
           alldayToHourArray?.append(fromToTime(fromTime: "", toTime: allDayArray[i], isChecked: 0))

       }

        
        daysArray = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        for i in 0...daysArray.count - 1{
            
             daysOpenHour?.append(FFDisplayHourModel(day: daysArray[i], lunchFrom: lunchFromHourArray, lunchTo: lunchToHourArray,allDayFrom:alldayFromHourArray,allDayTo:alldayToHourArray  ,dinnerFrom: dinnerFromHourArray, dinnerTo: dinnerToHourArray, isChecked: 0, selectedFrom: 0, selectedTo: 0, isOpen: 0))
        }
        
        
        self.daysCollectionView.reloadData()
        self.daysCollectionView.layoutIfNeeded()
        self.daysHeightConstraint.constant = self.daysCollectionView.contentSize.height
        
        
    }
    
    func populateRestData(){
        
    }
    
    func populateStoreData(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fromHeigt = fromHeightConstraint.constant
        toHeigt = toHeightConstraint.constant

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func getFunctionList(){ // country list webservice
        
        FFManagerClass.getFunctionList(type: "function", success: { (response) in
            self.functionList = response
            
        }) { (error) in
            
        }
    }
    
    func getSpecialities(){ // speciality list webservice
           
           FFManagerClass.getFunctionList(type: "special", success: { (response) in
               self.specilaityList = response
               self.customiseDropDown()
               
           }) { (error) in
               
           }
       }
       
       func getAllInterests(){ // interest list webservice
             
             FFManagerClass.getAllInterestList(success: { (response) in
                 self.allInterestList = response
                 
               self.dietCollectionView.reloadData()
               self.dietCollectionView.layoutIfNeeded()
               self.dietCollectionViewHeightConstraint.constant = self.dietCollectionView.contentSize.height

             }) { (error) in
                 
             }
         }

    
    func textFieldDidBeginEditing(_ textField: UITextField) { // show dropdwon list on textfiled selection
           currentTextField = textField
           self.dropDown.hide()
           
           self.dropDown.anchorView = currentTextField
           if textField == specialityTextField {
               self.dropDown.dataSource = self.specilaityList.map { $0.name! }
               self.dropDown.reloadAllComponents()
               self.dropDown.show()
           }else if textField == priceRangeTextField {
               self.dropDown.dataSource = ["Not Expensive (€)","Affordable (€€)","Expensive (€€€)"]
               self.dropDown.reloadAllComponents()
               self.dropDown.show()
           }else if textField == functionTextField {
               self.dropDown.dataSource = self.functionList.map { $0.name! }
               self.dropDown.reloadAllComponents()
               self.dropDown.show()
           }

        
       }
       
       func customiseDropDown(){ // populate dropdown with country and cuty  and regionlist
              
              if currentTextField == specialityTextField {
                  dropDown.anchorView = specialityTextField
                  dropDown.dataSource = self.specilaityList.map { $0.name! }
              }else if currentTextField == priceRangeTextField {
                  dropDown.anchorView = priceRangeTextField
                  dropDown.dataSource = ["Not Expensive (€)","Affordable (€€)","Expensive (€€€)"]
              }else if currentTextField == functionTextField {
                  dropDown.anchorView = functionTextField
                  dropDown.dataSource = self.functionList.map { $0.name! }
              }
              
              dropDown.direction = .any
           
           dropDown.selectionAction = { (index: Int, item: String) in
               self.currentTextField?.text = item
               self.dropDown.hide()
               
               if self.currentTextField == self.specialityTextField {
                   self.selectedSpecilaity = self.specilaityList[index]
                   
               }else if self.currentTextField == self.priceRangeTextField {
                   
               }else if self.currentTextField == self.functionTextField {
                   self.selectedFunction = self.functionList[index]
                   self.functionTextField.resignFirstResponder()

               }
               self.specialityTextField.resignFirstResponder()
               self.priceRangeTextField.resignFirstResponder()
           }
          }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == dietCollectionView{
            return allInterestList.count
            }else if collectionView == daysCollectionView{
                return daysOpenHour?.count ?? 0
            }else if collectionView == shiftCollectionView{
            return shiftArray.count
            }else if collectionView == fromTimeCollectionView{
                if selectedShift == 0{
                    return daysOpenHour?[selectedDay ?? 0].allDayFrom?.count ?? 0
                }else if selectedShift == 1{
                    return daysOpenHour?[selectedDay ?? 0].lunchFrom?.count ?? 0
                }
                else{
                    return daysOpenHour?[selectedDay ?? 0].dinnerFrom?.count ?? 0

                }
            }else if collectionView == toTimeCollectionView{
                if selectedShift == 0{
            return daysOpenHour?[selectedDay ?? 0].allDayTo?.count ?? 0
                }else if selectedShift == 1{
                    return daysOpenHour?[selectedDay ?? 0].lunchTo?.count ?? 0
                }
                else{
                    return daysOpenHour?[selectedDay ?? 0].dinnerTo?.count ?? 0
                }
            }else{
                return 0
        }
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectCell: UICollectionViewCell = UICollectionViewCell()
        if collectionView == dietCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCell", for: indexPath)
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.allInterestList[indexPath.row].name!) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            let tickImgView = cell.viewWithTag(200) as! UIImageView
            if self.allInterestList[indexPath.row].isChecked == 1 {
                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
            }else {
                tickImgView.image = #imageLiteral(resourceName: "tickgrey")
            }
            collectCell = cell
        }else if collectionView == daysCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCell", for: indexPath)
            
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(daysOpenHour?[indexPath.row].day ?? "") "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            //            let tickImgView = cell.viewWithTag(200) as! UIImageView
            //            if self.allInterestList[indexPath.row].isChecked == 1 {
            //                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
            //            }else {
            //                tickImgView.image = #imageLiteral(resourceName: "tickgrey")
            //            }
            
            if selectedDay == indexPath.row{
                label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                label.textColor = UIColor.white
            }else{
                label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                label.textColor = UIColor.black
            }
            collectCell = cell
            
        }else if collectionView == shiftCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShiftCell", for: indexPath)
            
            let label = cell.viewWithTag(100) as! UILabel
            label.text = " \(self.shiftArray[indexPath.row]) "
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            //            let tickImgView = cell.viewWithTag(200) as! UIImageView
            //            if self.allInterestList[indexPath.row].isChecked == 1 {
            //                tickImgView.image = #imageLiteral(resourceName: "tickgreen")
            //            }else {
            //                tickImgView.image = #imageLiteral(resourceName: "tickgrey")
            //            }
            
            if selectedShift == indexPath.row{
                label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                label.textColor = UIColor.white
            }else{
                label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                label.textColor = UIColor.black

            }
            collectCell = cell
            
        }else if collectionView == fromTimeCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FromCell", for: indexPath)
            
            let label = cell.viewWithTag(100) as! UILabel
            label.layer.cornerRadius = 4
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            
            if selectedShift == 0{
                label.text = " \(daysOpenHour?[selectedDay ?? 0].allDayFrom?[indexPath.row].fromTime ?? "") "

                if daysOpenHour?[selectedDay ?? 0].allDayFrom?[indexPath.row].isChecked == 1{
                    label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                    label.textColor = UIColor.white
                    selectedFrom = indexPath.row
                }else{
                    label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    label.textColor = UIColor.black

                }
            }else if selectedShift == 1{
                label.text = " \(daysOpenHour?[selectedDay ?? 0].lunchFrom?[indexPath.row].fromTime ?? "") "

                if daysOpenHour?[selectedDay ?? 0].lunchFrom?[indexPath.row].isChecked == 1{
                    label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                    label.textColor = UIColor.white
                    selectedFrom = indexPath.row
                }else{
                    label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    label.textColor = UIColor.black

                }
            }
            else{
                label.text = " \(daysOpenHour?[selectedDay ?? 0].dinnerFrom?[indexPath.row].fromTime ?? "") "
                if daysOpenHour?[selectedDay ?? 0].dinnerFrom?[indexPath.row].isChecked == 1{
                                  label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                  label.textColor = UIColor.white
                    selectedFrom = indexPath.row

                              }else{
                                  label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                  label.textColor = UIColor.black

                              }
            }
            collectCell = cell
            
        }else if collectionView == toTimeCollectionView {
                    
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToCell", for: indexPath)
                   
                    let label = cell.viewWithTag(100) as! UILabel
//            label.text = " \(daysOpenHour?[indexPath.row].day) "
                    label.layer.cornerRadius = 4
                    label.layer.borderWidth = 0.5
                    label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor

            
            if selectedShift == 0{
                label.text = " \(daysOpenHour?[selectedDay ?? 0].allDayTo?[indexPath.row].toTime ?? "") "
                if daysOpenHour?[selectedDay ?? 0].allDayTo?[indexPath.row].isChecked == 1{
                                 label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                 label.textColor = UIColor.white
                             }else{
                                 label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                 label.textColor = UIColor.black

                             }
                       }else if selectedShift == 1{
                           label.text = " \(daysOpenHour?[selectedDay ?? 0].lunchTo?[indexPath.row].toTime ?? "") "

                           if daysOpenHour?[selectedDay ?? 0].lunchTo?[indexPath.row].isChecked == 1{
                               label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                               label.textColor = UIColor.white
                               selectedFrom = indexPath.row
                           }else{
                               label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                               label.textColor = UIColor.black

                           }
                       }
            else{
                label.text = " \(daysOpenHour?[selectedDay ?? 0].dinnerTo?[indexPath.row].toTime ?? "") "
                if daysOpenHour?[selectedDay ?? 0].dinnerTo?[indexPath.row].isChecked == 1{
                                                label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                                label.textColor = UIColor.white
                                            }else{
                                                label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                                label.textColor = UIColor.black

                                            }
                       }
//                        if selectedTo == indexPath.row{
//                   label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
//                   label.textColor = UIColor.white
//               }else{
//                   label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                   label.textColor = UIColor.black
//
//               }
            
                    collectCell = cell

                    }
        return collectCell
    }
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == dietCollectionView{

            let cellWidth = collectionView.bounds.width
                let cellSize = collectionView.bounds.size.width / 3

            return CGSize(width: cellSize, height: 100)
            }else if collectionView == daysCollectionView{

            let cellWidth = collectionView.bounds.width
                let cellSize = collectionView.bounds.size.width / 3

            return CGSize(width: cellSize, height: 60)
            }
            else if collectionView == shiftCollectionView{
                let cellSize = collectionView.bounds.size.width / 3
                return CGSize(width: cellSize, height: 60)

            }else if collectionView == fromTimeCollectionView{
                let cellSize = collectionView.bounds.size.width / 4
                return CGSize(width: cellSize, height: 60)

            }else if collectionView == toTimeCollectionView{
                let cellSize = collectionView.bounds.size.width / 4
                return CGSize(width: cellSize, height: 60)

            }else{
                return CGSize()
            }
        }
        
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        selectedTheme = self.interestList[indexPath.row].stringId!
                if collectionView == dietCollectionView{
                    if self.allInterestList[indexPath.row].isChecked == 1 {
                        self.allInterestList[indexPath.row].isChecked = 0
                    }else{
                        self.allInterestList[indexPath.row].isChecked = 1
                    }
                    self.dietCollectionView.reloadData()
                }else if collectionView == daysCollectionView{
                    selectedDay = indexPath.row
                    storeOpenLabel.text = "Is the store is open on \(daysArray[indexPath.row])?"
                    
                    
                daysCollectionView.reloadData()
                    shiftCollectionView.reloadData()
                        fromTimeCollectionView.reloadData()
                        toTimeCollectionView.reloadData()

                }else if collectionView == shiftCollectionView{
                    if selectedShift == 0{
                        
                    
                    if isAllDay == true{
                        presentAlertWithTitle(title: "Please Confirm", message: "Do you want to fill lunch then all day data will be lost.", options: "Yes", "No") { (option) in
                               print("option: \(option)")
                               switch(option) {
                                   case 0:
                                       print("option one")
                                       
                                       for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                                        self.daysOpenHour?[0].allDayFrom?[i].isChecked = 0
                                        self.daysOpenHour?[0].allDayTo?[i].isChecked = 0
                                       }
                                       self.selectedShift = indexPath.row
                                       self.shiftCollectionView.reloadData()
                                       self.fromTimeCollectionView.reloadData()
                                       self.toTimeCollectionView.reloadData()
                                       self.isAllDay = false
                                       break
                                   case 1:
                                       print("option two")
                                        return
                                   default:
                                       break
                               }
                           }
                        }else{
                        selectedShift = indexPath.row
                        shiftCollectionView.reloadData()
                        fromTimeCollectionView.reloadData()
                        toTimeCollectionView.reloadData()

                        
                        }
                        
                        
                    }else{
                        selectedShift = indexPath.row
                        shiftCollectionView.reloadData()
                        fromTimeCollectionView.reloadData()
                        toTimeCollectionView.reloadData()

                    }
                    
                }else if collectionView == fromTimeCollectionView{
                    
                    if selectedShift == -1{
                        FFBaseClass.sharedInstance.showAlert(mesage: "Please select All Day, Lunch or Dinner", view: self)
                    }else{
                        if selectedShift == 0{
                            isAllDay = true
                            for i in 0...(daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                                if i == indexPath.row{
                                    daysOpenHour?[0].allDayFrom?[i].isChecked = 1
                                    
                                    selectedFrom = i
                                    //daysOpenHour?[0].lunchFrom?[i].updateCheck(status: 1)
                                }else{
                                    daysOpenHour?[0].allDayFrom?[i].isChecked = 0
                                    //                                    daysOpenHour?[0].lunchFrom?[i].updateCheck(status: 0)
                                    
                                }
                            }
                            
                        }else if selectedShift == 1{

                            for i in 0...(daysOpenHour?[0].lunchFrom?.count ?? 0) - 1{
                                if i == indexPath.row{
                                    daysOpenHour?[0].lunchFrom?[i].isChecked = 1
                                    
                                    selectedFrom = i
                                    //daysOpenHour?[0].lunchFrom?[i].updateCheck(status: 1)
                                }else{
                                    daysOpenHour?[0].lunchFrom?[i].isChecked = 0
                                    //                                    daysOpenHour?[0].lunchFrom?[i].updateCheck(status: 0)
                                    
                                }
                            }
                            
                        }
                        else{
                            
                            for i in 0...(daysOpenHour?[0].dinnerFrom?.count ?? 0) - 1{
                                if i == indexPath.row{
                                    
                                    daysOpenHour?[0].dinnerFrom?[i].isChecked = 1
                                    selectedFrom = i
                                    
                                }else{
                                    daysOpenHour?[0].dinnerFrom?[i].isChecked = 0
                                    
                                }
                                
                            }
                            
                        }
                        
                        fromTimeCollectionView.reloadData()
                    }
                }else if collectionView == toTimeCollectionView{
                    if selectedShift == -1{
                        FFBaseClass.sharedInstance.showAlert(mesage: "Please select Lunch or Dinner", view: self)
                        return
                    }
                    if selectedFrom == -1{
                        FFBaseClass.sharedInstance.showAlert(mesage: "Please select from time", view: self)
                        return
                    }
                    if selectedFrom == indexPath.row{
                        FFBaseClass.sharedInstance.showAlert(mesage: "From time and to time should not be same", view: self)
                        return
                    }
                    if indexPath.row < selectedFrom ?? 0{
                                          FFBaseClass.sharedInstance.showAlert(mesage: "To time can not be less than  From time", view: self)
                                          return
                                      }
                    
                    if selectedShift == 0{
                                      
                                      for i in 0...(daysOpenHour?[selectedDay ?? 0].allDayTo?.count ?? 0) - 1{
                                          if i == indexPath.row{
                                              
                                              daysOpenHour?[selectedDay ?? 0].allDayTo?[i].isChecked = 1
                                              
                                          }else{
                                              daysOpenHour?[selectedDay ?? 0].allDayTo?[i].isChecked = 0
                                              
                                          }
                                          
                                      }
                                      
                                  }else if selectedShift == 1{
                                      
                                      for i in 0...(daysOpenHour?[selectedDay ?? 0].lunchTo?.count ?? 0) - 1{
                                          if i == indexPath.row{
                                              
                                              daysOpenHour?[selectedDay ?? 0].lunchTo?[i].isChecked = 1
                                              
                                          }else{
                                              daysOpenHour?[selectedDay ?? 0].lunchTo?[i].isChecked = 0
                                              
                                          }
                                          
                                      }
                                      
                                  }
                    else{
                                      
                                      for i in 0...(daysOpenHour?[selectedDay ?? 0].dinnerTo?.count ?? 0) - 1{
                                          if i == indexPath.row{
                                              
                                              daysOpenHour?[selectedDay ?? 0].dinnerTo?[i].isChecked = 1
                                              
                                          }else{
                                              daysOpenHour?[selectedDay ?? 0].dinnerTo?[i].isChecked = 0
                                              
                                          }
                                          
                                      }
                                      
                                  }
                toTimeCollectionView.reloadData()
                }
 
    }
    
    

    


    @IBAction func closeBtnTapped(_ sender : UIButton) { // dificulty buton selection action
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openBtnTapped(_ sender : Any){
        isClosed = 0

        openBtn.setBackgroundImage(#imageLiteral(resourceName: "checkfill"), for: .normal)
        openBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
        
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "checkempty"), for: .normal)
        closeBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
        
        isChecked = true
        
        self.fromTimeCollectionView.layoutIfNeeded()
        self.fromHeightConstraint.constant = fromHeigt ?? 0
        
        self.toTimeCollectionView.layoutIfNeeded()
        self.toHeightConstraint.constant = toHeigt ?? 0
        
        self.shiftCollectionView.layoutIfNeeded()
        self.shiftHeightConstraint.constant = toHeigt ?? 0
        fromLabelHeightConstraint.constant = 20
        toLabelHeightConstraint.constant = 20
        selectTimeLabelHeightConstraint.constant = 20
        
        
        
    }

    @IBAction func closeOpenBtnTapped(_ sender : Any){
        isClosed = 1
        if selectedDay == 0{
          if isStore == 1{
              storeRequest.displayHoursSunday = ""

          }else{
            restaurantRequest.displayHoursSunday = ""
          }
        }else if selectedDay == 1{
          if isStore == 1{
              storeRequest.displayHoursMonday = ""

          }else{
            restaurantRequest.displayHoursMonday = ""
          }
        }else if selectedDay == 2{
          if isStore == 1{
              storeRequest.displayHoursTuesday = ""

          }else{
            restaurantRequest.displayHoursTuesday = ""
          }
        }else if selectedDay == 3{
          if isStore == 1{
              storeRequest.displayHoursWednesday = ""

          }else{
            restaurantRequest.displayHoursWednesday = ""
          }
        }else if selectedDay == 4{
          if isStore == 1{
              storeRequest.displayHoursThursday = ""

          }else{
            restaurantRequest.displayHoursThursday = ""
          }
        }else if selectedDay == 5{
          if isStore == 1{
              storeRequest.displayHoursFriday = ""

          }else{
            restaurantRequest.displayHoursFriday = ""
          }
        }else if selectedDay == 0{
          if isStore == 1{
              storeRequest.displayHoursSaturday = ""

          }else{
            restaurantRequest.displayHoursSaturday = ""
          }
        }
        openBtn.setBackgroundImage(#imageLiteral(resourceName: "checkempty"), for: .normal)
        openBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
        
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "checkfill"), for: .normal)
        closeBtn.tintColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
        isChecked = true
        
        self.shiftCollectionView.layoutIfNeeded()
        self.shiftHeightConstraint.constant = 0
        
        self.toTimeCollectionView.layoutIfNeeded()
        self.toHeightConstraint.constant = 0
        self.fromTimeCollectionView.layoutIfNeeded()
        self.fromHeightConstraint.constant = 0
        fromLabelHeightConstraint.constant = 0
        toLabelHeightConstraint.constant = 0
        selectTimeLabelHeightConstraint.constant = 0
    }

    
    func validateRestaurantFields() -> Bool{ // validating fields in step 1 of add recipe
            var isValid = true
            
            if let function = functionTextField.text, !function.isEmpty {
                
                restaurantRequest.jobId = "\(selectedFunction?.idInt ?? 0)"

            }else {
                FFBaseClass.sharedInstance.showAlert(mesage: "Enter your role in this establishment", view: self)
                isValid = false
            }
        
        if let phone = phoneTextField.text, !phone.isEmpty {
                 
                 restaurantRequest.phone = phone
                 
             }else {
                 FFBaseClass.sharedInstance.showAlert(mesage: "Enter phone", view: self)
                 isValid = false
             }
             
//             if let restEmail = emailTextField.text, !restEmail.isEmpty {
//
//                 restaurantRequest?.email = restEmail
//
//             }else {
//                 FFBaseClass.sharedInstance.showAlert(mesage: "Enter restuarant email", view: self)
//                 isValid = false
//             }
        
                    if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
                        
                        if !isValidEmail(email: email ){
                            FFBaseClass.sharedInstance.showAlert(mesage: "Email is not valid", view: self)
                            
                            isValid =  false
                        }else {
        //                    restaurantRequest?.email = email
                        }
                    }else
                    {
                        FFBaseClass.sharedInstance.showAlert(mesage: "Enter Email", view: self)
                        isValid = false
                    }

             
             if let website = websitetTextField.text, !website.isEmpty {
                 
                 restaurantRequest.website = website
                 
             }else {
                 FFBaseClass.sharedInstance.showAlert(mesage: "Enter website", view: self)
                 isValid = false
             }
             
             if let facebook = facebookTextField.text, !facebook.isEmpty {
                 
                 restaurantRequest.facebook = facebook
                 
             }else {
                 FFBaseClass.sharedInstance.showAlert(mesage: "Enter facebook", view: self)
                 isValid = false
             }
        
        
        self.dietArray.removeAll()
        for i in 0...self.allInterestList.count - 1{
            if self.allInterestList[i].isChecked == 1{
                
                self.dietArray.append("\(self.allInterestList[i].id ?? 0)")
                
            }
        }
        
        if self.dietArray.count > 0{
            dietString = dietArray.joined(separator: ", ")
            restaurantRequest.interests = dietString
        }else{
            FFBaseClass.sharedInstance.showAlert(mesage: "Select alleast one interest", view: self)
            isValid = false

        }

        if let speciality = specialityTextField.text, !speciality.isEmpty {
              restaurantRequest.specialities = "\(self.selectedSpecilaity?.idInt ?? 0)"
          }else {
              FFBaseClass.sharedInstance.showAlert(mesage: "Enter Culinary Specialties", view: self)
              isValid = false
          }

          
          if let priceRange = priceRangeTextField.text, !priceRange.isEmpty {
              
              restaurantRequest.priceRange = "€"

          }else {
              FFBaseClass.sharedInstance.showAlert(mesage: "Enter price range", view: self)
              isValid = false
          }
            return isValid
        }
    
    func validateStoreFields() -> Bool{ // validating fields in step 1 of add recipe
                var isValid = true
                
        
            
            if let phone = phoneTextField.text, !phone.isEmpty {
                     
                     storeRequest.phone = phone
                 }else {
                     FFBaseClass.sharedInstance.showAlert(mesage: "Enter phone", view: self)
                     isValid = false
                 }
                 
    //             if let restEmail = emailTextField.text, !restEmail.isEmpty {
    //
    //                 restaurantRequest?.email = restEmail
    //
    //             }else {
    //                 FFBaseClass.sharedInstance.showAlert(mesage: "Enter restuarant email", view: self)
    //                 isValid = false
    //             }
            
                        if let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces), !email.isEmpty {
                            
                            if !isValidEmail(email: email ){
                                FFBaseClass.sharedInstance.showAlert(mesage: "Email is not valid", view: self)
                                
                                isValid =  false
                            }else {
            //                    restaurantRequest?.email = email
                            }
                        }else
                        {
                            FFBaseClass.sharedInstance.showAlert(mesage: "Enter Email", view: self)
                            isValid = false
                        }

                 
                 if let website = websitetTextField.text, !website.isEmpty {
                     
                     storeRequest.website = website
                     
                 }else {
                     FFBaseClass.sharedInstance.showAlert(mesage: "Enter website", view: self)
                     isValid = false
                 }
                 
                 if let facebook = facebookTextField.text, !facebook.isEmpty {
                     
                     storeRequest.facebook = facebook
                     
                 }else {
                     FFBaseClass.sharedInstance.showAlert(mesage: "Enter facebook", view: self)
                     isValid = false
                 }
            
       
                return isValid
            }
    
    func isValidEmail(email: String) -> Bool { //  checking email validity
          let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
          let predicate = NSPredicate(format: "self matches %@", emailRegex)
          return predicate.evaluate(with: email)
      }
    
    @IBAction func nextBtnTapped(_ sender : Any){
        if isStore == 1{
            if validateStoreFields(){
                getOpenHoursData()
                self.updateStoreInfo()
            }
        }else{
            getOpenHoursData()
            self.updateRestInfo()
        }
    }
    
    func getOpenHoursData(){

        if isClosed == 1{
            presentAlertWithTitle(title: "Fermer la confirmation", message: "Vous choisissez fermé pour toute la journée. Voulez-vous poursuivre?", options: "Oui", "Non") { (option) in
                   print("option: \(option)")
                   switch(option) {
                       case 0:
                           print("option one")
                           break
                       case 1:
                           print("option two")
                       default:
                           break
                   }
               }

            
        }else{
            if isAllDay == true{
                if selectedDay == 0{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursSunday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"

                    }else{
                        restaurantRequest.displayHoursSunday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"

                    }

                }else if selectedDay == 1{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursMonday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursMonday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }
                }else if selectedDay == 2{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursTuesday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursTuesday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }

                }else if selectedDay == 3{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursWednesday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursWednesday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }

                }else if selectedDay == 4{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursThursday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursThursday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }

                }else if selectedDay == 5{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursFriday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursFriday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }

                }else if selectedDay == 6{
                    for i in 0...(self.daysOpenHour?[0].allDayFrom?.count ?? 0) - 1{
                        if self.daysOpenHour?[0].allDayFrom?[i].isChecked == 1{
                            allDayFromDisplay = self.daysOpenHour?[0].allDayFrom?[i].fromTime
                        }
                        if self.daysOpenHour?[0].allDayTo?[i].isChecked == 1{
                            allDayToDisplay = self.daysOpenHour?[0].allDayTo?[i].toTime
                        }
                        
                    }
                    if isStore == 1{
                        storeRequest.displayHoursSaturday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }else{
                    restaurantRequest.displayHoursSaturday = "\(allDayFromDisplay ?? "")-\(allDayToDisplay ?? "")"
                    }
                }
                
            }else{
                
                for i in 0...(self.daysOpenHour?[0].lunchFrom?.count ?? 0) - 1{
                                       if self.daysOpenHour?[0].lunchFrom?[i].isChecked == 1{
                                           morningFromDisplay = self.daysOpenHour?[0].lunchFrom?[i].fromTime
                                       }
                                       if self.daysOpenHour?[0].lunchTo?[i].isChecked == 1{
                                           morningToDisplay = self.daysOpenHour?[0].lunchTo?[i].toTime
                                       }
                                       
                                   }
                for i in 0...(self.daysOpenHour?[0].dinnerFrom?.count ?? 0) - 1{
                                                     if self.daysOpenHour?[0].dinnerFrom?[i].isChecked == 1{
                                                         eveningFromDisplay = self.daysOpenHour?[0].dinnerFrom?[i].fromTime
                                                     }
                                                     if self.daysOpenHour?[0].dinnerTo?[i].isChecked == 1{
                                                         eveningToDisplay = self.daysOpenHour?[0].dinnerTo?[i].toTime
                                                     }
                                                     
                                                 }
                
                if selectedDay == 0{
                    if !(morningFromDisplay ?? "").isEmpty{
                        
                        if isStore == 1{
                            storeRequest.morningdisplayHoursSunday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursSunday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }

                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursSunday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursSunday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }


                }else if selectedDay == 1{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursMonday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursMonday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursMonday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursMonday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }
                }else if selectedDay == 2{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursTuesday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursTuesday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursTuesday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursTuesday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }

                }else if selectedDay == 3{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursWednesday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursWednesday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursWednesday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursWednesday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }

                }else if selectedDay == 4{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursThursday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursThursday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursThursday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursThursday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }

                }else if selectedDay == 5{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursFriday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursFriday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursFriday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursFriday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }

                }else if selectedDay == 6{
                    if !(morningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.morningdisplayHoursSaturday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }else{
                        restaurantRequest.morningdisplayHoursSaturday = "\(morningFromDisplay ?? "")-\(morningToDisplay ?? "")"
                        }
                    }
                    if !(eveningFromDisplay ?? "").isEmpty{
                        if isStore == 1{
                            storeRequest.eveningdisplayHoursSaturday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }else{
                        restaurantRequest.eveningdisplayHoursSaturday = "\(eveningFromDisplay ?? "")-\(eveningToDisplay ?? "")"
                        }
                    }
                }
                
            }
            
        }
    }
    
    func updateRestInfo(){
        restaurantRequest.isEdit = true
        
        restaurantRequest.id = "\(restaurantID ?? 0)"
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.postRestaurant(restaurantRequest: self.restaurantRequest, success: { (response) in
            print(response)
             self.navigationController?.popToRootViewController(animated: true)
            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }

    }
    
    func updateStoreInfo(){
        storeRequest.isEdit = true
                  storeRequest.id = "\(storeID ?? 0)"
                  FFLoaderView.showInView(view: self.view)
                  FFManagerClass.suggestStore(storeRequest: self.storeRequest, success: { (response) in
            print(response)
         self.dismiss(animated: true, completion: nil)
         NotificationCenter.default.post(name: Notification.Name("storeInfoUpdated"), object: nil)

            FFLoaderView.hideInView(view: self.view)
        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)
        }
    }
}
