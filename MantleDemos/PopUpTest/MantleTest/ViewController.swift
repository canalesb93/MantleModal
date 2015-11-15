//
//  ViewController.swift
//  MantleTest
//
//  Created by Ricardo Canales on 11/12/15.
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
        let mantleViewController = storyboard!.instantiateViewControllerWithIdentifier("MantleViewController") as! RCMantleViewController
        // Create your modal controller with your storyboard ID
        let popUpViewController = storyboard!.instantiateViewControllerWithIdentifier("PopUpViewController") as! PopUpViewController
        // Set it's delegate to be able to call 'delegate.dismissView(animated: Bool)'
        popUpViewController.delegate = mantleViewController
        
        // Configuration
        mantleViewController.bottomDismissible = true
        mantleViewController.topDismissable = true
        mantleViewController.draggableToSides = true
        mantleViewController.appearFromTop = true
        // appearOffset moves the popup closer to the edge so that it appears quicker
        mantleViewController.appearOffset = CGFloat(202)
        
        // Initialize Mantle
        mantleViewController.setUpScrollView()
        // Add your modal to Mantle
        mantleViewController.addToScrollViewNewController(popUpViewController)
        // Present the modal through the MantleViewController
        self.presentViewController(mantleViewController, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

