//
//  AllServicesCollectionViewCell.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 24/09/22.
//

import UIKit

class AllServicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        self.vwBg.clipsToBounds = true
        self.imgVw.layer.masksToBounds = true
        self.imgVw.cornerRadius = 10
        self.imgVw.viewShadowHeaderWithCorner(corner: 10)
    }
}
