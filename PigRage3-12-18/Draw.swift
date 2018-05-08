//
//  Draw.swift
//  PigRage3-12-18
//
//  Created by Emily on 4/23/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit

class Draw: SKNode{
    
    override func draw(_ rect: CGRect){
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4.0)
        context?.setStrokeColor(UIColor.blue.cgColor)
        let rectangle = CGRect(x: 60,y: 170,width: 200,height: 80)
        context?.addRect(rectangle)
        context?.strokePath()
        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(rectangle)
    }
}
