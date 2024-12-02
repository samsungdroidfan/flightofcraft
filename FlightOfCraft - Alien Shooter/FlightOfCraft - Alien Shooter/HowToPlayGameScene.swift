//
//  HowToPlayGameScene.swift
//  FlightOfCraft - Alien Shooter
//
//  Created by Sergei Alekeyevich Kim on 9/7/20.
//  Copyright © 2020 Sun Games Studio. All rights reserved.
//

import Foundation
import SpriteKit

class HowToPlayGameScene: SKScene {
    override func didMove(to view: SKView) {
        // This is the background/wallpaper for the game
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        // This is the uppermost piece of text
        let text1 = SKLabelNode(fontNamed: "The Bold Font")
        text1.text = "Move your finger to the left to swipe the ship left"
        text1.fontSize = 75
        text1.fontColor = SKColor.white
        text1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.85)
        text1.zPosition = 1
        text1.lineBreakMode = NSLineBreakMode.byWordWrapping
        text1.numberOfLines = 0
        text1.preferredMaxLayoutWidth = 1000
        self.addChild(text1)
        
        // This is the second piece of text
        let text2 = SKLabelNode(fontNamed: "The Bold Font")
        text2.text = "Move your finger to the right to swipe the ship right"
        text2.fontSize = 75
        text2.fontColor = SKColor.white
        text2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        text2.zPosition = 1
        text2.lineBreakMode = NSLineBreakMode.byWordWrapping
        text2.numberOfLines = 0
        text2.preferredMaxLayoutWidth = 1000
        self.addChild(text2)
        
        // This is the third piece of text
        let text3 = SKLabelNode(fontNamed: "The Bold Font")
        text3.text = "In regular mode, you have 3 'attempts'"
        text3.fontSize = 75
        text3.fontColor = SKColor.white
        text3.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.59)
        text3.zPosition = 1
        text3.lineBreakMode = NSLineBreakMode.byWordWrapping
        text3.numberOfLines = 0
        text3.preferredMaxLayoutWidth = 1000
        self.addChild(text3)
        
        // This is the fourth piece of text
        let text4 = SKLabelNode(fontNamed: "The Bold Font")
        text4.text = "For every UFO you left out, you lose one attempt"
        text4.fontSize = 75
        text4.fontColor = SKColor.white
        text4.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.47)
        text4.zPosition = 1
        text4.lineBreakMode = NSLineBreakMode.byWordWrapping
        text4.numberOfLines = 0
        text4.preferredMaxLayoutWidth = 1000
        self.addChild(text4)
        
        // This is the fifth piece of text
        let text5 = SKLabelNode(fontNamed: "The Bold Font")
        text5.text = "If you lose 3 attempts or crash into a UFO, you are dead"
        text5.fontSize = 75
        text5.fontColor = SKColor.white
        text5.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.32)
        text5.zPosition = 1
        text5.lineBreakMode = NSLineBreakMode.byWordWrapping
        text5.numberOfLines = 0
        text5.preferredMaxLayoutWidth = 1000
        self.addChild(text5)
        
        // This is the sixth piece of text
        let text6 = SKLabelNode(fontNamed: "The Bold Font")
        text6.text = "The score increases by 1 everytime you shoot a ship"
        text6.fontSize = 75
        text6.fontColor = SKColor.white
        text6.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.17)
        text6.zPosition = 1
        text6.lineBreakMode = NSLineBreakMode.byWordWrapping
        text6.numberOfLines = 0
        text6.preferredMaxLayoutWidth = 1000
        self.addChild(text6)
        
        // This button brings you back to the main menu
        let mainGame = SKLabelNode(fontNamed: "The Bold Font")
        mainGame.text = "Back to Main Menu"
        mainGame.fontSize = 100
        mainGame.fontColor = SKColor.white
        mainGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        mainGame.zPosition = 1
        mainGame.name = "menuButton"
        self.addChild(mainGame)
        
        
    }
    
    // If you were to touch at one place, one action would return.
    // In this case, it is only the main menu button (above node).
    // Of which if you tap the menu button, it will return to the main menu
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "menuButton" {
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
    }


    
}
