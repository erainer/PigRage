//
//  Constants.swift
//  PigRage3-12-18
//
//  Created by Emily on 3/13/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation

//Enums
public enum State {case TITLE; case PLAYING; case OPTIONS;  case CREDITS;  case QUIT; case PAUSE; case GAMEOVER; case WIN; case LOADING}
public enum Direction {case UP; case DOWN; case LEFT; case RIGHT; case NEITHER}
public enum EnemyType {case CHICKEN; case FOX; case FARMER; case DOG; case MOLE}
public enum ItemType {case PIGSIGN; case PIGLET; case BALLOON; case TOXIC}
public enum PlatformType{case HAY1; case HAY2; case DECK; case VERTICAL; case HORIZONTAL}

//Physics categories
struct PhysicsCategory{
    static let none : UInt32 = 0
    static let all: UInt32 = UInt32(UInt.max)
    static let playerCategory: UInt32 = 0x1 << 1

    //Enemies Physics Category
    static let foxCategory: UInt32 = 0x1 << 2
    static let farmerCategory: UInt32 = 0x1 << 3
    static let dogCategory: UInt32 = 0x1 << 4
    static let chickenCategory: UInt32 = 0x1 << 5
    static let moleCategory: UInt32 = 0x1 << 6

    //Items Categoru
    static let powerUpCategory: UInt32 = 0x1 << 7
    static let pigSignCategory: UInt32 = 0x1 << 8
    static let pigAmmoCategory1: UInt32 = 0x1 << 9
    static let pigAmmoCategory2: UInt32 = 0x1 << 10
    static let pigAmmoCategory3: UInt32 = 0x1 << 11
    static let pigAmmoCategory4: UInt32 = 0x1 << 12
    static let pigAmmoCategory5: UInt32 = 0x1 << 13
}



