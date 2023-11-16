//
//  FFReviewTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by LumiMac on 5/21/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit
import Cosmos

class FFReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView:UIView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var ratingLabel:UILabel!
    @IBOutlet weak var ratingView:CosmosView!
    @IBOutlet weak var profileImageview:UIImageView!

    var reviewObject:FFReviewObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
        
        holderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        holderView.layer.borderWidth = 1
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        
        nameLabel.text = reviewObject?.userDetail?.nickName
//        dateLabel.text = reviewObject?.createdDate
        if let createdDate = reviewObject?.createdDate {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateObj = dateFormatter.date(from: createdDate)
        
//        dateFormatter.dateFormat = "dd MMMM"
            dateFormatter.dateFormat = "dd MMM yyyy"
            var formatedDate =  dateFormatter.string(from: dateObj!)
//            formatedDate = formatedDate + " at "
//
//            dateFormatter.dateFormat = "hh"
//            formatedDate = formatedDate + dateFormatter.string(from: dateObj!) + "h"
//            dateFormatter.dateFormat = "mm"
//            formatedDate = formatedDate + dateFormatter.string(from: dateObj!)
            
            dateLabel.text = formatedDate
            
        }
        descriptionLabel.text = reviewObject?.review
        if let score = reviewObject?.note {
            ratingView.rating = Double(score)
            ratingLabel.text = String(format:"%.0f/5",ratingView.rating)
        }
 
    }

}
