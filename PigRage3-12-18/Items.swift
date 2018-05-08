//
//  Items.swift
//  PigRage3-12-18
//
//  Created by Emily on 4/3/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class Items: SKNode{

    
    var image = SKSpriteNode()
    var x = 0
    
    //Piglet Sign
    var pigSign = SKSpriteNode()
    var pigletSign = [SKTexture]()
    var sign1 = "PigletSign01"
    var sign2 = "PigletSign02"
    
    
    //Piglets
    var piglet = SKSpriteNode()
    var animPiglet = [SKTexture]()
    var piglet01 = "Piglet01"
    var piglet02 = "Piglet02"
    var piglet03 = "Piglet03"
    var piglet04 = "Piglet04"
    
    var piglet1 = SKSpriteNode()
    var piglet2 = SKSpriteNode()
    var piglet3 = SKSpriteNode()
    var piglet4 = SKSpriteNode()
    var piglet5 = SKSpriteNode()
    
    var pigletArray = [SKSpriteNode]()
    //Balloon
    var balloon = SKSpriteNode(imageNamed: "balloon")
    
    //Toxic Barrel
    var toxicBarrel = [SKTexture]()
    var toxic1 = "ToxicBarrel_01"
    var toxic2 = "ToxicBarrel_02"
    var toxic3 = "ToxicBarrel_03"
    
    override init() {
        super.init()
        initAnimation()
        initAmmoArray()
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    func createItem(image: SKSpriteNode, type: ItemType, xPos: Int, yPos: Int){
        switch(type){
        case .PIGSIGN:
            image.size = CGSize( width: 212, height: 320)
            image.physicsBody = SKPhysicsBody(circleOfRadius: 80)
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.pigSignCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            image.run(SKAction.repeatForever(SKAction.animate(with: pigletSign, timePerFrame: 0.2)))
            break
        case .PIGLET:
//            image.size = CGSize( width: 70, height: 159)
//            image.physicsBody = SKPhysicsBody(circleOfRadius: 80)
//            image.zPosition = 3
//            image.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 70, height: 100))
//            image.physicsBody?.isDynamic = true
//            image.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory1
//            image.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
//            image.physicsBody?.collisionBitMask = PhysicsCategory.none
//            image.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
            break
        case .TOXIC:
            image.size = CGSize( width: 212, height: 320)
            image.physicsBody = SKPhysicsBody(circleOfRadius: 80)
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.powerUpCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            image.run(SKAction.repeatForever(SKAction.animate(with: toxicBarrel, timePerFrame: 0.2)))
            break
        case .BALLOON:
            image.size = CGSize(width: 400, height: 800)
            break
        }
        image.zPosition = 2
        image.position = CGPoint(x: xPos, y: yPos)
        self.addChild(image)
    }
    
    func initAmmoArray(){
        piglet1 = SKSpriteNode(imageNamed: "Piglet01")
        piglet1.name = "piglet1"
        piglet1.zPosition = 1
        piglet1.size = CGSize( width: 100, height: 200)
        piglet1.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        piglet1.physicsBody?.isDynamic = true
        piglet1.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory1
        piglet1.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
        piglet1.physicsBody?.collisionBitMask = PhysicsCategory.none
    
        piglet2 = SKSpriteNode(imageNamed: "Piglet01")
        piglet2.name = "piglet2"
        piglet2.zPosition = 1
        piglet2.size = CGSize( width: 100, height: 200)
        piglet2.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        piglet2.physicsBody?.isDynamic = true
        piglet2.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory2
        piglet2.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
        piglet2.physicsBody?.collisionBitMask = PhysicsCategory.none
    
    
        piglet3 = SKSpriteNode(imageNamed: "Piglet01")
        piglet3.name = "piglet3"
        piglet3.zPosition = 1
        piglet3.size = CGSize( width: 100, height: 200)
        piglet3.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        piglet3.physicsBody?.isDynamic = true
        piglet3.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory3
        piglet3.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
        piglet3.physicsBody?.collisionBitMask = PhysicsCategory.none
    
    
        piglet4 = SKSpriteNode(imageNamed: "Piglet01")
        piglet4.name = "piglet4"
        piglet4.zPosition = 1
        piglet4.size = CGSize( width: 100, height: 200)
        piglet4.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        piglet4.physicsBody?.isDynamic = true
        piglet4.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory4
        piglet4.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
        piglet4.physicsBody?.collisionBitMask = PhysicsCategory.none
    
        piglet5 = SKSpriteNode(imageNamed: "Piglet01")
        piglet5.name = "piglet5"
        piglet5.zPosition = 1
        piglet5.size = CGSize( width: 100, height: 200)
        piglet5.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        piglet5.physicsBody?.isDynamic = true
        piglet5.physicsBody?.categoryBitMask = PhysicsCategory.pigAmmoCategory5
        piglet5.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.chickenCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory
        piglet5.physicsBody?.collisionBitMask = PhysicsCategory.none
    
        pigletArray.append(piglet1)
        pigletArray.append(piglet2)
        pigletArray.append(piglet3)
        pigletArray.append(piglet4)
        pigletArray.append(piglet5)
        
        piglet1.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
        piglet2.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
        piglet3.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
        piglet4.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
        piglet5.run(SKAction.repeatForever(SKAction.animate(with: animPiglet, timePerFrame: 0.2)))
    }
    
    func initAnimation(){
        pigletSign.append(SKTexture(imageNamed: sign1))
        pigletSign.append(SKTexture(imageNamed: sign2))
        
        toxicBarrel.append(SKTexture(imageNamed: toxic1))
        toxicBarrel.append(SKTexture(imageNamed: toxic2))
        toxicBarrel.append(SKTexture(imageNamed: toxic3))
        
        animPiglet.append(SKTexture(imageNamed: piglet01))
        animPiglet.append(SKTexture(imageNamed: piglet02))
        animPiglet.append(SKTexture(imageNamed: piglet03))
        animPiglet.append(SKTexture(imageNamed: piglet04))
        
    }

  
}

