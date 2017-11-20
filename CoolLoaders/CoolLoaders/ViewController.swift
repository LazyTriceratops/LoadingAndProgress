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

import Foundation
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayView = SpinnerFibonacci(frame: CGRect(x: (self.view.frame.size.width * 0.5) - 50, y: (self.view.frame.size.height * 0.5) - 50, width: 100, height: 100))
        
        displayView.startAnimating()
        
        self.view.addSubview(displayView)
    }
}

class SpinnerFibonacci: UIView {
    
    var colors = [
        UIColor(0xee1c27),UIColor(0xbc0271),UIColor(0x612d92),
        UIColor(0x283897),UIColor(0x016db8),UIColor(0x02a2b8),
        UIColor(0x00a666),UIColor(0xa7d04e),UIColor(0xfef200),
        UIColor(0xfeaf16),UIColor(0xf58020),UIColor(0xf35724)
    ]
    
    fileprivate var startIndex = 3
    
    var isCircular = true
    var numberOfBalls = 12
    var speed:Double = 0.5
    
    fileprivate var timeStep:Int = 0
    fileprivate var radius:CGFloat = 0
    fileprivate var displayLink:CADisplayLink?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        radius = min(frame.width, frame.height) / 3
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        
        displayLink = UIScreen.main.displayLink(withTarget: self, selector: #selector(SpinnerFibonacci.animateBalls))
        displayLink?.add(to: .current, forMode: .defaultRunLoopMode)
    }
    
    func stopAnimating() {
        
        displayLink?.invalidate()
        timeStep = 0
    }
    
    func clear() {
        
        layer.sublayers?.removeAll()
    }
    
    func drawBall(_ x:CGFloat,_ y:CGFloat,_ color:UIColor) {
        
        let dot = CAShapeLayer()
            dot.path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: 5, height: 5)).cgPath
            dot.fillColor = color.cgColor
            dot.strokeColor = UIColor.clear.cgColor
            dot.lineWidth = 0
        
        layer.addSublayer(dot)
    }
    
    @objc func animateBalls() {
        
        clear()
        
        for i in startIndex..<numberOfBalls + startIndex {
            
            drawBall(getX(i:i, timeStamp:timeStep), getY(i:i, timeStep:timeStep), colors[i-startIndex])
        }
        
        timeStep += 1
    }
    
    func getR(i: Int) -> CGFloat {
        
        return CGFloat((CGFloat(1 + i) / CGFloat(numberOfBalls)) * radius)
    }
    
    func getT(i: Int, timeStep: Int) -> Double {
        
        return Double(timeStep) * (Double(i) / 100 * speed + 0.005)
    }
    
    func getX(i: Int, timeStamp: Int) -> CGFloat {
    
        return (frame.width / 2) + CGFloat(getR(i: i)) * cos(CGFloat(getT(i: i, timeStep: timeStep)))
    }
    
    func getY(i: Int, timeStep: Int) -> CGFloat {
        
        if isCircular {
            return (frame.height / 2) + CGFloat(getR(i: i)) * sin(CGFloat(getT(i: i, timeStep: timeStep)))
        } else {
            return frame.height / 2
        }
    }
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
