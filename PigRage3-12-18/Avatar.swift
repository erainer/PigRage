//
//  Avatar.swift
//  PigRage3-12-18
//
//  Created by Emily on 4/11/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import SpriteKit

class Avatar: SKNode{
    
    let playerStartPos = CGPoint(x: 400, y: 75)
    //Pig Avatar Run
    var player = SKSpriteNode()
    var playerRunArr = [SKTexture]()
    let playerRun1 = "Pig_Avatar_01"
    let playerRun2 = "Pig_Avatar_02"
    let playerRun3 = "Pig_Avatar_03"
    let playerRun4 = "Pig_Avatar_04"
    let playerRun5 = "Pig_Avatar_05"
    let playerRun6 = "Pig_Avatar_06"
    let playerRun7 = "Pig_Avatar_07"
    
    //Pig Avatar Jump
    var playerJumpArr = [SKTexture]()
    let playerJump1 = "Pig_Jump_01"
    let playerJump2 = "Pig_Jump_02"
    
    //PowerUp
    var powerUp = SKSpriteNode()
    var powerUpArr = [SKTexture]()
    let powerUp1 = "PowerUp_01"
    let powerUp2 = "PowerUp_02"
    let powerUp3 = "PowerUp_03"
    
    //PowerUp Death
    var powerUpDeathArr = [SKTexture]()
    let powerUpDeath1 = "PowerUp_Death_01"
    let powerUpDeath2 = "PowerUp_Death_02"
    let powerUpDeath3 = "PowerUp_Death_03"
    let powerUpDeath4 = "PowerUp_Death_04"
    let powerUpDeath5 = "PowerUp_Death_05"
    let powerUpDeath6 = "PowerUp_Death_06"

    
    var flash = [SKTexture]()
    var flashPowerUp = [SKTexture]()
    let blankPig = "blankPig"
    
    var transform = [SKTexture]()

    
    override init(){
        super.init()
        createPlayer()
        //Jump
        playerJumpArr.append(SKTexture(imageNamed: playerJump1))
        playerJumpArr.append(SKTexture(imageNamed: playerJump2))
        
        powerUpArr.append(SKTexture(imageNamed: powerUp1))
        powerUpArr.append(SKTexture(imageNamed: powerUp2))
        powerUpArr.append(SKTexture(imageNamed: powerUp3))
        
        //Pig Flash
        flash.append(SKTexture(imageNamed:playerRun1))
        flash.append(SKTexture(imageNamed: blankPig))
        flash.append(SKTexture(imageNamed:playerRun1))
        flash.append(SKTexture(imageNamed: blankPig))
        flash.append(SKTexture(imageNamed:playerRun1))
        flash.append(SKTexture(imageNamed: blankPig))
        flash.append(SKTexture(imageNamed:playerRun1))
        flash.append(SKTexture(imageNamed: blankPig))
        flash.append(SKTexture(imageNamed:playerRun1))
        flash.append(SKTexture(imageNamed: blankPig))
        flash.append(SKTexture(imageNamed:playerRun1))
        
        //Powerup Flash
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        flashPowerUp.append(SKTexture(imageNamed: blankPig))
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        flashPowerUp.append(SKTexture(imageNamed: blankPig))
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        flashPowerUp.append(SKTexture(imageNamed: blankPig))
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        flashPowerUp.append(SKTexture(imageNamed: blankPig))
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        flashPowerUp.append(SKTexture(imageNamed: blankPig))
        flashPowerUp.append(SKTexture(imageNamed:powerUp1))
        
        //PowerUp Transform
        transform.append(SKTexture(imageNamed:playerRun1))
        transform.append(SKTexture(imageNamed:powerUp1))
        transform.append(SKTexture(imageNamed:playerRun1))
        transform.append(SKTexture(imageNamed:powerUp1))
        transform.append(SKTexture(imageNamed: playerRun2))
        transform.append(SKTexture(imageNamed:powerUp2))
        
        transform.append(SKTexture(imageNamed:playerRun2))
        transform.append(SKTexture(imageNamed:powerUp2))
        transform.append(SKTexture(imageNamed:playerRun3))
        transform.append(SKTexture(imageNamed:powerUp3))
        
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath1))
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath2))
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath3))
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath4))
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath5))
        powerUpDeathArr.append(SKTexture(imageNamed:powerUpDeath6))
    }
    
    func createPlayer(){
        //Run
        playerRunArr.append(SKTexture(imageNamed: playerRun1))
        playerRunArr.append(SKTexture(imageNamed: playerRun2))
        playerRunArr.append(SKTexture(imageNamed: playerRun3))
        playerRunArr.append(SKTexture(imageNamed: playerRun4))
        playerRunArr.append(SKTexture(imageNamed: playerRun5))
        playerRunArr.append(SKTexture(imageNamed: playerRun6))
        playerRunArr.append(SKTexture(imageNamed: playerRun7))
       
        //Player Properties
        player = SKSpriteNode(imageNamed: "Pig_Avatar_01")
        player.name = "player"
        player.zPosition = 1
        player.position = CGPoint(x: 800, y: 255)
        player.size = CGSize( width: 212, height: 320)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        player.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory | PhysicsCategory.chickenCategory
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.addChild(player)
        
        //PowerUp Properties
        powerUp = SKSpriteNode(imageNamed: "PowerUp_01")
        powerUp.name = "powerUp"
        powerUp.zPosition = 1
        powerUp.position = CGPoint(x: 800, y: 255)
        powerUp.size = CGSize( width: 212, height: 320)
        powerUp.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        powerUp.physicsBody?.isDynamic = true
        powerUp.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        powerUp.physicsBody?.contactTestBitMask = PhysicsCategory.foxCategory | PhysicsCategory.farmerCategory | PhysicsCategory.dogCategory | PhysicsCategory.moleCategory | PhysicsCategory.chickenCategory
        powerUp.physicsBody?.collisionBitMask = PhysicsCategory.none
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}

