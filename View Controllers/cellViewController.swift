//
//  cellViewController.swift
//  SAKUBUN
//
//  Created by Aaron Espere on 6/6/20.
//  Copyright © 2020 Aaron Espere. All rights reserved.
//

import UIKit

class cellViewController: UIView{

    //for strokes
    var lastStroke = CGPoint.zero
    var currentStroke = CGPoint.zero
    var linePath:UIBezierPath!
    
    var lineColor = UIColor.black
    var lineWidth: CGFloat = 10.0
    var lineOpacity: CGFloat = 1.0
    var swiped = false
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        lastStroke = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        currentStroke = touch.location(in: self)
        linePath = UIBezierPath()
        linePath.move(to:lastStroke)
        linePath.addLine(to:currentStroke)
        lastStroke = currentStroke
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }

}
