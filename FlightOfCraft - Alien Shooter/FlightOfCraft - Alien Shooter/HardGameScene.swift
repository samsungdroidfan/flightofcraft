//
//  HardGameScene.swift
//  FlightOfCraft - Alien Shooter
//
//  Created by Sergei Alekeyevich Kim on 9/6/20.
//  Copyright © 2020 Sun Games Studio. All rights reserved.
//

import SpriteKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// The game score will start off at 0

var gameScore = 0

// This is the hard game
class HardGameScene: SKScene, SKPhysicsContactDelegate {
    
    // Score label will denote the current score of the game
    // The lives number will denote how many attempts you have left
    // That meant that if one spaceship goes off the grid, you lose a 'life'
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    var livesNumber = 2
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    var levelNumber = 0
    
    // The player is the spaceship
    let player = SKSpriteNode(imageNamed: "playerShip")
    
    // I found the bullet sound on the internet, and when you shoot, a sound will come
    let bulletSound = SKAction.playSoundFileNamed("BulletSound.mp3", waitForCompletion: false)
    
    // When you shoot and you gain a point because a spaceship is destroyed;
    // An explosion will pop up
    let explosionSound = SKAction.playSoundFileNamed("ExplosionSoundEffect.mp3", waitForCompletion: false)
    
    // The player will see this before they start the game telling them to start
    let tapToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    // There are three game states in this game
    enum gameState {
        case preGame //when game is before start of game
        case inGame //when game is during the game
        case afterGame //when game is after the game
        
    }
    
    // We want to set the gameState to pre game every time we start the game
    var currentGameState = gameState.preGame
    
    // This is how the player, the bullet, and the enemy will be represented in this game
    struct PhysicsCategories {
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Bullet : UInt32 = 0b10 //2
        static let Enemy : UInt32 = 0b100 //4
        
    }
    
    // Lines 71-98 has to do with the screen and the resolution
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    var gameArea: CGRect

        override init(size: CGSize) {
            if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
                //iPhone X
                let maxAspectRatio: CGFloat = 19.5/9.0
                let playableWidth = size.height / maxAspectRatio
                let margin = (size.width - playableWidth) / 2
                gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
            } else {
                let maxAspectRatio: CGFloat = 16.0/9.0
                let playableWidth = size.height / maxAspectRatio
                let margin = (size.width - playableWidth) / 2
                gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
            }

            super.init(size: size)
        }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        // The game score will start at 0
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        // This is for the background for any i between 0 and 1
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.anchorPoint = CGPoint(x: 0.5, y: 0)
            background.position = CGPoint(x: self.size.width/2, y: self.size.height*CGFloat(i))
            background.zPosition = 0
            background.name = "Background"
            self.addChild(background)
        }
        
        // This is the player ship
        player.setScale(0.5)
        player.position = CGPoint(x: self.size.width/2, y: 0 - player.size.height)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        // This is the label for the score
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.15, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        // You lose an attempt everytime an enemy ship goes down the screen
        livesLabel.text = "Attempts: 2"
        livesLabel.fontSize = 70
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width*0.85, y: self.size.height + livesLabel.frame.size.height)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        
        // Once the game starts, it will take 0.3 seconds for the score and lives label to
        // appear. Afterwards, the score and lives label will be in this position
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height*0.9, duration: 0.3)
        scoreLabel.run(moveOnToScreenAction)
        livesLabel.run(moveOnToScreenAction)
        
        // Before the game starts, this is where you tap to begin
        tapToStartLabel.text = "Tap To Begin"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.white
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.alpha = 0
        self.addChild(tapToStartLabel)
        
        // After you start the game, the pre-game will fade and will go into the in-game
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        tapToStartLabel.run(fadeInAction)
        
        
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var amountToMovePerSecond: CGFloat = 600.0
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }
        else {
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackground = amountToMovePerSecond * CGFloat(deltaFrameTime)
        self.enumerateChildNodes(withName: "Background") {
            background, stop in
            if self.currentGameState == gameState.inGame {
                background.position.y -= amountToMoveBackground
            }
            if background.position.y < -self.size.height {
                background.position.y += self.size.height*2
            }
        }
        
    }
    
    // This is what happens after you tap in the Start Game button
    func startGame() {
        currentGameState = gameState.inGame
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        tapToStartLabel.run(deleteSequence)
        
        let moveShipOntoScreenAction = SKAction.moveTo(y: self.size.height*0.2, duration: 0.5)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipOntoScreenAction, startLevelAction])
        player.run(startGameSequence)
    }
    
    // This will happen if a ship were to go out of the grid; you will lose a 'life'
    func loseALife() {
        livesNumber -= 1
        livesLabel.text = "Attempts: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        // The game will end if your 'lives' number go down to 0
        if livesNumber == 0 {
            runGameOver()
        }
    }
    
    // Everytime you shoot an enemy ship, you gain one point. It will get harder overtime
    func addScore() {
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        if gameScore == 10 || gameScore == 25 || gameScore == 50 || gameScore == 100 {
            startNewLevel()
        }
        
    }
    
    // When the game is over, do all of these actions
    func runGameOver() {
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Bullet") {
            bullet, stop in
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy") {
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
        
    }
    // When the game is over, you should change the scene to GameOver (Hard if hard)
    func changeScene() {
        let sceneToMoveTo = HardGameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    // This is if either a player hits the enemy, or the bullet hits the enemy
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        // If player hits the enemy, return 'game over'
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy {
            //If player hit the enemy
            if body1.node != nil {
                spawnExplosion(body1.node!.position)
            }
            
            if body2.node != nil {
                
                spawnExplosion(body2.node!.position)
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            runGameOver()
        }
        
        // If bullet hits the enemy, add one point to the player
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && body2.node?.position.y < self.size.height {
            //If bullet hit the enemy
            addScore()
            if body2.node != nil {
                spawnExplosion(body2.node!.position)
            }
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
    }
    
    // After a given amount of points (line 234), increase the level
    func startNewLevel() {
        
        levelNumber += 1
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        // This is how long each 'level' takes for an enemy to spawn
        switch levelNumber {
        case 1: levelDuration = 1.2
        case 2: levelDuration = 1.0
        case 3: levelDuration = 0.6
        case 4: levelDuration = 0.4
        case 5: levelDuration = 0.2
        default:
            levelDuration = 0.5
            print("Cannot find level info")
        }
        
        // This tells the game to spawn an enemy
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningEnemies")
        
        
        
    }
    
    // This tells the game to spawn an explosion, if an enemy is hit by something
    func spawnExplosion(_ spawnPosition: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    // This tells the game to fire a bullet, if a user fires a bullet
    func fireBullet() {
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.name = "Bullet"
        bullet.setScale(0.5)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    
    // This is to spawn an enemy for the game, and what the enemy looks like
    func spawnEnemy() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.name = "Enemy"
        enemy.setScale(0.5)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
        }
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
        
        
    }
    
    
    // This is if a user were to tap on their screen or touch something
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // If a user taps anywhere on the screen before the game, the game will start
        if currentGameState == gameState.preGame {
            startGame()
        }
        
        // If a user taps anywhere on the screen during the game, the bullet will fire
        else if currentGameState == gameState.inGame {
            fireBullet()
        }
    }
    
    // This has to do with dragging the player ship
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            if currentGameState == gameState.inGame {
                player.position.x += amountDragged
            }
            
            if player.position.x > gameArea.maxX - player.size.width/2 {
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            if player.position.x < gameArea.minX + player.size.width/2 {
                player.position.x = gameArea.minX + player.size.width/2
            }
        }
    }
    
}
