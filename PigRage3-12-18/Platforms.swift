//
//  Platforms.swift
//  PigRage3-12-18
//
//  Created by Emily on 4/9/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import SpriteKit

class Platforms: SKNode, SKPhysicsContactDelegate{
    
    var image = SKSpriteNode()
    
    override init(){
        super.init()
    }

    func createPlatform(image: SKSpriteNode, platformType: PlatformType, xPos: Int, yPos: Int){
        switch(platformType){
        case .HAY1:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize( width: 384, height: 384)
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.pigSignCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        case .HAY2:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize( width: 812, height: 512)
            break
        case .DECK:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize( width: 620, height: 624)
            break
        case .VERTICAL:
            break
        case .HORIZONTAL:
            break
        }
        self.addChild(image)
        image.zPosition = 1
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

}
