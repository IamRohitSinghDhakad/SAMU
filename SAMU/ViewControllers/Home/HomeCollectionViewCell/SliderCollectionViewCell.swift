//
//  SliderCollectionViewCell.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 25/09/22.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgVwSlider: UIImageView!
    
    override func awakeFromNib() {
        self.imgVwSlider.layer.masksToBounds = true
        self.imgVwSlider.cornerRadius = 10
        self.imgVwSlider.viewShadowHeaderWithCorner(corner: 10)
    }
}
