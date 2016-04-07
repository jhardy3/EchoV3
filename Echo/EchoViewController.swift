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
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var drawerYConstraint: NSLayoutConstraint!
    
    var drawerShown = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func previousPictureTapped(sender: UIButton) {
        backgroundImage.image = ImageController.sharedInstance.fetchPreviousImage()
    }
    
    @IBAction func customTextButtonTapped(sender: UIButton) {
    }
    
    @IBAction func shareButtonTapped(sender: UIButton) {
    }
    
    @IBAction func nextPictureButtonTapped(sender: UIButton) {
        guard let image = ImageController.sharedInstance.fetchNextImage() else { return }
        backgroundImage.image = image
    }
    
    
    @IBAction func toggleDrawer(sender: UITapGestureRecognizer) {
        guard let yConstraint = drawerYConstraint else { return }
        view.layoutIfNeeded()
        if drawerShown {
            yConstraint.constant = 0
        } else {
            yConstraint.constant = -80
        }
        
        UIView.animateWithDuration(0.75) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        drawerShown = !drawerShown
    }
    
    func firstLoad() {
        QuoteController.sharedInstance.firstLoad(self)
    }
    
    func setUpView() {
        quoteLabel.layer.cornerRadius = 7.0
        quoteLabel.clipsToBounds = true
        backgroundImage.userInteractionEnabled = true
        firstLoad()
    }
}
