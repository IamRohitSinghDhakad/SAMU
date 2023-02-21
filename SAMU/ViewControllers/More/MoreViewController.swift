//
//  NoreViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 10/10/22.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet var tblVw: UITableView!
    @IBOutlet var vwSubVw: UIView!
    
    var arrOptions = [String]()
    var userType =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        
    //    self.vwSubVw.isHidden = true
        self.arrOptions = ["Contact Us", "Help", "Terms& Condition", "About the App","Log Out"]
    }
    
}


extension MoreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell")as! MoreTableViewCell
        
        cell.lblTitle.text = self.arrOptions[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
        self.navigationController?.pushViewController(vc, animated: true)
        /*
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
            vc.strIsComingFrom = "Contacto y sugerencias"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
            vc.strIsComingFrom = "Política de Privacidad"
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
            vc.strIsComingFrom = "Condiciones de Uso"
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
            vc.strIsComingFrom = "Política de Cookies"
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
            vc.strIsComingFrom = "Info Social, Fiscal y Jurídica"
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            self.vwSubVw.isHidden = false
        case 6:
            if userType == "provider" || userType == "Provider"{
                self.pushVc(viewConterlerId: "MembershipViewController")
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
                vc.strIsComingFrom = "Acerca de"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 7:
            if userType == "provider" || userType == "Provider"{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewShowViewController")as! WebViewShowViewController
                vc.strIsComingFrom = "Acerca de"
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                objAlert.showAlertCallBack(alertLeftBtn: "SI", alertRightBtn: "No", title: "", message: "Quieres salir?", controller: self) {
                    exit(0)
                }
            }
            
        default:
            objAlert.showAlertCallBack(alertLeftBtn: "SI", alertRightBtn: "No", title: "", message: "Quieres salir?", controller: self) {
                exit(0)
            }
            
        }
         */
    }
  
    
    
}

