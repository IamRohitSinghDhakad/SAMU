//
//  WelcomeViewController.swift
//  SAMU
//
//  Created by Rohit Singh Dhakad on 23/09/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var cvWelcome: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var arrBannerImages : [UIImage] = [UIImage]()
    var arrBannerTitle : [String] = [String]()
    var arrBannerDescription : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cvWelcome.delegate = self
        self.cvWelcome.dataSource = self
        
        self.arrBannerImages = [
            UIImage(named: "welcome_two")!,
            UIImage(named: "welcome_one")!,
            UIImage(named: "welcome_three")!
        ]
        
        self.arrBannerTitle = ["Choose Your Service", "Connect With Your Provider", "Enjoy Your SAMU Service"]
        
        pageController.numberOfPages = self.arrBannerImages.count
        pageController.currentPage = 0
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSkip(_ sender: UIButton) {
        self.pushVc(viewConterlerId: "ViewController")
    }
    @IBAction func btnNext(_ sender: UIButton) {
        if self.btnNext.currentTitle == "NEXT"{
            scrollToNextCell()
        }else{
            self.pushVc(viewConterlerId: "ViewController")
        }
    }
    
    
    func scrollToNextCell(){
         //get cell size
        let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height);

         //get current content Offset of the Collection view
        let contentOffset = self.cvWelcome.contentOffset;

         //scroll to next cell
        self.cvWelcome.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);


     }
    
}


extension WelcomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrBannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath)as? WelcomeCollectionViewCell{
            let index = indexPath.row
            cell.imgVwWelcome.image = self.arrBannerImages[index]
            cell.lblTitle.text = self.arrBannerTitle[index]
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0,1:
            self.btnNext.setTitle("NEXT", for: .normal)
            self.btnSkip.isHidden = false
        case 2:
            self.btnNext.setTitle("START", for: .normal)
            self.btnSkip.isHidden = true
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = self.cvWelcome.contentOffset
        visibleRect.size = self.cvWelcome.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = self.cvWelcome.indexPathForItem(at: visiblePoint) else { return }
        
        self.pageController.currentPage = indexPath.row
    }
}

extension WelcomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = cvWelcome.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
