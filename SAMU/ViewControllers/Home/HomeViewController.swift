//
//  HomeViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 23/09/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var vwAddress: UIView!
    @IBOutlet weak var cvAllServices: UICollectionView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var cvSliderFirst: UICollectionView!
    @IBOutlet weak var pageControllerFirst: UIPageControl!
    @IBOutlet weak var cvPopularService: UICollectionView!
    @IBOutlet weak var cvSliderSecond: UICollectionView!
    @IBOutlet weak var pageControllSecond: UIPageControl!
    @IBOutlet weak var vwContainBottomBar: UIView!
    
    var arrAllServices = [String]()
    var arrBannerFirst = [BannerModel]()
    var arrBannerSecond = [BannerModel]()
    var arrCategoryFirst = [CategoryModel]()
    var timer = Timer()
    var pageIndexCVOne = 1
    var pageIndexCVTwo = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwAddress.isHidden = true
        self.cvAllServices.delegate = self
        self.cvAllServices.dataSource = self
        self.cvSliderFirst.delegate = self
        self.cvSliderFirst.dataSource = self
        
        self.cvPopularService.delegate = self
        self.cvPopularService.dataSource = self
        self.cvSliderSecond.delegate = self
        self.cvSliderSecond.dataSource = self
        
        self.pageControllerFirst.numberOfPages = 0
        self.pageControllSecond.numberOfPages = 0
        
        self.call_WsGetBanner()
        self.call_WsGetCategory()
        
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let norecordView: BottomTabBar = BottomTabBar(frame: CGRect(x: self.vwContainBottomBar.frame.origin.x, y: self.vwContainBottomBar.frame.origin.y, width: self.vwContainBottomBar.frame.width - 8, height: self.vwContainBottomBar.frame.height))
            self.view.layoutIfNeeded()
            self.view.addSubview(norecordView)
            self.view.layoutIfNeeded()
        })
        
        
        
        
    }
    
    @IBAction func btnOnOpenLocationPicker(_ sender: UIButton) {
        
    }
    
    @IBAction func btnGotoProfile(_ sender: UIButton) {
        
    }
    @IBAction func btnShowAddress(_ sender: UIButton) {
        self.vwAddress.isHidden = self.vwAddress.isHidden ? true : false
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cvAllServices, cvPopularService:
            return self.arrCategoryFirst.count//self.arrAllServices.count
        case cvSliderFirst:
            return arrBannerFirst.count
        case cvSliderSecond:
            return self.arrBannerSecond.count
        default:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvAllServices || collectionView == self.cvPopularService{
            
            if collectionView == self.cvAllServices{
                let cell = self.cvAllServices.dequeueReusableCell(withReuseIdentifier: "AllServicesCollectionViewCell", for: indexPath)as! AllServicesCollectionViewCell
                
                let obj = self.arrCategoryFirst[indexPath.row]
             
                cell.lblTitle.text = obj.strCategoryName
                let profilePic = obj.strCategoryImage.trim().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    if profilePic != "" {
                        let url = URL(string: profilePic!)
                        cell.imgVw.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "bg"))
                    }
                
                return cell
            }else{
                let cell = self.cvPopularService.dequeueReusableCell(withReuseIdentifier: "AllServicesCollectionViewCell", for: indexPath)as! AllServicesCollectionViewCell
                
                let obj = self.arrCategoryFirst[indexPath.row]
                
//                if let first = obj.strCategoryName.components(separatedBy: " ").first {
//                    cell.lblTitle.text = first
//                }
                cell.lblTitle.text = obj.strCategoryName
                let profilePic = obj.strCategoryImage.trim().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    if profilePic != "" {
                        let url = URL(string: profilePic!)
                        cell.imgVw.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "bg"))
                    }
                
                return cell
            }

        }else if collectionView == self.cvSliderFirst || collectionView == self.cvSliderSecond{
            
            if collectionView == self.cvSliderFirst{
                let cellSlider = self.cvSliderFirst.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath)as! SliderCollectionViewCell
                
                let obj = self.arrBannerFirst[indexPath.row]
                    if let user_image = obj.strBannerImage.trim().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                        let profilePic = user_image
                        if profilePic != "" {
                            let url = URL(string: profilePic)
                            cellSlider.imgVwSlider.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "bg"))
                        }
                    }else{
                        cellSlider.imgVwSlider.image = #imageLiteral(resourceName: "logo_white")
                    }
                return cellSlider
            }else{
                let cellSlider = self.cvSliderSecond.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath)as! SliderCollectionViewCell
                
                let obj = self.arrBannerSecond[indexPath.row]
                    if let user_image = obj.strBannerImage.trim().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                        let profilePic = user_image
                        if profilePic != "" {
                            let url = URL(string: profilePic)
                            cellSlider.imgVwSlider.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "bg"))
                        }
                    }else{
                        cellSlider.imgVwSlider.image = #imageLiteral(resourceName: "logo_white")
                    }
                
                return cellSlider
            }
        
        } else{
            return UICollectionViewCell()
        }
    }
    
}

