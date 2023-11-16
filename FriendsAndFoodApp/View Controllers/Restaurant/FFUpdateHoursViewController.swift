//
//  FFUpdateHoursViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 22/09/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFUpdateHoursViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
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

    @IBOutlet weak var openBtn:UIButton!
    @IBOutlet weak var closeBtn:UIButton!
    var isChecked:Bool? = true
    var isClosed:Int? = -1

    var fromHeigt: CGFloat?
    var toHeigt: CGFloat?
    var selectedDay: Int? = 0
    var selectedShift: Int? = 0
    var selectedFrom: Int? = -1
    var selectedTo: Int? = -1
    var restaurantRequest = FFAddRestaurantRequestModel()
    var storeRequest = FFSuggestStorePostModel()

    var shiftArray = [String]()
    var lunchfromArray = [String]()
    var allDayArray = [String]()
    var dinnerfromArray = [String]()
    var dinnertoArray = [String]()
    var daysOpenHour:[FFDisplayHourModel]? = [FFDisplayHourModel]()
    var lunchFromHourArray:[fromToTime]? = [fromToTime]()
    var dinnerFromHourArray:[fromToTime]? = [fromToTime]()
    var alldayFromHourArray:[fromToTime]? = [fromToTime]()

    var lunchToHourArray:[fromToTime]? = [fromToTime]()
    var dinnerToHourArray:[fromToTime]? = [fromToTime]()
    var alldayToHourArray:[fromToTime]? = [fromToTime]()

    @IBOutlet weak var storeOpenLabel:UILabel!
    var day: String?
    
    @IBOutlet weak var dayHeaderLabel:UILabel!
    var allDayDisplay: String?
    var morningDisplay: String?
    var eveningDisplay: String?
    
    var allDayFromDisplay: String?
    var morningFromDisplay: String?
    var eveningFromDisplay: String?

    var allDayToDisplay: String?
    var morningToDisplay: String?
    var eveningToDisplay: String?

    var isAllDay: Bool? = false
    
    var restaurantID:Int?
    var storeID:Int?
    var isStore: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allDayDisplayArr : [String] = allDayDisplay?.components(separatedBy: "-") ?? []
        let morningDisplayArr : [String] = morningDisplay?.components(separatedBy: "-") ?? []
        let eveningDisplayArr : [String] = eveningDisplay?.components(separatedBy: "-") ?? []
        if !(allDayDisplay?.isEmpty ?? false){
            selectedShift = 0
        allDayFromDisplay = allDayDisplayArr[0]
        allDayToDisplay = allDayDisplayArr[1]
        }
        if !(morningDisplay?.isEmpty ?? false){
            selectedShift = 1

        morningFromDisplay = morningDisplayArr[0]
        morningToDisplay = morningDisplayArr[1]
        }
        if !(eveningDisplay?.isEmpty ?? false){

        eveningFromDisplay = eveningDisplayArr[0]
        eveningToDisplay = eveningDisplayArr[1]
        }
        storeOpenLabel.text = "Is the store is open on \(day ?? "")?"
        dayHeaderLabel.text = "Update Open Hours For \(day ?? "")"
         shiftArray = ["All Day","Lunch", "Dinner"]
         lunchfromArray = ["6:00", "6:30", "7:00", "7:30", "8:00", "8:30","9:00", "9:30", "10:00", "10:30", "11:00", "11:30","12:00", "12:30","13:00", "13:30","14:00", "14:30"]
         allDayArray = ["6:00", "6:30", "7:00", "7:30", "8:00", "8:30","9:00", "9:30", "10:00", "10:30", "11:00", "11:30","12:00", "12:30","13:00", "13:30","14:00"]
         dinnerfromArray = ["14:00", "14:30", "15:00", "15:30", "16:00", "16:30","17:00", "17:30", "18:00", "18:30", "19:00", "19:30","20:00", "20:30","21:00", "21:30","22:00", "22:30","23:00", "23:30","23:59"]
         dinnertoArray = ["14:00", "14:30", "15:00", "15:30", "16:00", "16:30","17:00", "17:30", "18:00", "18:30", "19:00", "19:30","20:00", "20:30","21:00", "21:30","22:00", "22:30","23:00", "23:30","23:59"]

         for i in 0...lunchfromArray.count - 1{
            if morningFromDisplay == lunchfromArray[i]{
                lunchFromHourArray?.append(fromToTime(fromTime: lunchfromArray[i], toTime: "", isChecked: 1))

            }else{
                lunchFromHourArray?.append(fromToTime(fromTime: lunchfromArray[i], toTime: "", isChecked: 0))

            }
            if morningToDisplay == lunchfromArray[i]{
                lunchToHourArray?.append(fromToTime(fromTime: "", toTime: lunchfromArray[i], isChecked: 1))

            }else{
                lunchToHourArray?.append(fromToTime(fromTime: "", toTime: lunchfromArray[i], isChecked: 0))

            }

         }
         for i in 0...dinnerfromArray.count - 1{
            if eveningFromDisplay == dinnerfromArray[i]{
                dinnerFromHourArray?.append(fromToTime(fromTime: dinnerfromArray[i], toTime: "", isChecked: 1))
            }else{
                dinnerFromHourArray?.append(fromToTime(fromTime: dinnerfromArray[i], toTime: "", isChecked: 0))
            }
            if eveningToDisplay == dinnerfromArray[i]{
                dinnerToHourArray?.append(fromToTime(fromTime: "", toTime: dinnerfromArray[i], isChecked: 1))
            }else{
                dinnerToHourArray?.append(fromToTime(fromTime: "", toTime: dinnerfromArray[i], isChecked: 0))
            }

         }
         for i in 0...allDayArray.count - 1{
            if allDayFromDisplay == allDayArray[i]{
                alldayFromHourArray?.append(fromToTime(fromTime: allDayArray[i], toTime: "", isChecked: 1))

            }else{
                alldayFromHourArray?.append(fromToTime(fromTime: allDayArray[i], toTime: "", isChecked: 0))

            }
            if allDayToDisplay == allDayArray[i]{
                          alldayToHourArray?.append(fromToTime(fromTime: "", toTime: allDayArray[i], isChecked: 1))

                      }else{
                          alldayToHourArray?.append(fromToTime(fromTime: "", toTime: allDayArray[i], isChecked: 0))

                      }

        }
        daysOpenHour?.append(FFDisplayHourModel(day: day, lunchFrom: lunchFromHourArray, lunchTo: lunchToHourArray,allDayFrom:alldayFromHourArray,allDayTo:alldayToHourArray  ,dinnerFrom: dinnerFromHourArray, dinnerTo: dinnerToHourArray, isChecked: 0, selectedFrom: 0, selectedTo: 0, isOpen: 0))

        self.shiftCollectionView.reloadData()
        self.fromTimeCollectionView.reloadData()
        self.toTimeCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          fromHeigt = fromHeightConstraint.constant
          toHeigt = toHeightConstraint.constant
        shiftCollectionView.dataSource  = self
        shiftCollectionView.delegate = self
        fromTimeCollectionView.dataSource  = self
        fromTimeCollectionView.delegate = self
        toTimeCollectionView.dataSource  = self
        toTimeCollectionView.delegate = self

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shiftCollectionView{
            return shiftArray.count
        }else if collectionView == fromTimeCollectionView{
            if selectedShift == 0{
                if daysOpenHour?.count ?? 0 > 0{
                    
                    return daysOpenHour?[0].allDayFrom?.count ?? 0
                }else{
                    return 0
                }
            }else if selectedShift == 1{
                if daysOpenHour?.count ?? 0 > 0{
                    
                    return daysOpenHour?[0].lunchFrom?.count ?? 0
                }else{
                    return 0
                }
            }
            else{
                if daysOpenHour?.count ?? 0 > 0{
                    
                    return daysOpenHour?[0].dinnerFrom?.count ?? 0
                }else{
                    return 0
                }
            }
        }else if collectionView == toTimeCollectionView{
            if selectedShift == 0{
                if daysOpenHour?.count ?? 0 > 0{
                    return daysOpenHour?[0].allDayTo?.count ?? 0
                }else{
                    return 0
                }
            }else if selectedShift == 1{
                if daysOpenHour?.count ?? 0 > 0{
                    return daysOpenHour?[0].lunchTo?.count ?? 0
                }else{
                    return 0
                }
            }
            else{
                if daysOpenHour?.count ?? 0 > 0{
                    return daysOpenHour?[0].dinnerTo?.count ?? 0
                }else{
                    return 0
                }
            }
        }else{
            return 0
        }
    }
            
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var collectCell: UICollectionViewCell = UICollectionViewCell()
      if collectionView == shiftCollectionView {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShiftCell", for: indexPath)
                
                let label = cell.viewWithTag(100) as! UILabel
                label.text = " \(self.shiftArray[indexPath.row]) "
                label.layer.cornerRadius = 4
                label.layer.borderWidth = 0.5
                label.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
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
                    label.text = " \(daysOpenHour?[0].allDayFrom?[indexPath.row].fromTime ?? "") "

                    if daysOpenHour?[0].allDayFrom?[indexPath.row].isChecked == 1{
                        label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                        label.textColor = UIColor.white
                        selectedFrom = indexPath.row
                    }else{
                        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        label.textColor = UIColor.black

                    }
                }else if selectedShift == 1{
                    label.text = " \(daysOpenHour?[0].lunchFrom?[indexPath.row].fromTime ?? "") "

                    if daysOpenHour?[0].lunchFrom?[indexPath.row].isChecked == 1{
                        label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                        label.textColor = UIColor.white
                        selectedFrom = indexPath.row
                    }else{
                        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        label.textColor = UIColor.black

                    }
                }
                else{
                    label.text = " \(daysOpenHour?[0].dinnerFrom?[indexPath.row].fromTime ?? "") "
                    if daysOpenHour?[0].dinnerFrom?[indexPath.row].isChecked == 1{
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
                    label.text = " \(daysOpenHour?[0].allDayTo?[indexPath.row].toTime ?? "") "
                    if daysOpenHour?[0].allDayTo?[indexPath.row].isChecked == 1{
                                     label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                     label.textColor = UIColor.white
                                 }else{
                                     label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                     label.textColor = UIColor.black

                                 }
                           }else if selectedShift == 1{
                               label.text = " \(daysOpenHour?[0].lunchTo?[indexPath.row].toTime ?? "") "

                               if daysOpenHour?[0].lunchTo?[indexPath.row].isChecked == 1{
                                   label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                   label.textColor = UIColor.white
                                   selectedFrom = indexPath.row
                               }else{
                                   label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                   label.textColor = UIColor.black

                               }
                           }
                else{
                    label.text = " \(daysOpenHour?[0].dinnerTo?[indexPath.row].toTime ?? "") "
                    if daysOpenHour?[0].dinnerTo?[indexPath.row].isChecked == 1{
                                                    label.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.7725490196, blue: 0.231372549, alpha: 1)
                                                    label.textColor = UIColor.white
                                                }else{
                                                    label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                                                    label.textColor = UIColor.black

                                                }
                           }

                
                        collectCell = cell

                        }
            return collectCell
        }
            

            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             if collectionView == shiftCollectionView{
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
        if collectionView == shiftCollectionView{
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
                FFBaseClass.sharedInstance.showAlert(mesage: "To time can not be less than From time", view: self)
                return
            }
            
            if selectedShift == 0{
                
                for i in 0...(daysOpenHour?[0].allDayTo?.count ?? 0) - 1{
                    if i == indexPath.row{
                        
                        daysOpenHour?[0].allDayTo?[i].isChecked = 1
                        
                    }else{
                        daysOpenHour?[0].allDayTo?[i].isChecked = 0
                        
                    }
                    
                }
                
            }else if selectedShift == 1{
                
                for i in 0...(daysOpenHour?[0].lunchTo?.count ?? 0) - 1{
                    if i == indexPath.row{
                        
                        daysOpenHour?[0].lunchTo?[i].isChecked = 1
                        
                    }else{
                        daysOpenHour?[0].lunchTo?[i].isChecked = 0
                        
                    }
                    
                }
                
            }
            else{
                
                for i in 0...(daysOpenHour?[0].dinnerTo?.count ?? 0) - 1{
                    if i == indexPath.row{
                        
                        daysOpenHour?[0].dinnerTo?[i].isChecked = 1
                        
                    }else{
                        daysOpenHour?[0].dinnerTo?[i].isChecked = 0
                        
                    }
                    
                }
                
            }
            toTimeCollectionView.reloadData()
        }
        
    }
        
    @IBAction func cancelBtntapped(_ sender : Any) {
              self.dismiss(animated: true, completion: nil)
          }
    
    @IBAction func confirmBtnTapped(_ sender : Any){
        
        
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
        
        
        if isStore == 1{
          self.updateStoreInfo()
        }else{
          self.updateRestInfo()
          }

        
    }
    
    
    func updateRestInfo(){
        restaurantRequest.isEdit = true
        restaurantRequest.id = "\(restaurantID ?? 0)"
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.postRestaurant(restaurantRequest: self.restaurantRequest, success: { (response) in
            print(response)
         self.dismiss(animated: true, completion: nil)
         NotificationCenter.default.post(name: Notification.Name("restInfoUpdated"), object: nil)

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
