//
//  ViewController.swift
//  Mantle
//
//  Created by Ricardo Canales on 11/11/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func presentModal(sender: AnyObject) {
        let mantleViewController = storyboard!.instantiateViewControllerWithIdentifier("MantleViewController") as! RCMantleViewController
        
        // Adding all the controllers you want in the scrollView
        let popUpViewController = storyboard!.instantiateViewControllerWithIdentifier("PopUpViewController") as! RCPopUpViewController
        popUpViewController.delegate = mantleViewController
        mantleViewController.setUpScrollView()
        mantleViewController.addToScrollViewNewController(popUpViewController)
        self.presentViewController(mantleViewController, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

