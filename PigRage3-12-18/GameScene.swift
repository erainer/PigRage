//
//  GameScene.swift
//  PigRage3-12-18
//
//  Created by Emily on 3/12/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    //Classes
    var background = Background()
    let enemies = Enemies()
    let platforms = Platforms()
    let avatar = Avatar()
    let items = Items()
    let sprites = Sprites()

    //SpriteNodes
    var enemy1 = SKSpriteNode()
    var enemy2 = SKSpriteNode()
    var enemy3 = SKSpriteNode()
    var enemy4 = SKSpriteNode()
    var enemy5 = SKSpriteNode()
    
    var item1 = SKSpriteNode()
    var item2 = SKSpriteNode()
    var item3 = SKSpriteNode()
    var item4 = SKSpriteNode(imageNamed: "balloon")
    
    var piglet1 = "SKSpriteNode()"
    var piglet2 = SKSpriteNode()
    var piglet3 = SKSpriteNode()
    var piglet4 = SKSpriteNode()
    var piglet5 = SKSpriteNode()
    
    var ammoArray = [SKTexture]()
    
    var platform1 = SKSpriteNode(imageNamed: "Hay1")
    var platform2 = SKSpriteNode(imageNamed: "deck")
    var platform3 = SKSpriteNode(imageNamed: "Hay2")

    //Variables
    var hit = 0
    var collisionDetected = false
    var initPlayerX = 612
    var flipSprite = false
    var fly = true
    var dogJump = true
    var moleShooting = false
    var isJumping: Bool = false
    var counter = 0
    var powerUp = false
    var gameState: State = .PLAYING
    var scrollRight = false
    var scrollLeft = false
    var scroll = false
    var scrollX: Int = 0
    var isHit = false
    var ammo = 4
    var isShooting = false
    var ammoHit = false
    var shot = false
    var disableCollision = false
    
    var scrolling = 0
    let shootBtnImage = SKSpriteNode(imageNamed:"shootBtn")
    let gameOverImg = SKSpriteNode(imageNamed: "gameOverImg")
    
    var gameMusic = AVAudioPlayer()
    var powerUpSound = AVAudioPlayer()
    var powerDownSound = AVAudioPlayer()
    var pigSquealSound = AVAudioPlayer()
    var pigSnortSound = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        Audio()
        self.addChild(items)
        self.addChild(platforms)
        self.addChild(avatar)
        self.addChild(enemies)
        initEnemies()
        //Physics
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        //Background
        self.backgroundColor = UIColor(red: 0.2941, green: 0.502, blue: 0.949, alpha: 1.0)
        self.addChild(background)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(GameScene.handleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGR)
    }
    
    func Audio(){
        do{
            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "titleScreen", ofType: "wav")!) as URL)
        } catch{
            NSLog("Error: Game music is not working correctly.")
        }
        gameMusic.volume = 0.3
        gameMusic.numberOfLoops = 5
        gameMusic.play()
    }
    func shootBtnTap(){
        if(ammo > 0){
            do{
                try pigSquealSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "pigsqueal", ofType: "wav")!) as URL)
            } catch{
                NSLog("Error: Game music is not working correctly.")
            }
            pigSquealSound.volume = 1.0
            pigSquealSound.play()
            ammo -= 1
            switch(ammo){
                case 1:
                    items.piglet1.position =  CGPoint(x: 800, y: 255)
                self.addChild(items.piglet1)
                break
                case 2:
                    items.piglet2.position =  CGPoint(x: 800, y: 255)
                self.addChild(items.piglet2)
                break
                case 3:
                    items.piglet3.position =  CGPoint(x: 800, y: 255)
                self.addChild(items.piglet3)
                break
                case 4:
                    items.piglet4.position =  CGPoint(x: 800, y: 255)
                self.addChild(items.piglet4)
                break
                case 5:
                    items.piglet5.position = CGPoint(x: 800 , y: 255)
                self.addChild(items.piglet5)
                break
            default:
                print("merrrr")
            }
            
            if(avatar.player.xScale == -1){
                items.pigletArray[ammo].xScale = -1
            }else{
                items.pigletArray[ammo].xScale = 1
            }
            shot = true
        }else{
            isShooting = false
        }
    }
    func initEnemies(){
        enemies.createEnemy(image: enemy1, type: .FOX, xPos: 4800, yPos: 225)
        enemies.createEnemy(image: enemy2, type: .CHICKEN, xPos: 8000, yPos: 225)
        enemies.createEnemy(image: enemy3, type: .FARMER, xPos: 7000, yPos: 300)
        enemies.createEnemy(image: enemy4, type: .DOG, xPos: 6000, yPos: 175)
        enemies.createEnemy(image: enemy5, type: .MOLE, xPos: 7500, yPos: 300)
        
        items.createItem(image: item1, type: .PIGSIGN, xPos: 1300, yPos: 300)
        items.createItem(image: item2, type: .TOXIC, xPos: 2500, yPos: 300)
    }
    
    func updateState(state: State){
        switch(state){
        case .TITLE:
            break
        case .PLAYING:
            break
        case .OPTIONS:
            break
        case .CREDITS:
            break
        case .PAUSE:
            break
        case .GAMEOVER:
            self.removeAllChildren()
             self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            gameOverImg.position = CGPoint(x: 950, y: 450)
            gameOverImg.size = CGSize( width: 1650, height: 800)
            self.addChild(gameOverImg)
            break
        case .WIN:
            break
        case .LOADING:
            break
        case .QUIT:
            break
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isJumping == false){
            let touch: UITouch = touches.first!
            let location = touch.location(in: self)
            scroll = true
            if(location.x > (self.scene?.size.width)!/2 && location.y < ((self.scene?.size.height)! / 4) * 3){
                //Scroll Right
                scrollLeft = false
                if(scrollRight == false){
                    avatar.player.xScale = 1
                    avatar.powerUp.xScale = 1
                    scrollRight = true
                }
                scrollX = 16
                if(isHit == false){
                    if(powerUp == true){
                        avatar.powerUp.run(SKAction.repeatForever(SKAction.animate(with: avatar.powerUpArr, timePerFrame: 0.2)))
                    }else{
                        avatar.player.run(SKAction.repeatForever(SKAction.animate(with: avatar.playerRunArr, timePerFrame: 0.2)))
                    }
                }
                print("walk right")
            }else if(location.x > (self.scene?.size.width)!/2 && location.y > 600){
                isShooting = true
                shootBtnTap()
                print("shoot")
            }else if(location.x > -(self.scene?.size.width)!/2){
                //Scroll Left
                scrollRight = false
                if(scrollLeft == false){
                    avatar.player.xScale = -1
                    avatar.powerUp.xScale = -1
                    scrollLeft = true
                }
                scrollX = -16
                 if(isHit == false){
                    if(powerUp == true){
                        avatar.powerUp.run(SKAction.repeatForever(SKAction.animate(with: avatar.powerUpArr, timePerFrame: 0.2)))
                    }else{
                        avatar.player.run(SKAction.repeatForever(SKAction.animate(with: avatar.playerRunArr, timePerFrame: 0.2)))
                    }
                }
                print("walk left")
            }
        }else{
            self.isUserInteractionEnabled = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?){
        avatar.player.removeAllActions()
        avatar.powerUp.removeAllActions()
        scroll = false
        scrollX = 0
    }
    func didBegin(_ contact: SKPhysicsContact){
        //Disables user interaction
        self.isUserInteractionEnabled = false
        /* Get references to the bodies involved in the collision */
        let firstBody:SKPhysicsBody
        let secondBody:SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        //Fox
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.foxCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                if(disableCollision == false){
                    hit += 1
                    isHit = true
                    background.updateHealth(hit: hit, powerUp: powerUp)
                    if(powerUp == true){
                        avatar.player.run(SKAction.animate(with: avatar.flashPowerUp, timePerFrame: 0.1))
                    }else{
                        avatar.player.run(SKAction.animate(with: avatar.flash, timePerFrame: 0.1))
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isHit = false
                    }
                    print("fox hit player")
                }
            }
        }
        //Farmer
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.farmerCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                if(disableCollision == false){
                    hit += 1
                    isHit = true
                    background.updateHealth(hit: hit, powerUp: powerUp)
                    if(powerUp == true){
                        avatar.player.run(SKAction.animate(with: avatar.flashPowerUp, timePerFrame: 0.1))
                    }else{
                        avatar.player.run(SKAction.animate(with: avatar.flash, timePerFrame: 0.1))
                    }
                    print("farmer hit player yall")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isHit = false
                    }
                }
            }
        }
        
        //Chicken
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.chickenCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                if(disableCollision == false){
                    hit += 1
                    isHit = true
                    background.updateHealth(hit: hit, powerUp: powerUp)
                    if(powerUp == true){
                        avatar.player.run(SKAction.animate(with: avatar.flashPowerUp, timePerFrame: 0.1))
                    }else{
                        avatar.player.run(SKAction.animate(with: avatar.flash, timePerFrame: 0.1))
                    }
                    print("chicken hit player")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isHit = false
                    }
                }
            }
        }

        //Dog
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.dogCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                if(disableCollision == false){
                    hit += 1
                    isHit = true
                    background.updateHealth(hit: hit, powerUp: powerUp)
                    if(powerUp == true){
                        avatar.player.run(SKAction.animate(with: avatar.flashPowerUp, timePerFrame: 0.1))
                    }else{
                        avatar.player.run(SKAction.animate(with: avatar.flash, timePerFrame: 0.1))
                    }
                    print("Dog hit player yall")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isHit = false
                    }
                }
            }
        }
        
        //Mole
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.moleCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                if(disableCollision == false){
                    hit += 1
                    isHit = true
                    background.updateHealth(hit: hit, powerUp: powerUp)
                    if(powerUp == true){
                        avatar.player.run(SKAction.animate(with: avatar.flashPowerUp, timePerFrame: 0.1))
                    }else{
                        avatar.player.run(SKAction.animate(with: avatar.flash, timePerFrame: 0.1))
                    }
                    print("Mole hit player yall")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isHit = false
                    }
                }
            }
        }

        
        //Toxic
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.powerUpCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                do{
                    try powerUpSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "PowerUp", ofType: "wav")!) as URL)
                } catch{
                    NSLog("Error: Game music is not working correctly.")
                }
                powerUpSound.volume = 0.8
                powerUpSound.play()
                item2.removeFromParent()
                avatar.player.removeFromParent()
                self.addChild(avatar.powerUp)
                scrollX = 0
                avatar.powerUp.run(SKAction.animate(with: avatar.transform, timePerFrame: 0.1))
                powerUp = true
                hit = 0
                background.updateHealth(hit: hit, powerUp: powerUp)
            }
        }
        
        //pigsign
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigSignCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                do{
                    try pigSnortSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "pigsnort", ofType: "wav")!) as URL)
                } catch{
                    NSLog("Error: Game music is not working correctly.")
                }
                pigSnortSound.volume = 1.0
                pigSnortSound.play()

                print("player picked up ammo")
                item1.removeFromParent()
                items.createItem(image: item4, type: .BALLOON, xPos: 500, yPos: 600)
                //ammo += 4
                shootBtnImage.size = CGSize(width: 200, height: 200)
                shootBtnImage.position = CGPoint(x: 1500, y: 800)
                self.addChild(shootBtnImage)
                print(ammo)
            }
        }
        //<------------------------------------------------------------
        //piglet versus fox
        if((firstBody.categoryBitMask & PhysicsCategory.foxCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory1 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy1.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFoxDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy1.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet1.removeFromParent()
            }
        }
        
        //piglet versus farmer
        if((firstBody.categoryBitMask & PhysicsCategory.farmerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory1 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit farmer")
                disableCollision = true
                enemy3.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmerDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy3.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet1.removeFromParent()
            }
        }
        
        //piglet versus chicken
        if((firstBody.categoryBitMask & PhysicsCategory.chickenCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory1 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy2.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy2.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet1.removeFromParent()
            }
        }
        
        //piglet versus dog
        if((firstBody.categoryBitMask & PhysicsCategory.dogCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory1 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit dog")
                disableCollision = true
                enemy4.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy4.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet1.removeFromParent()
            }
        }
        
        //piglet versus mole
        if((firstBody.categoryBitMask & PhysicsCategory.moleCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory1 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit mole")
                disableCollision = true
                enemy5.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy5.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet1.removeFromParent()
            }
        }
        
        
        //piglet versus fox
        if((firstBody.categoryBitMask & PhysicsCategory.foxCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory2 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy1.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFoxDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy1.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet2.removeFromParent()
            }
        }
        
        //piglet versus farmer
        if((firstBody.categoryBitMask & PhysicsCategory.farmerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory2 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit farmer")
                disableCollision = true
                enemy3.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmerDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy3.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet2.removeFromParent()
            }
        }
        
        //piglet versus chicken
        if((firstBody.categoryBitMask & PhysicsCategory.chickenCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory2 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy2.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy2.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet2.removeFromParent()
            }
        }
        
        //piglet versus dog
        if((firstBody.categoryBitMask & PhysicsCategory.dogCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory2 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit dog")
                disableCollision = true
                enemy4.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy4.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet2.removeFromParent()
            }
        }

        //piglet versus mole
        if((firstBody.categoryBitMask & PhysicsCategory.moleCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory2 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit mole")
                disableCollision = true
                enemy5.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy5.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet2.removeFromParent()
            }
        }
        //-----------------------------------------------
        //piglet versus fox
        if((firstBody.categoryBitMask & PhysicsCategory.foxCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory3 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy1.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFoxDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy1.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet3.removeFromParent()
            }
        }
        
        //piglet versus farmer
        if((firstBody.categoryBitMask & PhysicsCategory.farmerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory3 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit farmer")
                disableCollision = true
                enemy3.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmerDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy3.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet3.removeFromParent()
            }
        }
        
        //piglet versus chicken
        if((firstBody.categoryBitMask & PhysicsCategory.chickenCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory3 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy2.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy2.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet3.removeFromParent()
            }
        }
        
        //piglet versus dog
        if((firstBody.categoryBitMask & PhysicsCategory.dogCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory3 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit dog")
                disableCollision = true
                enemy4.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy4.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet3.removeFromParent()
            }
        }
        
        //piglet versus mole
        if((firstBody.categoryBitMask & PhysicsCategory.moleCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory3 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit mole")
                disableCollision = true
                enemy5.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy5.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet3.removeFromParent()
            }
        }
        
        //-------------------
        //piglet versus fox
        if((firstBody.categoryBitMask & PhysicsCategory.foxCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory4 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy1.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFoxDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy1.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet4.removeFromParent()
            }
        }
        
        //piglet versus farmer
        if((firstBody.categoryBitMask & PhysicsCategory.farmerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory4 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit farmer")
                disableCollision = true
                enemy3.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmerDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy3.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet4.removeFromParent()
            }
        }
        
        //piglet versus chicken
        if((firstBody.categoryBitMask & PhysicsCategory.chickenCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory4 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy2.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy2.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet4.removeFromParent()
            }
        }
        
        //piglet versus dog
        if((firstBody.categoryBitMask & PhysicsCategory.dogCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory4 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit dog")
                disableCollision = true
                enemy4.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy4.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet4.removeFromParent()
            }
        }
        
        //piglet versus mole
        if((firstBody.categoryBitMask & PhysicsCategory.moleCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory4 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit mole")
                disableCollision = true
                enemy5.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy5.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet4.removeFromParent()
            }
        }
        
        //------------------------
        //piglet versus fox
        if((firstBody.categoryBitMask & PhysicsCategory.foxCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory5 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy1.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFoxDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy1.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet5.removeFromParent()
            }
        }
        
        //piglet versus farmer
        if((firstBody.categoryBitMask & PhysicsCategory.farmerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory5 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit farmer")
                disableCollision = true
                enemy3.run(SKAction.repeatForever(SKAction.animate(with: sprites.animFarmerDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy3.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet5.removeFromParent()
            }
        }
        
        //piglet versus chicken
        if((firstBody.categoryBitMask & PhysicsCategory.chickenCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory5 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit fox")
                disableCollision = true
                enemy2.run(SKAction.repeatForever(SKAction.animate(with: sprites.animChickenDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy2.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet5.removeFromParent()
            }
        }
        
        //piglet versus dog
        if((firstBody.categoryBitMask & PhysicsCategory.dogCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory5 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit dog")
                disableCollision = true
                enemy4.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy4.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet5.removeFromParent()
            }
        }
        
        //piglet versus mole
        if((firstBody.categoryBitMask & PhysicsCategory.moleCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.pigAmmoCategory5 != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                print("piglet hit mole")
                disableCollision = true
                enemy5.run(SKAction.repeatForever(SKAction.animate(with: sprites.animDogDeath, timePerFrame: 0.2)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.enemy5.removeFromParent()
                    self.disableCollision = false
                }
                items.piglet5.removeFromParent()
            }
        }
        
        
        if(hit == 3 && powerUp == false){
            gameState = .GAMEOVER
            hit = 0
        }
        if(hit == 3 && powerUp == true){
            avatar.powerUp.run(SKAction.animate(with: avatar.powerUpDeathArr, timePerFrame: 0.1))
            do{
                try powerDownSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "powerDownAudio", ofType: "wav")!) as URL)
            } catch{
                NSLog("Error: Game music is not working correctly.")
            }
            
            powerDownSound.volume = 0.8
            powerDownSound.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.avatar.powerUp.removeFromParent()
                self.addChild(self.avatar.player)
                self.scrollX = 0
                self.background.healthBar = SKSpriteNode(imageNamed: self.background.health1)
                self.hit = 0
                self.powerUp = false
                self.background.updateHealth(hit: self.hit, powerUp: self.powerUp)
            }
        }
        
        //Enables user interaction
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isUserInteractionEnabled = true
        }
    }

    override func update(_ currentTime: TimeInterval) {
        updateState(state: gameState)
        scrolling += scrollX
        platforms.position.x = platforms.position.x - CGFloat(scrollX)
        background.moveClouds()
        enemies.position.x = enemies.position.x - CGFloat(scrollX)
        items.position.x = items.position.x - CGFloat(scrollX)
        
        enemyAI(type: .FOX, node: enemy1)
        enemyAI(type: .CHICKEN, node: enemy2)
        enemyAI(type: .FARMER, node: enemy3)
        enemyAI(type: .DOG, node: enemy4)
        enemyAI(type: .FARMER, node: enemy5)
        
        if(scroll == true){
            initPlayerX += scrollX
            background.moveGround(scrollX: scrollX, left: scrollLeft, right: scrollRight, scroll: scroll)
        }
        
        updatePiglet(node: items.piglet1)
        updatePiglet(node: items.piglet2)
        updatePiglet(node: items.piglet3)
        updatePiglet(node: items.piglet4)
        updatePiglet(node: items.piglet5)
    }
    
    func updatePiglet(node: SKSpriteNode){
        if(node.xScale == -1){
            node.position.x -= 10
        }
        else if(node.xScale == 1){
            node.position.x += 10
        }
        
        if(ammoHit == true){
            node.removeFromParent()
        }
    }
    func enemyAI(type: EnemyType, node: SKSpriteNode){
        switch(type){
        case .FOX:
                node.position.x -= 10
            break
        case .CHICKEN:
            if(node.position.y != 700 && fly == true){
                node.position.y += 5
                if(node.position.y >= 700){
                    fly = false
                }
            }
            if(node.position.y > 225 && fly == false){
                node.position.y -= 5
                if(node.position.y <= 225){
                    fly = true
                }
            }
            if(initPlayerX + 212 < Int(node.position.x)){
                node.position.x -= 5
                node.xScale = 1
            }
            if(initPlayerX > Int(node.position.x)){
                node.position.x += 5
                node.xScale = -1
            }
            break
        case .FARMER:
            if(initPlayerX + 212 < Int(node.position.x)){
                node.position.x -= 10
                node.xScale = 1
            }else if(initPlayerX > Int(node.position.x)){
                node.position.x += 10
                node.xScale = -1
            }
            break
        case .DOG:
            if(dogJump == true){
                node.position.y += 10
                if(node.position.y >= 500){
                    dogJump = false
                }
            }
            if(node.position.y > 225 && dogJump == false){
                node.position.y -= 10
                if(node.position.y <= 175){
                    dogJump = true
                }
            }
            break
        case .MOLE:
            break
        }
    }
}

extension GameScene: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        isJumping = true
         isUserInteractionEnabled = false
        if(isJumping == true){
            isJumping = false
            //plays jump animation
            let jumpUp = SKAction.moveBy(x: 0, y: 300, duration: 0.6)
            let fallBack = SKAction.moveBy(x: 0, y: -300, duration: 0.6)
            avatar.player.run(SKAction.sequence([jumpUp, fallBack]))
            avatar.player.run(SKAction.animate(with: avatar.playerJumpArr, timePerFrame: 0.6))
        }
        //Enables user interaction
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
            self.isUserInteractionEnabled = true
            self.isJumping = false
            self.scrollX = 0
            self.avatar.player.removeAllActions()
        }
    }

}



