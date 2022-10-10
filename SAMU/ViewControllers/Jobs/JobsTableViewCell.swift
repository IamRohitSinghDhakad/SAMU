//
//  JobsTableViewCell.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 10/10/22.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblReviewed: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
