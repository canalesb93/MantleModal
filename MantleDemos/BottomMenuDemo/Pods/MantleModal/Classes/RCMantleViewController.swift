//
//  RCMantleViewController.swift
//  Mantle
//
//  Created by Ricardo Canales on 11/11/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit


// Declare this protocol outside the class
public protocol RCMantleViewDelegate {
    // This method allows a child to tell the parent view controller
    // to change to a different child view
    func dismissView(animated: Bool)
}

public class RCMantleViewController: UIViewController, RCMantleViewDelegate, UIScrollViewDelegate {
    
    public var scrollView: UIScrollView!
    private var contentView: UIView!
    
    // A strong reference to the height contraint of the contentView
    var contentViewConstraint: NSLayoutConstraint!
    
    // ==================== CONFIGURATION VARIABLES - START ====================
    
    // draggable to the top/bottom
    public var bottomDismissible: Bool = false
    public var topDismissable: Bool = true
    
    private var mainView: Int = 1
    
    // show modal from the top
    public var appearFromTop: Bool = false
    public var appearOffset: CGFloat = 0
    
    // draggable to sides configuration variables
    public var draggableToSides: Bool = false
    private var draggableWidth: CGFloat = 0
    private var draggableMultiplier: CGFloat = 1.0
    
    private var glassScreens: Int = 1 // 1 + 1
    
    // ===================== CONFIGURATION VARIABLES - END =====================
    
    // A computed version of this reference
    var computedContentViewConstraint: NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: CGFloat(controllers.count + glassScreens + 1), constant: 0)
        return constraint
    }
    
    // The list of controllers currently present in the scrollView
    var controllers = [UIViewController]()
    
    // setup initialization
    public func setUpScrollView(){
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        glassScreens = 1
        if bottomDismissible && topDismissable {
            glassScreens = 2 // 2 + 1
            mainView = 1
        } else if topDismissable {
            mainView = 1
        } else if bottomDismissible {
            mainView = 0
        }  else {
            glassScreens = 0
            mainView = 0
        }
        
        if draggableToSides {
            draggableWidth = view.frame.width
            draggableMultiplier = CGFloat(3.0)
        }
        
        createMantleViewController()
        initScrollView()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Creates the ScrollView and the ContentView (UIView), don't move
    private func createMantleViewController() {
        view.backgroundColor = UIColor.clearColor()
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clearColor()
        view.addSubview(scrollView)
        
        let top = NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let leading = NSLayoutConstraint(item: scrollView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: scrollView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.clearColor()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let ctop = NSLayoutConstraint(item: contentView, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0)
        let cbottom = NSLayoutConstraint(item: contentView, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let cleading = NSLayoutConstraint(item: contentView, attribute: .Leading, relatedBy: .Equal, toItem: scrollView, attribute: .Leading, multiplier: 1.0, constant: 0)
        let ctrailing = NSLayoutConstraint(item: contentView, attribute: .Trailing, relatedBy: .Equal, toItem: scrollView, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let cwidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: draggableMultiplier, constant: 0)
        
        NSLayoutConstraint.activateConstraints([top, bottom, leading, trailing, ctop, cbottom, cleading, ctrailing, cwidth])
    }
    
    func initScrollView(){
        scrollView.hidden = true
        scrollView.scrollEnabled = false
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentViewConstraint = computedContentViewConstraint
        view.addConstraint(contentViewConstraint)
        
    }
    
    override public func viewDidAppear(animated: Bool) {
        accomodateScrollView()
        scrollView.hidden = false
        moveToView(mainView)
    }
    
    private func accomodateScrollView(){
        var xPos: CGFloat = 0
        var yPos: CGFloat = appearOffset
        if draggableToSides {
            xPos = self.view.frame.width
        }
        if appearFromTop {
            yPos = self.contentView.frame.height - self.view.frame.height - appearOffset
        }
        scrollView.setContentOffset(CGPointMake(xPos, yPos), animated: false)
    }
    
    public func addToScrollViewNewController(controller: UIViewController) {
        controller.willMoveToParentViewController(self)
        
        contentView.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = NSLayoutConstraint(item: controller.view, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1.0, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: contentView, attribute: .Leading, relatedBy: .Equal, toItem: controller.view, attribute: .Leading, multiplier: 1.0, constant: -draggableWidth)
        let trailingConstraint = NSLayoutConstraint(item: contentView, attribute: .Trailing, relatedBy: .Equal, toItem: controller.view, attribute: .Trailing, multiplier: 1.0, constant: draggableWidth)
        
        // Setting all the constraints
        
        var bottomConstraint: NSLayoutConstraint!
        if controllers.isEmpty {
            // Since it's the first one, the trailing constraint is from the controller view to the contentView
            bottomConstraint = NSLayoutConstraint(item: contentView, attribute: .Bottom, relatedBy: .Equal, toItem: controller.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        }
        else {
            bottomConstraint = NSLayoutConstraint(item: controllers.last!.view, attribute: .Top, relatedBy: .Equal, toItem: controller.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        }
        
        if bottomDismissible {
            bottomConstraint.constant = controller.view.frame.height
        }
        
        // Setting the new width constraint of the contentView
        view.removeConstraint(contentViewConstraint)
        contentViewConstraint = computedContentViewConstraint
        
        // Adding all the constraints to the view hierarchy
        view.addConstraint(contentViewConstraint)
        contentView.addConstraints([bottomConstraint, trailingConstraint, leadingConstraint])
        scrollView.addConstraints([heightConstraint])
        
        self.addChildViewController(controller)
        controller.didMoveToParentViewController(self)
        
        // Finally adding the controller in the list of controllers
        controllers.append(controller)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if(scrollView.contentOffset.y < view.frame.height-20){
            scrollView.scrollEnabled = false
        } else if scrollView.contentOffset.y > scrollView.frame.height - view.frame.height + 20 {
            scrollView.scrollEnabled = false
        }
    }
    
    // close view or not
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentHorizontalPage = floor(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5);
        let currentPage = floor(scrollView.contentOffset.y / scrollView.bounds.size.height + 0.5);
        // let lastPage = floor(contentView.frame.height / scrollView.bounds.size.height - 1);
        
        if(draggableToSides && (currentHorizontalPage == 0 || currentHorizontalPage == 2)){
            dismissView(false)
        }
        
        if(Int(currentPage) != mainView){
            dismissView(false)
        } else {
            scrollView.scrollEnabled = true
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.y / scrollView.bounds.size.height + 0.5);
        if currentPage != CGFloat(mainView) {
            dismissView(false)
        } else {
            scrollView.scrollEnabled = true
        }
    }
    
    private func moveToView(viewNum: Int) {
        // Determine the offset in the scroll view we need to move to
        scrollView.scrollEnabled = false
        let yPos: CGFloat = (self.view.frame.height) * CGFloat(viewNum)
        self.scrollView.setContentOffset(CGPointMake(self.scrollView.contentOffset.x ,yPos), animated: true)
    }
    
    public func dismissView(animated: Bool){
        if appearFromTop && animated {
            moveToView(mainView + 1)
            //self.dismissViewControllerAnimated(false, completion: nil)
        } else {
            self.dismissViewControllerAnimated(animated, completion: nil)
        }
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
