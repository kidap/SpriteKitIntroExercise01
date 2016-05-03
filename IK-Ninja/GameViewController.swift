//
//  GameViewController.swift
//  IK-Ninja
//
//  Created by Ken Toh on 7/9/14.
//  Copyright (c) 2014 Ken Toh. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
  class func unarchiveFromFile(file : NSString) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
      do{
      var sceneData = try NSData(contentsOfFile:path, options: .DataReadingMappedIfSafe)
      var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
      }catch{
        return nil
      }
    } else {
      return nil
    }
  }
}

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

      if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
            
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
            
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
          
        // Set the view bounds dynamically
        scene.size = skView.bounds.size
          
        skView.presentScene(scene)
    }
  }

  override func shouldAutorotate() -> Bool {
    return true
  }

  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return UIInterfaceOrientationMask.AllButUpsideDown
    } else {
      return UIInterfaceOrientationMask.All
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Release any cached data, images, etc that aren't in use.
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
