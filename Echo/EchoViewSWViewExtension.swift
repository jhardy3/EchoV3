//
//  EchoViewSWViewExtension.swift
//  Echo
//
//  Created by Jake Hardy on 4/12/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

extension EchoViewController {
    
    func setUpSWView() {
        switch viewMode {
        case .EditMode:
            backgroundImage.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        case .ViewMode:
            backgroundImage.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
}