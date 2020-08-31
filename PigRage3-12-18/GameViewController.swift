//
//  GameViewController.swift
//  PigRage3-12-18
//
//  Created by Emily on 3/12/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController{
    
    let scene = GameScene()
    let items = Items()
    let avatar = Avatar()
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size:CGSize(width: 1920, height: 900))
        let SKView = self.view as! SKView
        SKView.showsFPS = false
        SKView.showsPhysics = false
        SKView.showsNodeCount = false
        SKView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        SKView.presentScene(scene)
    }

}
