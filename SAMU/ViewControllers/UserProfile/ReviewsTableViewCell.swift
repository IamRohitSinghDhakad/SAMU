//
//  ReviewsTableViewCell.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 12/10/22.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblRatingNumber: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var vwShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.vwShadow.layer.masksToBounds = true
        self.vwShadow.addShadowLikeCardView(corner: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
