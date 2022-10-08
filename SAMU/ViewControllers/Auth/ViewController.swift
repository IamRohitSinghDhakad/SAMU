//
//  ViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 23/09/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnGetStarted(_ sender: Any) {
       // self.pushVc(viewConterlerId: "LoginViewController")
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        self.window?.rootViewController = navController
    }
}

