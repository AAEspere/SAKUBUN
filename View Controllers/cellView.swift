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
    var linesStored: [CAShapeLayer] = []
    var linesHolder: [[CAShapeLayer]] = []
    var lineCount = 0
    
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
        swiped = false
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        linesHolder.append(linesStored)
        linesStored = []
        lineCount += 1
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        linesStored.append(shapeLayer)
        self.layer.addSublayer(linesStored[linesStored.count-1])
        self.setNeedsDisplay()
    }
    
    @IBAction func undoButton(_ sender: Any) {
        undoLine()
    }
    
    func undoLine() {
        if(lineCount == 0) {
            return;
        }
        else {
            for i in linesHolder[lineCount-1] {
                i.removeFromSuperlayer()
            }
            lineCount -= 1
            linesHolder.removeLast()
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        clearAll()
    }
    
    func clearAll() {
        for shapeLayerArrays in linesHolder{
            for i in shapeLayerArrays {
                i.removeFromSuperlayer()
            }
        }
        linesStored = []
        linesHolder = []
        lineCount = 0
    }

}
