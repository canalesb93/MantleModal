//
//  ViewController.swift
//  BottomMenuDemo
//
//  Created by Ricardo Canales on 11/14/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MantleModal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func presentModal(sender: AnyObject) {
        // Create the MantleViewController from the Storyboard using the
        let mantleViewController = storyboard!.instantiateViewController(withIdentifier: "MantleViewController") as! RCMantleViewController
        // Create your modal controller with your storyboard ID
        let modalViewController = storyboard!.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        // Set it's delegate to be able to call 'delegate.dismissView(animated: Bool)'
         modalViewController.delegate = mantleViewController
        
        // Configuration
        mantleViewController.bottomDismissible = true
        mantleViewController.topDismissable = false
        mantleViewController.draggableToSides = false
        mantleViewController.appearFromTop = true
        // appearOffset moves the menu closer to the edge so that it appears quicker
        mantleViewController.appearOffset = CGFloat(270)
        // In this case 290 is the distance between the top of the menu and the top of the screen 
        
        // Initialize Mantle
        mantleViewController.setUpScrollView()
        // Disable scrollview bounce so the menu can't be pulled up.
        mantleViewController.scrollView.bounces = false
        
        // Add your modal to Mantle
        mantleViewController.addToScrollViewNewController(modalViewController)
        // Present the modal through the MantleViewController
        self.present(mantleViewController, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

