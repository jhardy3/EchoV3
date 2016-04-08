//
//  EchoViewController.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

enum ViewMode {
    case EditMode
    case ViewMode
}

enum DrawerMode {
    case Top
    case Bottom
}

class EchoViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var drawerYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topDrawerView: UIView!
    @IBOutlet weak var topDrawerYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var junkSlider: UISlider!
    
    @IBOutlet weak var topWidthSlider: UISlider!
    @IBOutlet weak var topHeightSlider: UISlider!
    @IBOutlet weak var topJunkSlider: UISlider!
    
    @IBOutlet weak var quoteLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var quoteViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteViewWidth: NSLayoutConstraint!
    
    var viewIsLoaded = false
    var viewMode = ViewMode.EditMode
    var drawerMode = DrawerMode.Bottom {
        didSet {
            moveDrawersBasedOnView()
        }
    }
    
    var animationInterval = 0.5
    
    var drawerShown = true
    var buttonY: CGFloat?
    
    var quoteViewLocation: CGFloat {
        return self.view.frame.height / 2
    }
    
    var isInButton = false
    var locationInView: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthSlider.maximumValue = Float(self.view.frame.width)
        widthSlider.value = Float(quoteView.frame.width)
        heightSlider.maximumValue = Float(self.view.frame.height)
        heightSlider.value = Float(quoteView.frame.height)
        junkSlider.maximumValue = 1.0
        junkSlider.value = Float(quoteView.alpha)
        
        widthSlider.minimumValue = 30
        heightSlider.minimumValue = 30
        junkSlider.minimumValue = 0.0
        
        topWidthSlider.maximumValue = Float(self.view.frame.width)
        topWidthSlider.value = Float(quoteView.frame.width)
        topHeightSlider.maximumValue = Float(self.view.frame.height)
        topHeightSlider.value = Float(quoteView.frame.height)
        topJunkSlider.maximumValue = 1.0
        topJunkSlider.value = Float(quoteView.alpha)
        
        topWidthSlider.minimumValue = 30
        topHeightSlider.minimumValue = 30
        topJunkSlider.minimumValue = 0.0
        
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.autoresizesSubviews = true
        
        setUpView()
        toggleTopDrawer()
        
        viewIsLoaded = true
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
    
    func moveDrawersBasedOnView() {
        switch viewMode {
        case .EditMode:
            moveDrawers()
        default:
            return
        }
    }
    
    func moveDrawers() {
        switch drawerMode {
        case .Bottom:
            toggleTopDrawer()
            toggleBottomDrawer()
        case .Top:
            toggleBottomDrawer()
            toggleTopDrawer()
        }
    }
    
    func toggleBottomDrawer() {
        guard let yConstraint = drawerYConstraint else { return }
//        view.layoutIfNeeded()
        
        switch drawerMode {
        case .Top:
            yConstraint.constant = -200
        case .Bottom:
            yConstraint.constant = 0
        }
        
        UIView.animateWithDuration(0.75) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
    }
    
    func toggleTopDrawer() {
        guard let yConstraint = topDrawerYConstraint else { return }
//        view.layoutIfNeeded()
        switch drawerMode {
        case .Top:
            yConstraint.constant = 0
        case .Bottom:
            yConstraint.constant = -200
        }
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func widthSliderChanged(sender: UISlider) {
        quoteView.frame.size.width = CGFloat(sender.value)
        quoteLabel.frame.size.height = CGFloat(sender.value)
        quoteView.center = view.center
        quoteLabel.center.x = quoteView.frame.width / 2
        quoteLabel.center.y = quoteView.frame.height / 2
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
    
//        view.layoutIfNeeded()
        
    }
    
    @IBAction func topWidthSlider(sender: UISlider) {
        quoteView.frame.size.width = CGFloat(sender.value)
        quoteLabel.frame.size.height = CGFloat(sender.value)
        quoteView.center = view.center
        quoteLabel.center.x = quoteView.frame.width / 2
        quoteLabel.center.y = quoteView.frame.height / 2
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func heightSliderChanged(sender: UISlider) {
        quoteView.frame.size.height = CGFloat(sender.value)
        quoteLabel.frame.size.height = CGFloat(sender.value)
        quoteView.center = view.center
        quoteLabel.center.x = quoteView.frame.width / 2
        quoteLabel.center.y = quoteView.frame.height / 2
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }

//        view.layoutIfNeeded()
    }
    
    @IBAction func topHeightSlider(sender: UISlider) {
        quoteView.frame.size.height = CGFloat(sender.value)
        quoteLabel.frame.size.height = CGFloat(sender.value)
        quoteView.center = view.center
        quoteLabel.center.x = quoteView.frame.width / 2
        quoteLabel.center.y = quoteView.frame.height / 2
        
        UIView.animateWithDuration(animationInterval) { 
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func junkSliderChanged(sender: UISlider) {
        quoteView.alpha = CGFloat(sender.value)
    }
    
    @IBAction func topJunkSlider(sender: UISlider) {
        quoteView.alpha = CGFloat(sender.value)
    }
    
    @IBAction func toggleDrawer(sender: UITapGestureRecognizer) {
        guard let yConstraint = drawerYConstraint else { return }
        updateViewConstraints()
        view.layoutIfNeeded()
        guard let topYConstraint = topDrawerYConstraint else { return }
        
        switch viewMode {
            
        case .EditMode:
            switch drawerMode {
            case .Top:
                topYConstraint.constant = -200
            case .Bottom:
                yConstraint.constant = -200
            }
            viewMode = .ViewMode
        case .ViewMode:
            switch drawerMode {
            case .Top:
                topYConstraint.constant = 0
            case .Bottom:
                yConstraint.constant = 0
            }
            viewMode = .EditMode
        }
        
        UIView.animateWithDuration(animationInterval) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    func setUpView() {
        quoteLabel.layer.cornerRadius = 7.0
        quoteLabel.clipsToBounds = true
        backgroundImage.userInteractionEnabled = true
        firstLoad()
    }
    
    func firstLoad() {
        QuoteController.sharedInstance.firstLoad(self)
    }
    
    
    // MARK: - Touch Functions
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let location = touches.first?.preciseLocationInView(quoteView) else { return }
        
        if quoteView.pointInside(location, withEvent: event) {
            locationInView = location.y
            isInButton = true
        } else {
            isInButton = false
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isInButton {
            
            guard let totalYMovement = touches.first?.preciseLocationInView(self.view).y,
                locationInView = self.locationInView else { return }
            
            if viewIsLoaded {
                
                let topMargin = quoteView.frame.maxY
                let bottomMargin = view.frame.height / 0.7 - quoteView.frame.minY
                
                if topMargin < bottomMargin && drawerMode == .Top  {
                    drawerMode = .Bottom
                } else if bottomMargin < topMargin && drawerMode == .Bottom {
                    drawerMode = .Top
                }
//                
//                if totalYMovement > view.frame.height / 2 && drawerMode == .Bottom {
//                    drawerMode = .Top
//                } else if totalYMovement < view.frame.height / 2 && drawerMode == .Top {
//                    drawerMode = .Bottom
//                }
            }
            
            
            var yMovement = totalYMovement - quoteViewLocation
            if locationInView >= (self.quoteView.frame.height / 2) {
                // Works!
                yMovement = yMovement - (locationInView - (self.quoteView.frame.height / 2))
            } else {
                yMovement = yMovement + ((self.quoteView.frame.height / 2) - locationInView)
            }
            
            self.quoteView.transform.ty = yMovement
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let height = quoteView.frame.height
        let width = quoteView.frame.width
        
        
        quoteViewWidth.constant = width
        quoteViewHeight.constant = height
        
        print(quoteView.constraints)
        
    }
}
