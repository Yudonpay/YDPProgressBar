//
//  YDPProgressBar.swift
//  YDPProgressBar
//
//  Created by José Miguel Herrero on 11/02/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import UIKit

@IBDesignable
open class YDPProgressBar: UIView {
    private var innerProgress: CGFloat = 0.0
    private let shapeLayer = CAShapeLayer()
    private var  animated: Bool = false
    
    @IBInspectable
    var height: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var progressColor: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    open var progress: CGFloat {
        set (newProgress) {
            if newProgress > 1.0 {
                innerProgress = 1.0
            } else if newProgress < 0.0 {
                innerProgress = 0
            } else {
                innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        get {
            return innerProgress * bounds.width
        }
    }
    
    override open func draw(_ rect: CGRect) {
        self.shapeLayer.removeFromSuperlayer()
        
        //// Container for the progress bar
        let containerRect = CGRect(x: bounds.minX + 1,
                                   y: bounds.minY + 1,
                                   width: floor((frame.width - 1) * 0.99652 + 0.5),
                                   height: height)
        let container = UIBezierPath(roundedRect:containerRect, cornerRadius: height / 2)
        borderColor.setStroke()
        container.lineWidth = 1
        container.stroke()
        container.addClip()
        
        var newProgress = progress - 4
        
        if progress == 0 {
            newProgress = 0
        }
        
        //// Progress Active Drawing
        let heightProgress = height - 2
        let startRect = CGRect(x: container.bounds.minX + 1,
                               y: container.bounds.minY + 1,
                               width: 12,
                               height: heightProgress)
        let endRect = CGRect(x: container.bounds.minX + 1,
                             y: container.bounds.minY + 1,
                             width: newProgress,
                             height: heightProgress)
        if animated {
            let startProgress = UIBezierPath(roundedRect: startRect,
                                             cornerRadius: heightProgress / 2)
            let endProgress = UIBezierPath(roundedRect: endRect,
                                           cornerRadius: heightProgress / 2)
            
            if progress > 0 {
                shapeLayer.path = startProgress.cgPath
                shapeLayer.fillColor = progressColor.cgColor
                shapeLayer.strokeColor = UIColor.clear.cgColor
                self.layer.addSublayer(shapeLayer)
                
                self.layoutIfNeeded()
                
                let animation = CABasicAnimation()
                animation.keyPath = "path"
                animation.duration = CFTimeInterval(progress / bounds.width)
                animation.fromValue = startProgress.cgPath
                animation.toValue = endProgress.cgPath
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.isRemovedOnCompletion = false
                shapeLayer.add(animation, forKey: "animationFill")
            }
            
        } else {
            let endProgress = UIBezierPath(roundedRect: endRect,
                                           cornerRadius: heightProgress / 2)
            progressColor.setFill()
            endProgress.fill()
            
        }
    }
    
    open func progress(_ progress: CGFloat, animated: Bool) {
        self.animated = animated
        self.progress = progress
    }
}

