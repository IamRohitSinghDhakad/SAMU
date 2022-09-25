//
//  SignUpViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 24/09/22.
//

import UIKit
import CoreLocation

class SignUpViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var imgVwLogo: UIImageView!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var lblUserNameValidation: UILabel!
    @IBOutlet weak var vwContainlblValidation: UIView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfSurName: UITextField!
    @IBOutlet weak var tfCountryCode: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var destinationLatitude = Double()
    var destinationLongitude = Double()
    var datePicker = UIDatePicker()
    private var locationManager:CLLocationManager?
    var location: Location? {
        didSet {
            self.lblLocation.text = location.flatMap({ $0.title }) ?? "No location selected"
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
                        self.lblLocation.text = fullAddress
                    }else{
                        self.lblLocation.text = dictAddress["country"]as? String ?? ""
                    }
                    
                    
                }) { (Error) in
                    print(Error)
                }
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        self.vwContainlblValidation.isHidden = true
        self.imgVwLogo.setImageColor(color: .blue)
        showDatePicker()
        getUserLocation()
        // Do any additional setup after loading the view.
    }
    
    func getUserLocation() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnOnSubmit(_ sender: Any) {
        pushVc(viewConterlerId: "OTPViewController")
    }
    @IBAction func btnOnAlreadyHaveAccount(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnLocation(_ sender: Any) {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.getAddressFromLatLong(plLatitude: "\(location.coordinate.latitude)", plLongitude: "\(location.coordinate.longitude)", completion: { (dictAddress) in

                if let fullAddress = dictAddress["fullAddress"]as? String{
                    self.lblLocation.text = fullAddress
                }else{
                    self.lblLocation.text = dictAddress["country"]as? String ?? ""
                }
                
                
            }) { (Error) in
                print(Error)
            }
        }
    }
}

//MARK: Date of Birth Picker
extension SignUpViewController{
    
    func showDatePicker(){
        
        let screenWidth = UIScreen.main.bounds.width
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.maximumDate = Date()

        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        
        //ToolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.tfDOB.inputAccessoryView = toolBar
        self.tfDOB.inputView = datePicker
        
    }

      @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.tfDOB.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
}

extension SignUpViewController{
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
