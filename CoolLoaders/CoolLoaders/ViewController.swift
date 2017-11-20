//
//  ViewController.swift
//  CoolLoaders
//
//  Created by Devin Eror on 11/19/17.
//  Copyright © 2017 Devin Eror. All rights reserved.
//

/*******************************
 
 Using Ben Dietzkis's example from Medium
 https://medium.com/@topLayoutGuide/ui-sugar-spirals-1b515a258944
 
 ******************************/

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class spinnerFibonacci: UIView {
    
    var colors = [
        UIColor(0xee1c27),UIColor(0xbc0271),UIColor(0x612d92),
        UIColor(0x283897),UIColor(0x016db8),UIColor(0x02a2b8),
        UIColor(0x00a666),UIColor(0xa7d04e),UIColor(0xfef200),
        UIColor(0xfeaf16),UIColor(0xf58020),UIColor(0xf35724)
    ]
    
    fileprivate var startIndex = 3
}

extension UIColor {
    
    convenience init(_ hex6: UInt32) {
        let divisor = CGFloat(255)
        
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat((hex6 & 0x0000FF) >> 0) / divisor
        
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }
}
