//
//  MyProfileViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 11/10/22.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnBackHeader(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnEditProfile(_ sender: Any) {
        pushVc(viewConterlerId: "EditProfileViewController")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
