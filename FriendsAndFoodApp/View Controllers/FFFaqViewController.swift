//
//  FFFaqViewController.swift
//  FriendsAndFoodApp
//
//  Created by iskpro on 07/10/20.
//  Copyright © 2020 LumiMac. All rights reserved.
//

import UIKit

class FFFaqViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var titleLabel:UILabel!

    @IBOutlet weak var faqTableView:UITableView!
        var faqList:[FFFaqObject] = []
    var totalCount:String?

    var prefaqList:[FFFaqObject] = []
    var showHide:[Int] = []
    let acc: String? = nil
    var oldTag: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        faqTableView.dataSource = self
        faqTableView.delegate  = self
        totalCount = "10"
        loadFAQData()
//        titleLabel.text = "\(StringConstants.faq.Frequentlyaskedquestions)"
        self.title = "\(StringConstants.faq.Frequentlyaskedquestions)"
        // Do any additional setup after loading the view.
    }
    func loadFAQData(){ // FAQ Data webservice
        
        FFLoaderView.showInView(view: self.view)
        FFManagerClass.getHomeFAQData(page:"1", maxresults: self.totalCount, success: { (response) in
            FFLoaderView.hideInView(view: self.view)
            print(response)
            self.prefaqList  =  response
            if self.prefaqList.count > 0{
            for i in 0...self.prefaqList.count - 1{
                if self.prefaqList[i].answer == ""{
                }else{
                    self.faqList.append(self.prefaqList[i])
                    self.showHide.append(0)
                }
            }
            }
            self.faqTableView.reloadData()

        }) { (error) in
            print(error)
            FFLoaderView.hideInView(view: self.view)
            FFBaseClass.sharedInstance.showError(error: error, view: self)


        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
          if faqList.count > 0 {
              return 1
              
          }else {
              return 0
          }
      }
      
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return faqList.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FFIngredientDetailTableViewCell
              
            let question = "\(self.faqList[indexPath.row].question?.capitalizingFirstLetter() ?? "")?"
              cell.faqQuestionLbl.text = self.toHtmlEncodedString(encodedString: question)
              if self.showHide[indexPath.row] == 1{
                  let answer = "\(self.faqList[indexPath.row].answer ?? "")"
                  cell.faqAnswerLbl.text = self.toHtmlEncodedString(encodedString:  answer)
              }else{
                  cell.faqAnswerLbl.text = ""
              }
              cell.showHideFaqBtn.tag = indexPath.row
              cell.showHideFaqBtn.addTarget(self, action: #selector(showHideFaqBtn), for: .touchUpInside)
              return cell
          }
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
          }
      

    
    @objc func showHideFaqBtn(_ sender: UIButton){
        showHide[oldTag ?? 0] = 0
            showHide[sender.tag] = 1
        if oldTag == sender.tag{
            showHide[sender.tag] = 0
        }
        self.faqTableView.reloadData()
        oldTag = sender.tag
    }
    
    func toHtmlEncodedString(encodedString:String) -> String { //decode html string
        guard let encodedData = encodedString.data(using: .utf8) else {
            return ""
        }
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return( attributedString.string)
        } catch {
            print("Error: \(error)")
        }
        return ""
    }
 

    @IBAction func seeMoreTapped(_ sender: UIButton){
        var currentCount = Int(totalCount ?? "")
        currentCount = (currentCount ?? 0) + 10
        totalCount = "\(currentCount ?? 0)"
        loadFAQData()
    }
}
