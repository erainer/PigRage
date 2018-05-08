//
//  Sprite.swift
//  PigRage3-12-18
//
//  Created by Emily on 3/13/18.
//  Copyright © 2018 Emily. All rights reserved.
//
import Foundation
import SpriteKit

class Enemies: SKNode{
    
    var image = SKSpriteNode()
    var health: Int = 100
    var damage: Int = 10
    var x = 0
    let sprites = Sprites()

    override init(){
        super.init()
    }
    
    func createEnemy(image: SKSpriteNode, type: EnemyType, xPos: Int, yPos: Int){
        switch(type){
        case .CHICKEN:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize(width: 234, height: 250)
            image.physicsBody = SKPhysicsBody(circleOfRadius: 100)
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.chickenCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        case .FOX:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize(width: 876, height: 250)
            image.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 876, height: 250))
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.foxCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        case .FARMER:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize(width: 417, height: 472)
            image.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 317, height: 472))
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.farmerCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        case .DOG:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize(width: 356, height: 268)
            image.physicsBody = SKPhysicsBody(circleOfRadius: 100)
            image.physicsBody?.isDynamic = true
            image.physicsBody?.categoryBitMask = PhysicsCategory.dogCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        case .MOLE:
            image.position = CGPoint(x: xPos, y: yPos)
            image.size = CGSize(width: 296, height: 280)
            image.physicsBody?.isDynamic = true
            image.physicsBody = SKPhysicsBody(circleOfRadius: 100)
            image.physicsBody?.categoryBitMask = PhysicsCategory.moleCategory
            image.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
            image.physicsBody?.collisionBitMask = PhysicsCategory.none
            break
        }
        image.zPosition = 1
        animEnemies(image: image, type: type)
        self.addChild(image)
    }
    
    func animEnemies(image: SKSpriteNode, type: EnemyType){
        switch(type){
        case .FOX:
             image.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFox, timePerFrame: 0.2)))
            break
        case .CHICKEN:
            image.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenJump, timePerFrame: 0.2)))
            break
        case .FARMER:
            image.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmer, timePerFrame: 0.2)))
            break
        case .DOG:
            image.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDog, timePerFrame: 0.2)))
            break
        case .MOLE:
            image.run(SKAction.repeatForever(SKAction.animate(with: sprites.animMole, timePerFrame: 0.2)))
            break
        }
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}
    

