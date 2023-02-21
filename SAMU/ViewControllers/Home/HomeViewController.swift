//
//  HomeViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 23/09/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, CLLocationManagerDelegate {

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
    
    var destinationLatitude = Double()
    var destinationLongitude = Double()
    
    private var locationManager:CLLocationManager?
    var location: Location? {
        didSet {
            self.lblAddress.text = location.flatMap({ $0.title }) ?? "No location selected"
            let cordinates = location.flatMap({ $0.coordinate })
            if (cordinates != nil){
              
                destinationLatitude = cordinates?.latitude ?? 0.0
                destinationLongitude = cordinates?.longitude ?? 0.0
                
                var xCordinate = ""
                var yCordinate = ""
                
                if let latitude = cordinates?.latitude {
                    xCordinate = "\(latitude)"
                }
                if let longitude = cordinates?.longitude{
                    yCordinate = "\(longitude)"
                }
                
                self.getAddressFromLatLong(plLatitude: xCordinate, plLongitude: yCordinate, completion: { (dictAddress) in

                    
                    if let fullAddress = dictAddress["fullAddress"]as? String{
                        self.lblAddress.text = fullAddress
                    }else{
                        self.lblAddress.text = dictAddress["country"]as? String ?? ""
                    }
                    
                    
                }) { (Error) in
                    print(Error)
                }
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserLocation()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getUserLocation() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.getAddressFromLatLong(plLatitude: "\(location.coordinate.latitude)", plLongitude: "\(location.coordinate.longitude)", completion: { (dictAddress) in

                if let fullAddress = dictAddress["fullAddress"]as? String{
                    self.lblAddress.text = fullAddress
                }else{
                    self.lblAddress.text = dictAddress["country"]as? String ?? ""
                }
            }) { (Error) in
                print(Error)
            }
        }
    }
    
    @IBAction func btnOnOpenLocationPicker(_ sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = false
        let sb = UIStoryboard.init(name: "LocationPicker", bundle: Bundle.main)
        let locationPicker = sb.instantiateViewController(withIdentifier: "LocationPickerViewController")as! LocationPickerViewController
        locationPicker.location = location
        locationPicker.showCurrentLocationButton = true
        locationPicker.useCurrentLocationAsHint = true
        locationPicker.selectCurrentLocationInitially = true
        locationPicker.completion = { self.location = $0 }
        self.navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    @IBAction func btnGotoProfile(_ sender: UIButton) {
        //pushVc(viewConterlerId: "MyProfileViewController")
        pushVc(viewConterlerId: "BaseViewController")
        
        
    }
    @IBAction func btnShowAddress(_ sender: UIButton) {
        self.vwAddress.isHidden = self.vwAddress.isHidden == false ? true : false
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

extension HomeViewController : BottomTabBarDelegate{
    
    func btnOnChatAction(sender: UIButton) {
        print("Navigate To Chat")
    }
    
    func btnOnHomeAction(sender: UIButton) {
        print("Navigate To Home")
    }
    
    func btnOnWorkAction(sender: UIButton) {
        print("Navigate To Work")
    }
    
    func btnOnMoreAction(sender: UIButton) {
        print("Navigate To More")
    }
    
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


extension HomeViewController{
    func getAddressFromLatLong(plLatitude: String, plLongitude: String, completion:@escaping(Dictionary<String,Any>) ->Void, failure:@escaping (Error) ->Void){
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(plLatitude)")!
    
        let lon: Double = Double("\(plLongitude)")!
    
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                
                let pm = (placemarks ?? []) as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks?[0]
                    print(pm?.country ?? "")
                    print(pm?.locality ?? "")
                    print(pm?.subLocality ?? "")
                    print(pm?.thoroughfare ?? "")
                    print(pm?.postalCode ?? "")
                    print(pm?.subThoroughfare ?? "")
                    
                    var dictAddress = [String:Any]()
                    var addressString : String = ""
                    
                    if pm?.subLocality != nil {
                        addressString = addressString + (pm?.subLocality!)! + ", "
                        dictAddress["subLocality"] = pm?.subLocality
                    }
                    if pm?.thoroughfare != nil {
                        addressString = addressString + (pm?.thoroughfare!)! + ", "
                        dictAddress["thoroughfare"] = pm?.thoroughfare
                    }
                    if pm?.locality != nil {
                        addressString = addressString + (pm?.locality!)! + ", "
                        dictAddress["locality"] = pm?.locality
                    }
                    if pm?.country != nil {
                        addressString = addressString + (pm?.country!)! + ", "
                        dictAddress["country"] = pm?.country
                    }
                    if pm?.postalCode != nil {
                        addressString = addressString + (pm?.postalCode!)! + " "
                        dictAddress["fullAddress"] = addressString
                    }
                    
                    
                    if dictAddress.count != 0{
                        completion(dictAddress)
                    }else{
                        
                        //failure("Something Wrong Happend! please dubug code :)" as? Error)
                    }
                    
                }
        })
        
    }
}
