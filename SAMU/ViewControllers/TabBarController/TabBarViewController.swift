//
//  TabBarViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 08/10/22.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var shapeLayer: CALayer?
    var color: UIColor?
    var radii: CGFloat = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = true
        var tabFrame            = self.tabBar.frame
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        
        print("Before===========>>>>> ", tabFrame.origin.y)
        tabFrame.size.height    = 30 + (keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y       = self.tabBar.frame.origin.y + ( self.tabBar.frame.height - 40 - (keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero))
        print("After ==========>>>>> ", tabFrame.origin.y)
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.frame            = tabFrame

        self.tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: 0.0) })
        
     //   addShape()
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        for vc in self.viewControllers! {
//            if #available(iOS 13.0, *) {
//                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom:2, right: 0)
//            }else{
//                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom:-6, right: 0)
//            }
//        }
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0   , height: -3);
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: radii).cgPath
        

        if let oldShapeLayer = self.shapeLayer {
            tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: tabBar.bounds,
            byRoundingCorners: [.allCorners],
            cornerRadii: CGSize(width: radii, height: 0.0))

        return path.cgPath
    }
}
