//
//  cellViewController.swift
//  SAKUBUN
//
//  Created by Aaron Espere on 6/6/20.
//  Copyright © 2020 Aaron Espere. All rights reserved.
//

import UIKit

class cellView: UIView{


    //for strokes
    var lastStroke = CGPoint.zero
    var currentStroke = CGPoint.zero
    var linePath:UIBezierPath!
    
    var lineColor = UIColor.black
    var lineWidth: CGFloat = 10.0
    var lineOpacity: CGFloat = 1.0
    var swiped = false
    
    //for undo function
    var shapeLayersStored: [CAShapeLayer] = []
    var shapeLayerCount = 0
    var lineStored: [UIBezierPath] = []
    var strokes: [CGPoint] = []
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        lineColor = UIColor.black
        lineWidth = 10.0
    }
    
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
        //setting current point
        lastStroke = currentStroke
        drawShapeLayer()
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayersStored.append(shapeLayer)
        self.layer.addSublayer(shapeLayersStored[shapeLayerCount])
        
        shapeLayerCount += 1
        
        self.setNeedsDisplay()
    }
    
    /*
    func removeShapeLayer() {
        self.layer.removeFromSuperlayer()
        self.setNeedsDisplay()
    }
 */
    
    @IBAction func undoButton(_ sender: Any) {
        undoLine()
    }
    
    
    func undoLine() {
        if(shapeLayerCount == 0) {
            return;
        }
        else { shapeLayersStored[shapeLayerCount-1].removeFromSuperlayer()
            shapeLayerCount -= 1
            shapeLayersStored.removeLast()
        }
    }
    
    func clearAll() {
        
    }

}
