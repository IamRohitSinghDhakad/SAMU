//
//  CategoryModel.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 25/09/22.
//

import UIKit

class CategoryModel: NSObject {
    
    var strCategoryID: String = ""
    var strCategoryImage: String = ""
    var strCategoryName:String = ""
    var strTotalJobs:String = ""
    
    
    init(dict : [String:Any]) {
        
        if let category_id = dict["category_id"] as? String{
            self.strCategoryID = category_id
        }else if let category_id = dict["category_id"] as? Int{
            self.strCategoryID = "\(category_id)"
        }
        
        if let total_jobs = dict["total_jobs"] as? String{
            self.strCategoryID = total_jobs
        }else if let total_jobs = dict["total_jobs"] as? Int{
            self.strCategoryID = "\(total_jobs)"
        }
        
        
        if let category_image = dict["category_image"] as? String{
            self.strCategoryImage = category_image
        }
        
        if let category_name = dict["category_name"] as? String{
            self.strCategoryName = category_name
        }
    }
}
