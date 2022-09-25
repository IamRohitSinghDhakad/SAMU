//
//  ForgotPasswordViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 24/09/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var tfmobile: UITextField!
    @IBOutlet weak var imgVw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgVw.setImageColor(color: UIColor.blue)
        // Do any additional setup after loading the view.
    }


    @IBAction func btnOnSubmit(_ sender: Any) {
        
    }
    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
}
