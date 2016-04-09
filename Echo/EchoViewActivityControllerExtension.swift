//
//  EchoViewActivityControllerExtension.swift
//  Echo
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

extension EchoViewController {
    
    func displayActivityController() {
        guard let currentImage = ImageUitilies.createImageWithViewOnTop(backgroundImage: backgroundImage, view: quoteView) else { return }
        let activityController = UIActivityViewController(activityItems: [currentImage], applicationActivities: [])
        
        presentViewController(activityController, animated: true, completion: nil)
    }
    
}