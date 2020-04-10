//
//  ViewController.swift
//  OnBoarding
//
//  Created by Faraz Haider on 10/04/2020.
//  Copyright © 2020 Etisalat. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    @IBOutlet weak var scrollview: UIScrollView!{
        didSet{
            scrollview.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    var slides:[ContentSlide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

    
    func createSlides() -> [ContentSlide] {

        
        let slide1:ContentSlide = Bundle.main.loadNibNamed("ContentSlide", owner: self, options: nil)?.first as! ContentSlide
        slide1.imageView.image = UIImage(named: "1")
        slide1.titleLabel.text = "STEP 1"
        slide1.subtitleLabel.text = "REGISTER YOUR DETAILS"
        slide1.descriptionLabel.text = "Register yourself and your family members details so that we can know more about you."
        slide1.skipButton.isHidden = false
        slide1.nextButton.setTitle("NEXT", for: .normal)
        slide1.skipButton.setTitle("SKIP", for: .normal)
        
        
        let slide2:ContentSlide = Bundle.main.loadNibNamed("ContentSlide", owner: self, options: nil)?.first as! ContentSlide
        slide2.imageView.image = UIImage(named: "1")
        slide2.titleLabel.text = "STEP 2"
        slide2.subtitleLabel.text = "COMPLETE A QUICK SELF-ASSESSMENT"
        slide2.descriptionLabel.text = "Answer some questions to find out your risk-level for COVID-19 and what you can do to get help."
        slide2.skipButton.isHidden = false
        slide2.nextButton.setTitle("NEXT", for: .normal)
        slide2.skipButton.setTitle("SKIP", for: .normal)
        
        let slide3:ContentSlide = Bundle.main.loadNibNamed("ContentSlide", owner: self, options: nil)?.first as! ContentSlide
        slide3.imageView.image = UIImage(named: "1")
        slide3.titleLabel.text = "STEP 3"
        slide3.subtitleLabel.text = "KEEP YOURSELF AND YOUR COMMUNITY SAFE"
        slide3.descriptionLabel.text = "Get advice, receive COVID-19 alerts and updates, and do your part to help keep everyone safe."
        slide3.skipButton.isHidden = true
        slide3.nextButton.setTitle("START", for: .normal)
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [ContentSlide]) {
           scrollview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
           scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
           scrollview.isPagingEnabled = true
           
           for i in 0 ..< slides.count {
               slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
               scrollview.addSubview(slides[i])
           }
       }

}

extension OnBoardingViewController:UIScrollViewDelegate{
     /*
      * default function called when view is scolled. In order to enable callback
      * when scrollview is scrolled, the below code needs to be called:
      * slideScrollView.delegate = self or
      */
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
         pageControl.currentPage = Int(pageIndex)
         
         let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
         let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
         
         // vertical
         let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
         let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
         
         let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
         let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
         
         
         /*
          * below code changes the background color of view on paging the scrollview
          */
 //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
         
     
         /*
          * below code scales the imageview on paging the scrollview
          */
         let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
         
        if(percentOffset.x > 0 && percentOffset.x <= 0.50) {
             slides[0].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.50, y: (0.50-percentOffset.x)/0.50)
             slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
             
         } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
             slides[1].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
             slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
         }
     }
}

