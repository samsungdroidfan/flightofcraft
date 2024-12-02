//
//  MainMenuScene.swift
//  FlightOfCraft - Alien Shooter
//
//  Created by Sergei Alekeyevich Kim on 9/5/20.
//  Copyright © 2020 Sun Games Studio. All rights reserved.
//

import Foundation
import SpriteKit

// This is the Main Menu Scene (when you open the app, you will see this)
class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // This is what the background would look like
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // This is just the game title
        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Flight Of Craft"
        gameName1.fontSize = 135
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.8)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        // This is also part of the game title
        let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
        gameName2.text = "Shoot the Aliens"
        gameName2.fontSize = 135
        gameName2.fontColor = SKColor.white
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName2.zPosition = 1
        self.addChild(gameName2)
        
        // This is where you would tap the start button for the game
        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start"
        startGame.fontSize = 250
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
        startGame.zPosition = 1
        startGame.name = "startButton"
        self.addChild(startGame)
        
        // This is where you will get to the settings, to adjust the volume, etc.
        let settingsName = SKLabelNode(fontNamed: "The Bold Font")
        settingsName.text = "Settings"
        settingsName.fontSize = 150
        settingsName.fontColor = SKColor.white
        settingsName.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.3)
        settingsName.zPosition = 1
        self.addChild(settingsName)
        
        // Trademarks for the game
        let gameName3 = SKLabelNode(fontNamed: "The Bold Font")
        gameName3.text = "(c) 2018 Sun Games Studios,"
        gameName3.fontSize = 80
        gameName3.fontColor = SKColor.red
        gameName3.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.15)
        gameName3.zPosition = 1
        self.addChild(gameName3)
        
        // Credits for the game code
        let gameName4 = SKLabelNode(fontNamed: "The Bold Font")
        gameName4.text = "Based off Matt Heaney's app"
        gameName4.fontSize = 65
        gameName4.fontColor = SKColor.red
        gameName4.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        gameName4.zPosition = 1
        self.addChild(gameName4)

    }
    
    // When object is tapped, return an action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            // When player taps start button, start the game
            if nodeITapped.name == "startButton" {
                let sceneToMoveTo = GameModeChooserScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
    }

}
