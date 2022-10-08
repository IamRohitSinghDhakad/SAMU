//
//  BottomTabBar.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 25/09/22.
//

protocol BottomTabBarDelegate{
    
    func btnOnChatAction(sender: UIButton)
    
    func btnOnHomeAction(sender: UIButton)
    
    func btnOnWorkAction(sender: UIButton)
    
    func btnOnMoreAction(sender: UIButton)
}

import UIKit

class BottomTabBar: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnWork: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    var delegate: BottomTabBarDelegate?
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
    
    @IBAction func btnOnChat(_ sender: UIButton) {
        delegate?.btnOnChatAction(sender: sender)
    }
    @IBAction func btnOnHome(_ sender: UIButton) {
        delegate?.btnOnHomeAction(sender: sender)
    }
    
    @IBAction func btnOnWork(_ sender: UIButton) {
        delegate?.btnOnWorkAction(sender: sender)
    }
    @IBAction func btnOnMore(_ sender: UIButton) {
        delegate?.btnOnMoreAction(sender: sender)
    }
    
    
    func commonInit(){
           let viewFromXib = Bundle.main.loadNibNamed("BottomTabBar", owner: self, options: nil)![0] as! UIView
           viewFromXib.frame = self.bounds
           addSubview(viewFromXib)
       }

}
