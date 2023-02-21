//
//  BaseViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 11/10/22.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var lblGalleryActive: UILabel!
    @IBOutlet var lblReviewsActive: UILabel!
    @IBOutlet var lblAboutActive: UILabel!
    @IBOutlet var lblGalleryText: UILabel!
    @IBOutlet var lblReviewsText: UILabel!
    @IBOutlet var lblAboutText: UILabel!
    
    var currentPage = 0
    
    private var subControllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadInitialData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.setupScrollView()
            self.findPageNumber()
        }
    }

    @IBAction func btnBackOnHeader(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnGallery(_ sender: Any) {
        self.displayDataForGalleryTab()
    }
    @IBAction func btnOnReviews(_ sender: Any) {
        self.displayDataForReviewTab()
    }
    
    @IBAction func btnOnAbout(_ sender: Any) {
        self.displayDataForAboutTab()
    }
}


extension BaseViewController: UIScrollViewDelegate{
    
    func loadInitialData(){
        self.scrollView.delegate = self
        self.initChildControllers()
        self.setInactiveToAll()
        self.displayDataForGalleryTab()
    }
    
    func setInactiveToAll(){
        self.lblGalleryActive.backgroundColor = .clear
        self.lblReviewsActive.backgroundColor = .clear
        self.lblAboutActive.backgroundColor = .clear
        
        self.lblGalleryText.textColor = .black
        self.lblReviewsText.textColor = .black
        self.lblAboutText.textColor = .black
    }
    

    func displayDataForGalleryTab(){
        self.move(toPage: 0)
        self.setInactiveToAll()
        
        self.lblGalleryText.textColor = UIColor.blue
        self.lblGalleryActive.backgroundColor = UIColor.blue
      
    }

    func displayDataForReviewTab(){
        self.move(toPage: 1)
        self.setInactiveToAll()
        
        self.lblReviewsText.textColor = UIColor.blue
        self.lblReviewsActive.backgroundColor = UIColor.blue

    }
    
    func displayDataForAboutTab(){
        self.move(toPage: 2)
        self.setInactiveToAll()
        
        self.lblAboutText.textColor = UIColor.blue
        self.lblAboutActive.backgroundColor = UIColor.blue
    }
}

//MARK:- extension for paging management
extension BaseViewController{
    func initChildControllers()  {

        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)

        let objGalleryVC = sb.instantiateViewController(withIdentifier: "ViewControllerOne") as! ViewControllerOne
        let objReviewVC  = sb.instantiateViewController(withIdentifier: "ViewControllerTwo") as! ViewControllerTwo
        let objAboutVC  = sb.instantiateViewController(withIdentifier: "ViewControllerThree") as! ViewControllerThree

        self.addChild(objGalleryVC)
        self.addChild(objReviewVC)
        self.addChild(objAboutVC)

        self.scrollView.addSubview(objGalleryVC.view)
        self.scrollView.addSubview(objReviewVC.view)
        self.scrollView.addSubview(objAboutVC.view)
        self.scrollView.delegate =  self
        objGalleryVC.didMove(toParent: self)
        objReviewVC.didMove(toParent: self)
        objAboutVC.didMove(toParent: self)
    }

    func setupScrollView()  {
        self.currentPage = 0
        for (index, _) in self.children.enumerated() {
            self.loadScrollView(withPage: index)
        }
        let w = self.view.frame.width * CGFloat(self.children.count)
        self.scrollView.contentSize = CGSize(width: w, height: self.scrollView.frame.height)
    }

    func loadScrollView(withPage page: Int) {
        if page < 0 {return}
        if page >= children.count {return}
        // replace the placeholder if necessary
        let controller: UIViewController = children[page]
        var frame: CGRect = view.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        frame.size.height = self.scrollView.frame.height
        controller.view.frame = frame
        self.scrollView.addSubview(controller.view)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.findPageNumber()
    }

    func findPageNumber() {
        let pageWidth = scrollView.frame.size.width
        var xOffset: CGFloat = 0.0

        xOffset = scrollView.contentOffset.x

        let w: CGFloat = xOffset - pageWidth / 2
        let page = Int(floor(w / pageWidth) + 1)

        if self.currentPage != page {

            let oldViewController: UIViewController = children[self.currentPage]
            let newViewController: UIViewController = children[page]
            oldViewController.viewWillDisappear(true)
            newViewController.viewWillAppear(true)
            self.currentPage = page

            //segmentControl.selectedSegmentIndex = page
            //print("Page changed: \(page)")
            oldViewController.viewDidDisappear(true)
            newViewController.viewDidAppear(true)
        }

        if page == 0{
            self.setInactiveToAll()
            self.displayDataForGalleryTab()
        }else if page == 1{
            self.setInactiveToAll()
            self.displayDataForReviewTab()
        }else{
            self.setInactiveToAll()
            self.displayDataForAboutTab()
        }
    }

    func move(toPage page: Int) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        let oldViewController: UIViewController = children[self.currentPage]
        let newViewController: UIViewController = children[page]
        oldViewController.viewWillDisappear(true)
        newViewController.viewWillAppear(true)
        scrollView.scrollRectToVisible(frame, animated: true)
    }
}

extension UIViewController {
    static func createFromNib<T: UIViewController>(storyBoardId: String) -> T?{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyBoardId) as? T
    }
}
