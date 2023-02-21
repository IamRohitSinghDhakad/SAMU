//
//  ViewControllerTwo.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 11/10/22.
//

import UIKit

class ViewControllerTwo: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        
        // Do any additional setup after loading the view.
    }

}

extension ViewControllerTwo: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell")as! ReviewsTableViewCell
        
        if indexPath.row < 5{
            cell.lblComment.text = "this is loream ipsum test I am reviw the profile and there is nothing into it and I am checking multiple lines comment here"
        }else{
            cell.lblComment.text = "this is loream ipsum test"
        }
        
        
        return cell
    }
    
    
    
    
    
    
}
