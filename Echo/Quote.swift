//
//  Quote.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

class Quote {
    
    var quote: String
    var image: UIImage
    var length: String
    var author: String
    
    init(quote: String, image: UIImage, author: String, length: String) {
        self.quote = quote
        self.image = image
        self.author = author
        self.length = length
    }
        
}