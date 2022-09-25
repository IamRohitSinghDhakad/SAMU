//
//  LoginViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 24/09/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imgVwLogo: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var imgVwTermsConditionCheck: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgVwLogo.setImageColor(color: UIColor.blue)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSignIn(_ sender: Any) {
    }
    
    @IBAction func btnAcceptTermsAndCondition(_ sender: Any) {
        
    }
    @IBAction func btnForgotPassword(_ sender: Any) {
        self.pushVc(viewConterlerId: "ForgotPasswordViewController")
    }
    
    @IBAction func btnDontHaveAccount(_ sender: Any) {
        pushVc(viewConterlerId: "SignUpViewController")
    }
}
