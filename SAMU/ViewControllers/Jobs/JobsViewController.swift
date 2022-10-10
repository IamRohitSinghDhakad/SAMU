//
//  JobsViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 29/09/22.
//

import UIKit

class JobsViewController: UIViewController {

    @IBOutlet weak var tblVwJobs: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblVwJobs.delegate = self
        self.tblVwJobs.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension JobsViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTableViewCell")as! JobsTableViewCell
        
        
        cell.imgVw.image = UIImage(imageLiteralResourceName: "Group 5")
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushVc(viewConterlerId: "JobDetailsViewController")
    }
    
    
    
    
}
