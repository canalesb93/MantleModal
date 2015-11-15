//
//  ModalViewController.swift
//  BottomMenuDemo
//
//  Created by Ricardo Canales on 11/14/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MantleModal

class ModalViewController: UIViewController {

    var delegate: RCMantleViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "tapDismiss:")
        self.view.addGestureRecognizer(tap)
    
        // Do any additional setup after loading the view.
    }
    
    func tapDismiss(sender:UITapGestureRecognizer){
        delegate.dismissView(true)
    }

    @IBAction func closeMenu(sender: AnyObject) {
        delegate.dismissView(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
