//
//  LaunchViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 23/09/22.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var vwLogo: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwLogo.frame = CGRect(x: self.vwLogo.frame.origin.x, y: UIScreen.main.bounds.size.height/2, width: self.vwLogo.frame.size.width, height: self.vwLogo.frame.size.height)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Up()
    }
    
    //MARK: - Animation Methods
    
    func Up()  {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveLinear], animations: {
            self.vwLogo.frame = CGRect(x: self.vwLogo.frame.origin.x, y: 0, width: self.vwLogo.frame.size.width, height: self.vwLogo.frame.size.height)
          //  self.imgVwAnimation.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        }) { (finished) in
            if finished {
              //  self.vwLogo.tilt()
                
                //==============XXXX===============//
                
                UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        
                       // HERE
                    self.imgVw.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // Scale your image

                 }) { (finished) in
                     UIView.animate(withDuration: 2, animations: {
                       
                      self.imgVw.transform = CGAffineTransform.identity // undo in 1 seconds

                   })
                }
                
                //=============XXXX===============//
                
                
                // Repeat animation to bottom to top
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.goToNextController()
                }
            }
        }
    }
    
    //MARK: - Redirection Methods
    func goToNextController() {
        if AppSharedData.sharedObject().isLoggedIn {
            let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            self.window?.rootViewController = navController
        }
        else {
            let vc = (self.authStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            self.window?.rootViewController = navController
        }
    }
}
