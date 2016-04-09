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

enum EditMode {
    case BoxScale
    case TextScale
    case TextFont
}

enum Dimension {
    case Height
    case Width
}


class EchoViewController: UIViewController {
    
    @IBOutlet weak var topPickerView: UIPickerView!
    @IBOutlet weak var bottomPickerView: UIPickerView!
    
    @IBOutlet weak var topJunkBarView: UIView!
    @IBOutlet weak var junkBarView: UIView!
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
    
    
    
    @IBOutlet weak var topJunkbarYConstraint: NSLayoutConstraint!
    @IBOutlet weak var junkbarYConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var bottomPickerViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPickerViewYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var quoteLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var quoteViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteViewWidth: NSLayoutConstraint!
    
    var viewMode = ViewMode.EditMode
    
    var drawerMode = DrawerMode.Bottom {
        didSet {
            moveDrawersBasedOnView()
        }
    }
    
    var editMode = EditMode.BoxScale {
        didSet {
            layoutViewBasedOnEditMode()
        }
    }
    
    private let junkBarOffsetConstant = CGFloat(80)
    private let junkBarDisplay = CGFloat(-20)
    private let junkBarHide = CGFloat(-200)
    
    private let pickerViewHide = CGFloat(-500)
    private let pickerViewDisplay = CGFloat(0)
    
    private let editBarHide = CGFloat(-200)
    private let editBarDisplay = CGFloat(0)
    
    private let animationInterval = 0.5
    private let pickerViewAnimationDuration = 0.75
    
    var buttonY: CGFloat?
    
    var quoteViewLocation: CGFloat {
        return self.view.frame.height / 2
    }
    
    var isInButton = false
    var locationInView: CGFloat?
    
    var fontNames = [String]()
    
    // MARK: View Loading Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateViewForBoxScale()
        updateViewConstraints()
        setUpView()
        
        toggleJunkView()
        toggleDrawer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func setUpView() {
        quoteLabel.layer.cornerRadius = 7.0
        quoteLabel.clipsToBounds = true
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.autoresizesSubviews = true
        
        backgroundImage.userInteractionEnabled = true
        
        hidePickerViews()
        
        
        fontNames = UIFont.familyNames().sort { $0 > $1 }
        
        firstLoad()
    }
    
    func firstLoad() {
        QuoteController.sharedInstance.firstLoad(self)
    }
    
    // MARK: IBAction Button Functions
    
    @IBAction func viewScaleButtonTapped(sender: UIButton) {
        backgroundImage.image = ImageController.sharedInstance.fetchPreviousImage()
        editMode = .BoxScale
    }
    
    @IBAction func textScaleButtonTapped(sender: UIButton) {
        editMode = .TextScale
    }
    
    @IBAction func textFontButtonTapped(sender: UIButton) {
        editMode = .TextFont
        moveDrawersBasedOnView()
    }
    
    @IBAction func shareJunkButtonTapped(sender: UIButton) {
        
        ImageUitilies.createImageWithViewOnTop(backgroundImage: backgroundImage, view: quoteView)
        
//        guard let image = ImageController.sharedInstance.fetchNextImage() else { return }
//        backgroundImage.image = image
    }
    
    // MARK: - Drawer View Functions
    
    func moveDrawersBasedOnView() {
        switch viewMode {
        case .EditMode:
            switch editMode {
            case .TextFont:
                hideDrawers()
                togglePickerView()
                toggleJunkView()
            default:
                toggleDrawer()
                hidePickerViews()
                toggleJunkView()
            }
        default:
            return
        }
    }
    
    func toggleDrawer() {
        guard let yConstraint = drawerYConstraint else { return }
        guard let yTopConstraint = topDrawerYConstraint else { return }
        
        switch drawerMode {
        case .Top:
            yConstraint.constant = editBarHide
            yTopConstraint.constant = editBarDisplay
        case .Bottom:
            yTopConstraint.constant = editBarHide
            yConstraint.constant = editBarDisplay
        }
        
        UIView.animateWithDuration(animationInterval) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
    }
    
