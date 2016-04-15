//
//  EchoViewActivityControllerExtension.swift
//  Echo
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

let TUTORIAL_KEY = "HasSeenTutorial"

extension EchoViewController {
    
    func displayActivityController() {
        guard let currentImage = ImageUitilies.createImageWithViewOnTop(backgroundImage: backgroundImage, view: quoteView) else { return }
        let activityController = UIActivityViewController(activityItems: [currentImage], applicationActivities: [])
        
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    func setupWalkthrough() {
    
        
        if !NSUserDefaults.standardUserDefaults().boolForKey(TUTORIAL_KEY) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: TUTORIAL_KEY)
            let walkthrough = LAWalkthroughViewController(view: self)
            walkthrough.view.frame = view.frame
            
            let thanksImage = UIImage(named: "THANKS")
            let toggleImage = UIImage(named: "TOGGLE")
            let textboxImage = UIImage(named: "BOX")
            let customImage = UIImage(named: "CUSTOM")
            let saveImage = UIImage(named: "SAVE")
            let swipeImage = UIImage(named: "SWIPE")
            
            let imageArray = [thanksImage, toggleImage, textboxImage, customImage, saveImage, swipeImage]
            
            for image in imageArray {
                let viewOne = UIView()
                viewOne.frame = view.frame
                let xConstraint = NSLayoutConstraint(item: viewOne, attribute: .CenterX, relatedBy: .Equal, toItem: viewOne, attribute: .CenterX, multiplier: 1, constant: 0)
                let yConstraint = NSLayoutConstraint(item: viewOne, attribute: .CenterY, relatedBy: .Equal, toItem: viewOne, attribute: .CenterY, multiplier: 1, constant: 0)
                viewOne.addConstraints([xConstraint, yConstraint])
                
                let imageView = UIImageView(frame: view.frame)
                imageView.image = image
                viewOne.addSubview(imageView)
                walkthrough.addPageWithView(viewOne)
            }
            walkthrough.nextButtonText = ""
            
            
            presentViewController(walkthrough, animated: true, completion: nil)

        }
    }
}