/// ============================== ##### UICollectionView Flow Layout Delegates And Datasources ##### ==================================//

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.cvAllServices || collectionView == self.cvPopularService {
            let noOfCellsInRow = 5
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: size + 20 )
            
        }
        
        if collectionView == self.cvSliderFirst || collectionView == self.cvSliderSecond {
            let noOfCellsInRow = 1
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: 160 )
            
        }else{
            
            return CGSize(width: 200, height: 200)
        }
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //
    //        if scrollView == self.cvSlider{
    //            self.pageControllerSlider?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    //        }
    //    }
    
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //
    //        if scrollView == self.cvSlider{
    //            self.pageControllerSlider?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    //        }
    //
    //    }
    
}
///Auto Scroll logic
extension HomeViewController{
    
    func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(HomeViewController.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
    
        AutoScrollHandler(pageIndex: &self.pageIndexCVOne, arrCount: self.arrBannerFirst.count, collectionViewName: self.cvSliderFirst, pageControllerName: self.pageControllerFirst)
        
        AutoScrollHandler(pageIndex: &self.pageIndexCVTwo, arrCount: self.arrBannerSecond.count, collectionViewName: self.cvSliderSecond, pageControllerName: self.pageControllSecond)
    }
    
    func AutoScrollHandler( pageIndex: inout Int, arrCount:Int, collectionViewName:UICollectionView, pageControllerName: UIPageControl){
        if  pageIndex < arrCount {
            let indexPath = IndexPath(item: pageIndex, section: 0)
            pageControllerName.currentPage = indexPath.row
            collectionViewName.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageIndex = pageIndex + 1
        }else{
            pageControllerName.currentPage = 0
            pageIndex = 0
            collectionViewName.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: Call Webservice
extension HomeViewController{
    
    //MARK:- Banner API
    func call_WsGetBanner(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetBanner, queryParams: [:], params: [:], strCustomValidation: "", showIndicator: false) { response in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                
                if let arrData = response["result"]as? [[String:Any]]{
                    for data in arrData{
                        let obj = BannerModel.init(dict: data)
                        if obj.strBannerType == "1"{
                            self.arrBannerFirst.append(obj)
                        }else{
                            self.arrBannerSecond.append(obj)
                        }
                    }
                    self.pageControllerFirst.numberOfPages = self.arrBannerFirst.count
                    self.pageControllSecond.numberOfPages = self.arrBannerSecond.count
                    self.cvSliderFirst.reloadData()
                    self.cvSliderSecond.reloadData()
                    
                    self.setTimer()
                    
                }else{
                    objAlert.showAlert(message: "Banner Data not found", title: "Alert", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { Error in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
        
    }
    
    func call_WsGetCategory(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetCategory, queryParams: [:], params: [:], strCustomValidation: "", showIndicator: false) { response in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                
                if let arrData = response["result"]as? [[String:Any]]{
                    for data in arrData{
                        let obj = CategoryModel.init(dict: data)
                            self.arrCategoryFirst.append(obj)
                    }
                    
                    self.cvAllServices.reloadData()
                    self.cvPopularService.reloadData()
                    
                    
                }else{
                    objAlert.showAlert(message: "Banner Data not found", title: "Alert", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { Error in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
        
    }
}
