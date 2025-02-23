//
//  GameViewController.swift
//  FlightOfCraft - Alien Shooter
//
//  Created by Sergei Alekeyevich Kim on 9/2/20.
//  Copyright (c) 2020 Sun Games Studio. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

// This is setting the game view controller and the UI of the game
class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is the scene of the game (what you will see)
        let scene =  MainMenuScene(size: CGSize(width: 1536, height: 2048))
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)

    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
