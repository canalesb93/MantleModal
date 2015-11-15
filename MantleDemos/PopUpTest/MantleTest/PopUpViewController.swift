//
//  PopUpViewController.swift
//  MantleTest
//
//  Created by Ricardo Canales on 11/14/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MantleModal

class PopUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var delegate: RCMantleViewDelegate!

    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "tapDismiss:")
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func tapDismiss(sender:UITapGestureRecognizer){
        delegate.dismissView(true)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view == popUpView {
            return false
        }
        return true
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
