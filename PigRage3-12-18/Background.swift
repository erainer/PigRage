//
//  Background.swift
//  PigRage3-12-18
//
//  Created by Emily on 3/22/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class Background: SKNode {
    //Ground
    let ground = SKSpriteNode(imageNamed: "ground")
    let ground2  = SKSpriteNode(imageNamed: "ground")
    let ground3 = SKSpriteNode(imageNamed: "ground")

    //Clouds
    let cloud = SKSpriteNode(imageNamed: "cloud")
    
    //HealthBar
    var healthBar = SKSpriteNode()
    let health1 = "healthbar_1"
    let health2 = "healthbar_2"
    let health3 = "healthbar_3"
    let health4 = "healthbar_4"
    
    var healthBarPowerUpBackward = SKSpriteNode()
    var healthPowerUpArrBackward = [SKTexture]()
    
    var healthBarPowerUp = SKSpriteNode()
    let healthPowerUp1 = "healthbarPowerUp_01"
    let healthPowerUp2 = "healthbarPowerUp_02"
    let healthPowerUp3 = "healthbarPowerUp_03"
    let healthPowerUp4 = "healthbarPowerUp_04"

    override init(){
        super.init()
        createGround()
        createCloud()
        initHealthBar()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    func initHealthBar(){
        healthBar = SKSpriteNode(imageNamed: health1)
        healthBar.position = CGPoint(x: 350, y: 800)
        healthBar.size = CGSize( width: 292, height: 57)
        healthBar.zPosition = 1
        self.addChild(healthBar)

        healthBarPowerUp = SKSpriteNode(imageNamed: healthPowerUp4)
        healthBarPowerUp.position = CGPoint(x: 350, y: 800)
        healthBarPowerUp.size = CGSize( width: 292, height: 57)
        healthBarPowerUp.zPosition = 1
        
    }
    
    func updateHealth(hit: Int, powerUp: Bool){
        healthBar.removeFromParent()
        switch(hit){
        case 1:
            if(powerUp == true){
                healthBar = SKSpriteNode(imageNamed: healthPowerUp4)
            }else{
                healthBar = SKSpriteNode(imageNamed: health2)
            }
            break
        case 2:
            if(powerUp == true){
                healthBar = SKSpriteNode(imageNamed: healthPowerUp3)
            }else{
                healthBar = SKSpriteNode(imageNamed: health3)
            }
            break
        case 3:
            if(powerUp == true){
                healthBar = SKSpriteNode(imageNamed: healthPowerUp2)
            }else{
                healthBar = SKSpriteNode(imageNamed: health4)
            }
            break
        default:
            break
        }
        healthBar.position = CGPoint(x: 350, y: 800)
        healthBar.size = CGSize( width: 292, height: 57)
        self.addChild(healthBar)
    }
    func createGround(){
        //Displays the ground
        ground.zPosition = 0
        ground2.zPosition = 0
        ground3.zPosition = 0
        ground.position = CGPoint(x: 0, y: 75)
        self.addChild(ground)
        ground2.position = CGPoint(x: ground2.size.width - 1, y: 75)
        self.addChild(ground2)
        ground3.position = CGPoint(x: ground2.size.width + ground3.size.width - 1, y: 75)
        self.addChild(ground3)
    }
    
    func createCloud(){
        cloud.position = CGPoint(x: 1920 + cloud.size.width, y: 800)
        cloud.zPosition = 0
        self.addChild(cloud)
    }
    func moveClouds(){
        let initPosCloud = CGPoint(x: 1920 + cloud.size.width, y: 800)
        //Moves the grounds left
        cloud.position = CGPoint(x: cloud.position.x - 2, y: 800)
        //Resets the position of the cloud once it is off the screen
        if(cloud.position.x < -510){
            cloud.position.x = initPosCloud.x + 510
        }
    }
    
    func moveGround(scrollX: Int, left: Bool, right: Bool, scroll: Bool){
        let posNum: CGFloat = 500
        let negNum: CGFloat = -500
        let initPosGround3 = CGPoint(x: (ground.size.width * 2) + posNum, y: 75)
        let initPosGround1 = CGPoint(x: -ground.size.width + posNum, y: 75)
        //Moves the grounds left
        ground.position = CGPoint(x: ground.position.x - CGFloat(scrollX), y: ground.position.y)
        ground2.position = CGPoint(x: ground2.position.x - CGFloat(scrollX), y: ground2.position.y)
        ground3.position = CGPoint(x: ground3.position.x - CGFloat(scrollX), y: ground3.position.y)
        if(right == true){
            //Resets the position of the ground once it is off the screen
            if(ground.position.x < negNum){
                ground.position.x = initPosGround3.x
            }
        
            if(ground2.position.x < negNum){
                ground2.position.x = initPosGround3.x
            }
        
            if(ground3.position.x < negNum){
                ground3.position.x = initPosGround3.x
            }
        }
        if(left == true){
            //Resets the position of the ground once it is off the screen
            if(ground.position.x  > (scene?.size.width)! + posNum){
                ground.position.x = initPosGround1.x
            }

            if(ground2.position.x > (scene?.size.width)! + posNum){
                ground2.position.x = initPosGround1.x
            }

            if(ground3.position.x > (scene?.size.width)! + posNum){
                ground3.position.x = initPosGround1.x
            }
        }
    }
}
