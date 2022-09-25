//
//  BottomTabBar.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 25/09/22.
//

import UIKit

class BottomTabBar: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnWork: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
    
    @IBAction func btnOnChat(_ sender: Any) {
        print("Chat Pressed")
    }
    @IBAction func btnOnHome(_ sender: UIButton) {
        print("Home Pressed")
    }
    
    @IBAction func btnOnWork(_ sender: UIButton) {
        print("Work Pressed")
    }
    @IBAction func btnOnMore(_ sender: Any) {
        print("More Pressed")
    }
    
    
    func commonInit(){
           let viewFromXib = Bundle.main.loadNibNamed("BottomTabBar", owner: self, options: nil)![0] as! UIView
           viewFromXib.frame = self.bounds
           addSubview(viewFromXib)
       }

}
