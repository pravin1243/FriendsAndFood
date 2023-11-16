//
//  FFNotificationTableViewCell.swift
//  FriendsAndFoodApp
//
//  Created by Lumi-Mac2 on 26/06/18.
//  Copyright © 2018 LumiMac. All rights reserved.
//

import UIKit

class FFNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgView:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var detailLbl:UILabel!
    @IBOutlet weak var timeLbl:UILabel!
    
    var notificationObj:FFNotificationObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailLbl.isHidden = true
//        self.timeLbl.isHidden = true

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCell(){
//        titleLbl.text = notificationObj?.content

        
        titleLbl.text = notificationObj?.content
//        detailLbl.text = notificationObj?.recipeReview?.review
//        timeLbl.text = notificationObj?.createdDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current

        let dateObj = dateFormatter.date(from: (notificationObj?.createdDate)!)

        let formattedDateString = getPastTime(for: dateObj!)
        timeLbl.text = formattedDateString

        if let photo = notificationObj?.user?.photo {

        let imageUrl:URL = URL(string: photo)!
        profileImgView.kf.setImage(with: imageUrl)
        }
        
    }
    
    func getPastTime(for date : Date) -> String {
        
        
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, hh:mm a"
//            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: date)
            return strDate
        }
    }

}
