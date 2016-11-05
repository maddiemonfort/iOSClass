//
//  GameScene.swift
//  MickeySAGame
//
//  Created by Madeleine Monfort on 11/10/15.
//  Copyright (c) 2015 Madeleine Monfort. All rights reserved.
//

import SpriteKit
import AVFoundation

struct GamePhysics {
    static let Enemy: UInt32 = 1
    static let Mickey: UInt32 = 2
    static let Bucket: UInt32 = 3
    static let Friends: UInt32 = 4
    static let Floor: UInt32 = 5
    static let All: UInt32 = 6
    static let None: UInt32 = 0
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode();
    let backgroundTexture = SKTexture(imageNamed: "background.png");
    
    var mickey = SKSpriteNode();
    let mickeyTexture = SKTexture(imageNamed: "mickey2.png");
    
    var puddle = SKSpriteNode()
    let puddleTexture = SKTexture(imageNamed: "puddle.gif")
    
    var bucket = SKSpriteNode()
    let bucketTexture = SKTexture(imageNamed: "bucket.png")
    
    var score = 0
    var lives = 3
    var scoreLabel = SKLabelNode()
    var goal = 10
    var goalLabel = SKLabelNode()
    
    var music = AVAudioPlayer()
    let musicPath = NSBundle.mainBundle().pathForResource("Sorcerer'sApprenticeTheme", ofType: "mp3")
    
    var fallSpeed = -30
    
    var gameOver = false
    var didWin = false
    
    
    override func didMoveToView(view: SKView) {
        restart(view)
        
    }
    
    func restart(view: SKView) {
        playMusic()
        score = 0
        lives = 3
        addBackground()
        addMickey()
        addLine()
        addPuddle()
        addScore()
        addWalls()
        addSwipeGestures(view)
        self.physicsWorld.contactDelegate = self
    }
    
    func addBackground() {
        background = SKSpriteNode(texture: backgroundTexture)
        background.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        background.size.height = self.frame.height
        background.size.width = self.frame.width
        background.zPosition = -10
        self.addChild(background)
    }
    
    func addMickey() {
        mickey = SKSpriteNode(texture: mickeyTexture)
        mickey.size.height = mickeyTexture.size().height/3
        mickey.size.width = mickeyTexture.size().width/3
        mickey.position = CGPoint(x: CGRectGetMidX(self.frame), y: 110)
        mickey.zPosition = 0
        
        mickey.physicsBody = SKPhysicsBody(rectangleOfSize: mickey.size)
        mickey.physicsBody?.categoryBitMask = GamePhysics.Mickey
        mickey.physicsBody?.collisionBitMask = GamePhysics.Bucket
        mickey.physicsBody?.contactTestBitMask = GamePhysics.Enemy
        mickey.physicsBody?.dynamic = true
        self.addChild(mickey)
    }
    
    func addBucket() {
        bucket = SKSpriteNode(texture: bucketTexture)
        bucket.zPosition = 5
        bucket.position = CGPoint(x: mickey.position.x, y: mickey.position.y)
        bucket.hidden = true
        
        bucket.physicsBody = SKPhysicsBody(rectangleOfSize: bucket.size)
        bucket.physicsBody?.categoryBitMask = GamePhysics.Bucket
        bucket.physicsBody?.collisionBitMask = GamePhysics.Friends
        bucket.physicsBody?.contactTestBitMask = GamePhysics.Enemy
        bucket.physicsBody?.dynamic = true
        
        self.addChild(bucket)
    }
    
