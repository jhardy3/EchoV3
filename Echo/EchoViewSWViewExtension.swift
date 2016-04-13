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
        backgroundImage.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}