    func togglePickerView() {
        
        guard let yBottomConstraint = bottomPickerViewYConstraint else { return }
        guard let yTopConstraint = topPickerViewYConstraint else { return }
        
        switch drawerMode {
        case .Top:
            yTopConstraint.constant = pickerViewDisplay
            yBottomConstraint.constant = pickerViewHide
            
        case .Bottom:
            yTopConstraint.constant = pickerViewHide
            yBottomConstraint.constant = pickerViewDisplay
        }
        
        UIView.animateWithDuration(pickerViewAnimationDuration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func toggleJunkView() {
        guard let topYConstraint = topJunkbarYConstraint else { return }
        guard let bottomYConstraint = junkbarYConstraint else { return }
        
        switch drawerMode {
        case .Top:
            topYConstraint.constant = junkBarHide
            bottomYConstraint.constant = junkBarDisplay
        case .Bottom:
            bottomYConstraint.constant = junkBarHide
            topYConstraint.constant = junkBarDisplay
        }
        
        UIView.animateWithDuration(animationInterval) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func hideJunkView() {
        guard let junkbarYConstraint = junkbarYConstraint else { return }
        guard let topJunkBarYConstraint = topJunkbarYConstraint else { return }
        
        topJunkBarYConstraint.constant = junkBarHide
        junkbarYConstraint.constant = junkBarHide
    }
    
    func hideDrawers() {
        guard let yConstraint = drawerYConstraint else { return }
        guard let yTopConstraint = topDrawerYConstraint else { return }
        
        yConstraint.constant = editBarHide
        yTopConstraint.constant = editBarHide
        
    }
    
    func hidePickerViews() {
        guard let yBottomConstraint = bottomPickerViewYConstraint else { return }
        guard let yTopConstraint = topPickerViewYConstraint else { return }
        
        yBottomConstraint.constant = pickerViewHide
        yTopConstraint.constant = pickerViewHide
    }
    
    // MARK: - Slider Action Functions
    
    func adjustFrameBasedOnDimension(dimension: Dimension, dimensionValue: Float) {
        let object = returnObjectForManipulation()
        switch dimension {
        case .Height:
            object.frame.size.height = CGFloat(dimensionValue)
            topHeightSlider.value = dimensionValue
            heightSlider.value = dimensionValue
        case .Width:
            object.frame.size.width = CGFloat(dimensionValue)
            topWidthSlider.value = dimensionValue
            widthSlider.value = dimensionValue
        }
        
        
        quoteView.center = view.center
        quoteLabel.center.x = quoteView.frame.width / 2
        quoteLabel.center.y = quoteView.frame.height / 2
        
        updateViewConstraints()
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func widthSliderChanged(sender: UISlider) {
        adjustFrameBasedOnDimension(.Width, dimensionValue: sender.value)
    }
    
    @IBAction func topWidthSlider(sender: UISlider) {
        adjustFrameBasedOnDimension(.Width, dimensionValue: sender.value)
    }
    
    @IBAction func heightSliderChanged(sender: UISlider) {
        adjustFrameBasedOnDimension(.Height, dimensionValue: sender.value)
    }
    
    @IBAction func topHeightSlider(sender: UISlider) {
        adjustFrameBasedOnDimension(.Height, dimensionValue: sender.value)
    }
    
    @IBAction func junkSliderChanged(sender: UISlider) {
        quoteView.alpha = CGFloat(sender.value)
    }
    
    @IBAction func topJunkSlider(sender: UISlider) {
        quoteView.alpha = CGFloat(sender.value)
    }
    
    @IBAction func toggleDrawer(sender: UITapGestureRecognizer) {
        
        switch viewMode {
        case .EditMode:
            hidePickerViews()
            hideDrawers()
            hideJunkView()
            viewMode = .ViewMode
            
        case .ViewMode:
            layoutViewBasedOnEditMode()
            viewMode = .EditMode
        }
        
        UIView.animateWithDuration(animationInterval) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - View Based On Edit Mode Functions
    
    func layoutViewBasedOnEditMode() {
        switch editMode {
        case .BoxScale:
            updateViewForBoxScale()
            hidePickerViews()
            toggleDrawer()
            toggleJunkView()
            
        case .TextFont:
            updateViewForTextFont()
            hideDrawers()
            togglePickerView()
            toggleJunkView()
            
        case.TextScale:
            updateViewForTextScale()
            hidePickerViews()
            toggleDrawer()
            toggleJunkView()
        }
    }
    
    func returnConstraints() -> (constraintX: NSLayoutConstraint, constraintY: NSLayoutConstraint)? {
        switch editMode {
        case .BoxScale:
            return (quoteViewWidth, quoteViewHeight)
        case .TextScale :
            return (quoteLabelWidth, quoteLabelWidth)
        default :
            return nil
        }
    }
    
    func returnDimensions() -> (height: CGFloat, width: CGFloat) {
        switch editMode {
        case .BoxScale:
            return (quoteView.frame.height, quoteView.frame.width)
        default:
            return (quoteLabel.frame.height, quoteLabel.frame.width)
        }
    }
    
    func returnObjectForManipulation() -> UIView {
        switch editMode {
        case .BoxScale:
            return quoteView
        default:
            return quoteLabel
        }
    }
    
    func updateSlidersWithView(view: UIView) {
        widthSlider.maximumValue = Float(self.view.frame.width)
        widthSlider.value = Float(view.frame.width)
        heightSlider.maximumValue = Float(self.view.frame.height)
        heightSlider.value = Float(view.frame.height)
        junkSlider.maximumValue = 1.0
        junkSlider.value = Float(view.alpha)
        
        widthSlider.minimumValue = 30
        heightSlider.minimumValue = 30
        junkSlider.minimumValue = 0.0
        
        topWidthSlider.maximumValue = Float(self.view.frame.width)
        topWidthSlider.value = Float(view.frame.width)
        topHeightSlider.maximumValue = Float(self.view.frame.height)
        topHeightSlider.value = Float(view.frame.height)
        topJunkSlider.maximumValue = 1.0
        topJunkSlider.value = Float(view.alpha)
        
        topWidthSlider.minimumValue = 30
        topHeightSlider.minimumValue = 30
        topJunkSlider.minimumValue = 0.0
    }
    
    func updateViewForBoxScale() {
        updateSlidersWithView(quoteView)
    }
    
    func updateViewForTextFont() {
        //        updateSlidersWithView(quoteLabel)
    }
    
    func updateViewForTextScale() {
        updateSlidersWithView(quoteLabel)
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
            
            let topMargin = quoteView.frame.maxY
            let bottomMargin = view.frame.height / 0.8 - quoteView.frame.minY
            
            if topMargin < bottomMargin && drawerMode == .Top  {
                drawerMode = .Bottom
            } else if bottomMargin < topMargin && drawerMode == .Bottom {
                drawerMode = .Top
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
        
        let constraints = returnConstraints()
        
        guard let xConstraint = constraints?.constraintX else { return }
        guard let yConstraint = constraints?.constraintY else { return }
        
        let dimensions = returnDimensions()
        
        let height = dimensions.height
        let width = dimensions.width
        
        
        xConstraint.constant = width
        yConstraint.constant = height
        
    }
}
