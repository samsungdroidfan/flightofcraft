//
//  GameModeChooserScene.swift
//  FlightOfCraft - Alien Shooter
//
//  Created by Sergei Alekeyevich Kim on 9/6/20.
//  Copyright © 2020 Sun Games Studio. All rights reserved.
//

import Foundation
import SpriteKit

// This is where you choose your game mode (easy or hard)
class GameModeChooserScene: SKScene {
    override func didMove(to view: SKView) {
        // The background will look like this
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // This is the text that states 'Select Game Mode'
        let modeName = SKLabelNode(fontNamed: "The Bold Font")
        modeName.text = "Select Game Mode"
        modeName.fontSize = 100
        modeName.fontColor = SKColor.white
        modeName.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.85)
        modeName.zPosition = 1
        modeName.name = "regularMode"
        self.addChild(modeName)
        
        // If you want to play the regular level, tap this text
        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Regular"
        gameName1.fontSize = 250
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.65)
        gameName1.zPosition = 1
        gameName1.name = "regularMode"
        self.addChild(gameName1)
        
        // If you want to play the hard level, tap this text
        let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
        gameName2.text = "Hard"
        gameName2.fontSize = 250
        gameName2.fontColor = SKColor.white
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.45)
        gameName2.zPosition = 1
        gameName2.name = "hardMode"
        self.addChild(gameName2)
        
        // This is when you tap how to play since you are new to the game
        let aboutGame = SKLabelNode(fontNamed: "The Bold Font")
        aboutGame.text = "How To Play"
        aboutGame.fontSize = 175
        aboutGame.fontColor = SKColor.white
        aboutGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.25)
        aboutGame.zPosition = 1
        aboutGame.name = "aboutButton"
        self.addChild(aboutGame)
        
        
    }
    
    // When something is tapped, return an action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            // If player taps regular mode, then play the regular level
            if nodeITapped.name == "regularMode" {
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            // If player taps hard mode, then play the hard level
            if nodeITapped.name == "hardMode" {
                let sceneToMoveTo = HardGameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            // If player taps about button, they will be redirected to how to play game
            if nodeITapped.name == "aboutButton" {
                let sceneToMoveTo = HowToPlayGameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
}

}

}
