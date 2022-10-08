//
//  TabBarViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 08/10/22.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