    func addLine() {
        let line = SKNode()
        line.zPosition = -5
        let xCoord = CGRectGetMidX(self.frame)
        let yCoord = mickey.position.y - mickey.size.height/2
        line.position = CGPoint(x: xCoord, y: yCoord)
        
        line.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.width, height: mickey.position.y - mickey.size.height/2))
        line.physicsBody?.categoryBitMask = GamePhysics.Floor
        line.physicsBody?.dynamic = false
        self.addChild(line)
    }
    
    func addPuddle() {
        puddle = SKSpriteNode(texture: puddleTexture)
        puddle.size.height = puddleTexture.size().height/6
        puddle.size.width = puddleTexture.size().width/6
        
        let xmax = UInt32(CGRectGetMidX(self.frame)-100)
        let xCoord = CGFloat(arc4random() % xmax) + 300
        puddle.position = CGPoint(x: xCoord, y: CGRectGetMaxY(self.frame) - puddle.size.height/2)
        puddle.zPosition = 0
        
        puddle.physicsBody = SKPhysicsBody(rectangleOfSize: puddle.size)
        puddle.physicsBody?.categoryBitMask = GamePhysics.Enemy
        puddle.physicsBody?.contactTestBitMask = GamePhysics.Bucket | GamePhysics.Mickey
        puddle.physicsBody?.dynamic = true
        
        puddle.physicsBody?.affectedByGravity = false //falls too quickly, want to set that myself
        let puddleFall = SKAction.runBlock(fall)
        puddle.runAction(puddleFall)
        
        self.addChild(puddle)
    }
    
    func fall() {
        puddle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: fallSpeed))
    }
    
    func addScore() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.text = "Score: \(score)\tLives: \(lives)"
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame) + 30)
        scoreLabel.zPosition = 0
        self.addChild(scoreLabel)
        
        goalLabel = SKLabelNode(fontNamed: "Chalkduster")
        goalLabel.fontSize = 25
        goalLabel.fontColor = UIColor.blackColor()
        goalLabel.text = "Goal: \(goal)"
        goalLabel.position = CGPoint(x: CGRectGetMaxX(self.frame) - 370, y: CGRectGetMaxY(self.frame) - 30)
        goalLabel.zPosition = 5
        self.addChild(goalLabel)
    }
    
    func addWalls() {
        let wallL = SKNode()
        let wallR = SKNode()
        
        wallL.position = CGPoint(x: 0, y: CGRectGetMidY(self.frame))
        wallR.position = CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMidY(self.frame))
        
        wallL.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 400, height: self.frame.height))
        wallR.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 400, height: self.frame.height))
        
        wallL.physicsBody?.dynamic = false
        wallR.physicsBody?.dynamic = false
        
        wallL.physicsBody?.categoryBitMask = GamePhysics.Floor
        wallR.physicsBody?.categoryBitMask = GamePhysics.Floor
        
        self.addChild(wallL)
        self.addChild(wallR)
    }
    
    //-----------------------ADD GAME LOGIC HERE------------------------------------------------------!!!!!!!!!!!!!!
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node
        let obj1 = firstNode!.physicsBody
        let obj2 = secondNode!.physicsBody
        
        //dealing only with mickey-puddle and puddle-bucket contact
        if(obj1?.categoryBitMask != GamePhysics.Floor && obj2?.categoryBitMask != GamePhysics.Floor) {
            //contact between Mickey and Puddle
            if((obj1?.categoryBitMask == GamePhysics.Enemy && obj2?.categoryBitMask == GamePhysics.Mickey) || (obj1?.categoryBitMask == GamePhysics.Mickey && obj2?.categoryBitMask == GamePhysics.Enemy)) {
                if(obj1?.categoryBitMask == GamePhysics.Enemy) {
                    firstNode!.removeFromParent()
                }
                else {
                    secondNode!.removeFromParent()
                }
                addPuddle()
                lives--;
            }
            //contact between Bucket and Puddle
            if((obj1?.categoryBitMask == GamePhysics.Enemy && obj2?.categoryBitMask == GamePhysics.Bucket) || (obj1?.categoryBitMask == GamePhysics.Bucket && obj2?.categoryBitMask == GamePhysics.Enemy)) {
                firstNode!.removeFromParent()
                secondNode!.removeFromParent()
                score++;
                addPuddle()
            }
            //edit score label
            scoreLabel.text = "Score: \(score)\tLives: \(lives)"
            
            //game over logic
            if lives == 0 {
                gameOver = true
                didWin = false
            }
            if score == goal {
                gameOver = true
                didWin = true
            }
            
            
            if gameOver {
                //stop game
                pauseGame()
                let GameOverLabel = SKLabelNode(fontNamed: "Comic Sans")
                GameOverLabel.fontSize = 40
                GameOverLabel.zPosition = 10
                GameOverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                
                //if lost:
                if !didWin {
                    //have option to restart game
                    //display end score
                    GameOverLabel.text = "You Lost."
                }
                    //if won:
                else {
                    //display end score
                    GameOverLabel.text = "Congrats! You won!"
                    //have option to continue to next level
                }
                
                
                self.addChild(GameOverLabel)
            }
            
        }
        
        //contact of puddle and floor
        if((obj1?.categoryBitMask == GamePhysics.Floor && obj2?.categoryBitMask == GamePhysics.Enemy) || (obj1?.categoryBitMask == GamePhysics.Enemy && obj2?.categoryBitMask == GamePhysics.Floor)) {
            if(obj1?.categoryBitMask == GamePhysics.Enemy) {
                firstNode!.removeFromParent()
            }
            else {
                secondNode!.removeFromParent()
            }
            addPuddle()
        }
        
    }
    
    func pauseGame() {
        //stop the action
        self.removeAllActions()
        puddle.removeAllActions()
        mickey.removeAllActions()
        self.physicsWorld.contactDelegate = nil
        music.stop()
    }
    
    func addSwipeGestures(view: SKView) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeRight)
    }
    
    func swiped(gesture: UISwipeGestureRecognizer) {
        if(gesture.direction == UISwipeGestureRecognizerDirection.Left) {
            //make mickey move left some amount
            mickey.physicsBody?.applyImpulse(CGVector(dx: -200, dy: 0))
        }
        
        if(gesture.direction == UISwipeGestureRecognizerDirection.Right) {
            //make mickey move right same amount
            mickey.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 0))
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if !gameOver {
            addBucket()
            
            let show = SKAction.unhide()
            let launch = SKAction.moveTo(CGPoint(x: bucket.position.x, y: bucket.position.y+600), duration: 0.5)
            let dissappear = SKAction.hide()
            let remove = SKAction.removeFromParent() //Parent is Game view
            
            let launchSequence = SKAction.sequence([show, launch, dissappear, remove])
            bucket.runAction(launchSequence)
        }
        else {
            //register touches to choose stuff
        }
        
    }
    
    func playMusic() {
        do {
            try music = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: musicPath!))
            music.play()
        }
        catch {
            print("Something really bad happened")
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
