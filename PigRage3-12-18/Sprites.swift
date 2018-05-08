//
//  Sprites.swift
//  PigRage3-12-18
//
//  Created by Emily on 4/11/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import SpriteKit

class Sprites: SKNode{
    
    //Farmer
    var farmer = SKSpriteNode()
    var animFarmer = [SKTexture]()
    var farmer1 = "FarmerSprite_01"
    var farmer2 = "FarmerSprite_02"
    var farmer3 = "FarmerSprite_03"
    var farmer4 = "FarmerSprite_04"
    
    var animFarmerDeath = [SKTexture]()
    var farmerDeath1 = "Farmer_Death01"
    var farmerDeath2 = "Farmer_Death02"
    var farmerDeath3 = "Farmer_Death03"
    var farmerDeath4 = "Farmer_Death04"
    var farmerDeath5 = "Farmer_Death05"
    var farmerDeath6 = "Farmer_Death06"
    
    //Mole
    var mole = SKSpriteNode()
    var animMole = [SKTexture]()
    var mole1 = "MoleSprite_01"
    var mole2 = "MoleSprite_02"
    var mole3 = "MoleSprite_03"
    var mole4 = "MoleSprite_04"
    var mole5 = "MoleSprite_05"
    var mole6 = "MoleSprite_06"
    var mole7 = "MoleSprite_07"
    
    //Chicken
    var chicken = SKSpriteNode()
    var animChicken = [SKTexture]()
    var chicken1 = "ChickenSprite_01"
    var chicken2 = "ChickenSprite_02"
    var chicken3 = "ChickenSprite_03"
    
    var animChickenJump = [SKTexture]()
    var chickenJump1 = "ChickenJump_01"
    var chickenJump2 = "ChickenJump_02"
    
    var animChickenDeath = [SKTexture]()
    var chickenDeath1 = "Chicken_Death01"
    var chickenDeath2 = "Chicken_Death02"
    var chickenDeath3 = "Chicken_Death03"
    var chickenDeath4 = "Chicken_Death04"
    var chickenDeath5 = "Chicken_Death05"
    var chickenDeath6 = "Chicken_Death06"
    var chickenDeath7 = "Chicken_Death07"
    var chickenDeath8 = "Chicken_Death08"
    var chickenDeath9 = "Chicken_Death09"
    
    //Dog
    var dog = SKSpriteNode()
    var animDog = [SKTexture]()
    var dog1 = "DogSprite_01"
    var dog2 = "DogSprite_02"
    var dog3 = "DogSprite_03"
    var dog4 = "DogSprite_04"
    
    var animDogDeath = [SKTexture]()
    var dogDeath1 = "Dog_Death01"
    var dogDeath2 = "Dog_Death02"
    var dogDeath3 = "Dog_Death03"
    var dogDeath4 = "Dog_Death04"
    
    //Fox
    var fox = SKSpriteNode()
    var animFox = [SKTexture]()
    var fox1 = "FoxSprite_01"
    var fox2 = "FoxSprite_02"
    var fox3 = "FoxSprite_03"
    var fox4 = "FoxSprite_04"
    
    var animFoxDeath = [SKTexture]()
    var foxDeath1 = "Fox_Death01"
    var foxDeath2 = "Fox_Death02"
    var foxDeath3 = "Fox_Death03"
    var foxDeath4 = "Fox_Death04"
    var foxDeath5 = "Fox_Death05"
    var foxDeath6 = "Fox_Death06"
    var foxDeath7 = "Fox_Death07"
    var foxDeath8 = "Fox_Death08"
    var foxDeath9 = "Fox_Death09"
    
    
    
    override init(){
        super.init()
        initAnimations()
    }
    
    func initAnimations(){
        //Chicken
        //Run
        animChicken.append(SKTexture(imageNamed: chicken1))
        animChicken.append(SKTexture(imageNamed: chicken2))
        animChicken.append(SKTexture(imageNamed: chicken3))
        //Jump
        animChickenJump.append(SKTexture(imageNamed: chickenJump1))
        animChickenJump.append(SKTexture(imageNamed: chickenJump2))
        //Death
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath1))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath2))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath3))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath4))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath5))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath6))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath7))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath8))
        animChickenDeath.append(SKTexture(imageNamed: chickenDeath9))
        //-------------------------------------------
        //Farmer
        //Run
        animFarmer.append(SKTexture(imageNamed: farmer1))
        animFarmer.append(SKTexture(imageNamed: farmer2))
        animFarmer.append(SKTexture(imageNamed: farmer3))
        animFarmer.append(SKTexture(imageNamed: farmer4))
        //Death
        animFarmerDeath.append(SKTexture(imageNamed: farmerDeath1))
        animFarmerDeath.append(SKTexture(imageNamed: farmerDeath2))
        animFarmerDeath.append(SKTexture(imageNamed: farmerDeath3))
        animFarmerDeath.append(SKTexture(imageNamed: farmerDeath4))
        //--------------------------------------------
        //Mole
        //Run
        animMole.append(SKTexture(imageNamed: mole1))
        animMole.append(SKTexture(imageNamed: mole2))
        animMole.append(SKTexture(imageNamed: mole3))
        animMole.append(SKTexture(imageNamed: mole4))
        animMole.append(SKTexture(imageNamed: mole5))
        animMole.append(SKTexture(imageNamed: mole6))
        animMole.append(SKTexture(imageNamed: mole7))
        //Death
        //-------------------------------------------
        //Dog
        
        //Run
        animDog.append(SKTexture(imageNamed: dog1))
//        animDog.append(SKTexture(imageNamed: dog2))
//        animDog.append(SKTexture(imageNamed: dog3))
//        animDog.append(SKTexture(imageNamed: dog4))
        //Death
        animDogDeath.append(SKTexture(imageNamed: dogDeath1))
        animDogDeath.append(SKTexture(imageNamed: dogDeath2))
        animDogDeath.append(SKTexture(imageNamed: dogDeath3))
        animDogDeath.append(SKTexture(imageNamed: dogDeath4))
        //------------------------------------------
        //Fox
        //Run
        animFox.append(SKTexture(imageNamed: fox1))
        animFox.append(SKTexture(imageNamed: fox2))
        animFox.append(SKTexture(imageNamed: fox3))
        animFox.append(SKTexture(imageNamed: fox4))
        //Death
        animFoxDeath.append(SKTexture(imageNamed: foxDeath1))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath2))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath3))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath4))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath5))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath6))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath7))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath8))
        animFoxDeath.append(SKTexture(imageNamed: foxDeath9))
        
    }
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
}
