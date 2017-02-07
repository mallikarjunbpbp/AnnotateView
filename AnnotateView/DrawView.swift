//
//  DrawView.swift
//  AnnotateView
//
//  Created by Mallikarjun Patil on 2/4/17.
//  Copyright © 2017 Mallikarjun. All rights reserved.
//

import UIKit
import ColorSlider

class DrawView: UIView {
    var lastPoint = CGPoint.zero
    var swiped = false
    var selectedColor = UIColor.white
    
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var drawView: UIImageView!
    
    override func layoutSubviews() {
        let colorSlider = ColorSlider()
        colorSlider.frame = CGRect.init(x: 10, y: self.frame.size.height - 90, width: self.frame.size.width-20, height: 20)
        self.addSubview(colorSlider)
        colorSlider.orientation = .horizontal
        colorSlider.addTarget(self, action: #selector(self.changedColor(_:)), for: .valueChanged)

    }
    
    func changedColor(_ slider: ColorSlider) {
        selectedColor = slider.color
        selectedColorView.backgroundColor = selectedColor
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let image = drawView.image {
            UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil);
        }
    }
    @IBAction func clearButtonPressed(_ sender: Any) {
        drawView.image = UIImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint :CGPoint){
         UIGraphicsBeginImageContext(self.frame.size)
        drawView.image?.draw(in: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        //create a context
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(5)
        context?.setStrokeColor(selectedColor.cgColor)
        context?.setLineCap(CGLineCap.round)
        context?.setBlendMode(CGBlendMode.normal)
        
        //create a path
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        //draw the path
        context?.strokePath()
        drawView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
                let newPoint = touch.location(in: self)
                drawLines(fromPoint: lastPoint, toPoint: newPoint)
                lastPoint = newPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
}
