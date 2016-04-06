//
//  EchoViewController.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class EchoViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        QuoteController.fetchQuote { (quote) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.backgroundImage.image = quote?.image
                self.quoteLabel.text = quote?.quote
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
