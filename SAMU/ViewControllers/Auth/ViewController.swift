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
        self.pushVc(viewConterlerId: "LoginViewController")
    }
}
