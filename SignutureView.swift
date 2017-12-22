//
//  SignutureView.swift
//  TestSignature2
//
//  Created by LEONID NIFANTIJEV on 12/22/17.
//  Copyright © 2017 LEONID NIFANTIJEV. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class SignutureView: UIView {

    
    var path: UIBezierPath?
    var previousPoint: CGPoint = CGPoint.zero
    var image: UIImage? {
        return path?.shapeImage(view: self)
    }
    
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path?.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        
        
        
        path = UIBezierPath()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panno))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        
        
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(erase)))
        
    }
    
    @objc func panno(pan: UIPanGestureRecognizer) {
        let currentPoint: CGPoint = pan.location(in: self)
        let midPoint: CGPoint = midpoint(p0: previousPoint, p1: currentPoint)
        
        path?.lineWidth = 2
        if pan.state == .began {
            path?.move(to: currentPoint)
        } else if pan.state == .changed {
            path?.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        }
        
        previousPoint = currentPoint
        
        
        
        self.setNeedsDisplay()
        
    }
    
    @objc func erase() {
        path = UIBezierPath()
        self.setNeedsDisplay()
        
        
    }
    
    



}


func midpoint(p0: CGPoint, p1: CGPoint) -> CGPoint {
    return CGPoint(x: (p0.x + p1.x) / 2.0, y: (p0.y + p1.y) / 2.0)
}


extension UIBezierPath {
    func shapeImage(view: UIView) -> UIImage! {
        
        // begin graphics context for drawing
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        
        // configure the view to render in the graphics context
        //view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // get reference to the graphics context
        let context = UIGraphicsGetCurrentContext()
        
        // translate matrix so that path will be centered in bounds
        context?.translateBy(x: -(bounds.origin.x - self.lineWidth), y: -(bounds.origin.y - self.lineWidth))
        // set color
        UIColor.black.setStroke()
        
        // draw the stroke
        stroke()
        
        // get an image of the graphics context
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // end the context
        UIGraphicsEndImageContext()
        
        return image
    }
        
        
    
    
    
    
}



