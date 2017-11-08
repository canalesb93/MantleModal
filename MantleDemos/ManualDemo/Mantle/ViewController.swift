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
        
        // Create the MantleViewController from the Storyboard using the ID
        let mantleViewController = storyboard!.instantiateViewController(withIdentifier: "MantleViewController") as! MantleViewController
        // Create your modal controller
        let popUpViewController = storyboard!.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        // Set it's delegate to be able to call 'delegate.dismissView(animated: Bool)'
        popUpViewController.delegate = mantleViewController
        // Initialize Mantle
        mantleViewController.appearFromTop = false
        mantleViewController.draggableToSides = false
        mantleViewController.bottomDismissible = false
        mantleViewController.topDismissable = true
        
        mantleViewController.setUpScrollView()
        mantleViewController.scrollView.bounces = false
        // Add your modal to Mantle
        mantleViewController.addToScrollViewNewController(controller: popUpViewController)
        // Present the modal through the MantleViewController
        
        self.present(mantleViewController, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

