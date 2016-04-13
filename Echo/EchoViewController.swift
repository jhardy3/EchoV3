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
    
    
    
    @IBOutlet weak var bottomBoxSquareButton: UIButton!
    @IBOutlet weak var bottomTextEditBoxButton: UIButton!
    @IBOutlet weak var bottomTextEditButton: UIButton!
    @IBOutlet weak var bottomShareButton: UIButton!
    
    @IBOutlet weak var topBoxSquareButton: UIButton!
    @IBOutlet weak var topTextEditBoxButton: UIButton!
    @IBOutlet weak var topTextEditButton: UIButton!
    @IBOutlet weak var topShareButton: UIButton!
    
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
    
    @IBOutlet weak var topFontSizeSlider: UISlider!
    @IBOutlet weak var bottomFontSizeSlider: UISlider!
    
    @IBOutlet weak var topJunkbarYConstraint: NSLayoutConstraint!
    @IBOutlet weak var junkbarYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomPickerViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPickerViewYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var quoteLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var quoteViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteViewWidth: NSLayoutConstraint!
    
    var viewMode = ViewMode.EditMode {
        didSet {
            layoutViewBasedOnViewMode()
        }
    }
    
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
    
    var currentFontSize = 20.0
    
    private let junkBarOffsetConstant = CGFloat(80)
    private let junkBarDisplay = CGFloat(-20)
    private let junkBarHide = CGFloat(-200)
    
    private let pickerViewHide = CGFloat(-500)
    private let pickerViewDisplay = CGFloat(0)
    
    private let editBarHide = CGFloat(-200)
    private let editBarDisplay = CGFloat(0)
    
    private let extraBufferSpace = Float(100)
    
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
        
        setUpView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = true
        quoteView.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setUpView() {
        updateViewConstraints()
        
        NotificationController.createNotification("Check out the quote of the day!", alertTitle: "Echo", timeIntervalInSeconds: 86400)
        
        quoteLabel.layer.cornerRadius = 7.0
        quoteLabel.clipsToBounds = true
        quoteLabel.adjustsFontSizeToFitWidth = false
        quoteLabel.autoresizesSubviews = true
        
        backgroundImage.userInteractionEnabled = true
        quoteView.userInteractionEnabled = true
        
        hidePickerViews()
        
        
        fontNames = UIFont.familyNames().sort { $0 < $1 }
        
        firstLoad()
        
        topFontSizeSlider.value = 20
        bottomFontSizeSlider.value = 20
        
        toggleJunkView()
        toggleDrawer()
        
        setUpSWView()
        
        topFontSizeSlider.minimumValueImage = UIImage(named: "C")?.imageWithColor(UIColor.whiteColor())
        bottomFontSizeSlider.minimumValueImage = UIImage(named: "C")?.imageWithColor(UIColor.whiteColor())
        
        
        updateSlidersWithView(quoteView)
        
        topBoxSquareButton.setImage(UIImage(named: "BoxEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        bottomBoxSquareButton.setImage(UIImage(named: "BoxEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        
        topTextEditBoxButton.setImage(UIImage(named: "TextBoxEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        bottomTextEditBoxButton.setImage(UIImage(named: "TextBoxEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        
        topTextEditButton.setImage(UIImage(named: "TextEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        bottomTextEditButton.setImage(UIImage(named: "TextEditMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        
        topShareButton.setImage(UIImage(named: "ShareMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        bottomShareButton.setImage(UIImage(named: "ShareMode")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
    
    }
    
    func firstLoad() {
        QuoteController.sharedInstance.firstLoad(self)
    }
    
    // MARK: IBAction Button Functions
    
    @IBAction func viewScaleButtonTapped(sender: UIButton) {
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
        displayActivityController()
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
            view.bringSubviewToFront(topDrawerView)
        case .Bottom:
            yTopConstraint.constant = editBarHide
            yConstraint.constant = editBarDisplay
            view.bringSubviewToFront(drawerView)
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
            view.bringSubviewToFront(topPickerView)
            
        case .Bottom:
            yTopConstraint.constant = pickerViewHide
            yBottomConstraint.constant = pickerViewDisplay
            view.bringSubviewToFront(bottomPickerView)
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
            view.bringSubviewToFront(junkBarView)
        case .Bottom:
            bottomYConstraint.constant = junkBarHide
            topYConstraint.constant = junkBarDisplay
            view.bringSubviewToFront(topJunkBarView)
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
    
    
    // MARK: - Swipe Functions
    
    @IBAction func forwardSwipeGestureFired(sender: UISwipeGestureRecognizer) {
        if sender.direction == .Left && viewMode == .ViewMode {
            guard let image = ImageController.sharedInstance.fetchNextImage() else { return }
            backgroundImage.image = image
        }
    }
    
    @IBAction func backwardSwipeGestureFired(sender: UISwipeGestureRecognizer) {
        if sender.direction == .Right && viewMode == .ViewMode {
            backgroundImage.image = ImageController.sharedInstance.fetchPreviousImage()
        }
    }
    
    @IBAction func forwardSwipeQuoteFired(sender: UISwipeGestureRecognizer) {
        if viewMode != .EditMode {
            QuoteController.sharedInstance.fetchNextQuote()
        }
    }
    
    @IBAction func bakcwardSwipeQuoteFired(sender: UISwipeGestureRecognizer) {
        if viewMode != .EditMode {
            QuoteController.sharedInstance.fetchPreviousQuote()
        }
    }
    
    @IBAction func topFontSizeSliderFired(sender: UISlider) {
        let colorValue = sender.value / 255
        bottomFontSizeSlider.value = sender.value
        let color = UIColor(colorLiteralRed: colorValue, green: colorValue, blue: colorValue, alpha: 1.0)
        quoteLabel.textColor = color
        
    }
    
    @IBAction func bottomFontSizeSliderFired(sender: UISlider) {
        let colorValue = sender.value / 255
        topFontSizeSlider.value = sender.value
        let color = UIColor(colorLiteralRed: colorValue, green: colorValue, blue: colorValue, alpha: 1.0)
        quoteLabel.textColor = color
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
        
        switch editMode {
            
        case .BoxScale:
            quoteView.backgroundColor = quoteView.backgroundColor?.colorWithAlphaComponent(CGFloat(sender.value))
            topJunkSlider.value = sender.value
            
        case .TextScale:
            let fontName = quoteLabel.font.fontName
            let fontSize = CGFloat(sender.value)
            quoteLabel.font = UIFont(name: fontName, size: fontSize)
            bottomFontSizeSlider.value = sender.value
            currentFontSize = Double(sender.value)
            
            UIView.animateWithDuration(animationInterval) {
                self.view.layoutIfNeeded()
            }
        default:
            return
        }
    }
    
    @IBAction func topJunkSlider(sender: UISlider) {
        
        switch editMode {
            
        case .BoxScale:
            quoteView.backgroundColor = quoteView.backgroundColor?.colorWithAlphaComponent(CGFloat(sender.value))
            junkSlider.value = sender.value
            
        case .TextScale:
            let fontName = quoteLabel.font.fontName
            let fontSize = CGFloat(sender.value)
            quoteLabel.font = UIFont(name: fontName, size: fontSize)
            topFontSizeSlider.value = sender.value
            currentFontSize = Double(sender.value)
            
            UIView.animateWithDuration(animationInterval) {
                self.view.layoutIfNeeded()
            }
        default:
            return
        }
    }
    @IBAction func toggleViewModeInQuoteView(sender: UITapGestureRecognizer) {
        
        switch viewMode {
        case .EditMode:
            viewMode = .ViewMode
            
        case .ViewMode:
            viewMode = .EditMode
        }
        
        UIView.animateWithDuration(animationInterval) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func toggleDrawer(sender: UITapGestureRecognizer) {
        
        switch viewMode {
        case .EditMode:
            viewMode = .ViewMode
            
        case .ViewMode:
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
            updateSlidersWithView(quoteView)
            hidePickerViews()
            toggleDrawer()
            toggleJunkView()
            
        case .TextFont:
            hideDrawers()
            togglePickerView()
            toggleJunkView()
            
        case.TextScale:
            updateSlidersWithView(quoteLabel)
            hidePickerViews()
            toggleDrawer()
            toggleJunkView()
        }
    }
    
    func layoutViewBasedOnViewMode() {
        switch viewMode {
        case .ViewMode:
            hidePickerViews()
            hideDrawers()
            hideJunkView()
            
        case .EditMode:
            layoutViewBasedOnEditMode()
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
        widthSlider.maximumValue = Float(self.view.frame.width) + extraBufferSpace
        widthSlider.value = Float(view.frame.width)
        heightSlider.maximumValue = Float(self.view.frame.height) + extraBufferSpace
        heightSlider.value = Float(view.frame.height)
        
        widthSlider.minimumValue = 30
        heightSlider.minimumValue = 30
        
        widthSlider.minimumValueImage = UIImage(named: "W")?.imageWithColor(UIColor.whiteColor())
        heightSlider.minimumValueImage = UIImage(named: "H")?.imageWithColor(UIColor.whiteColor())
        
        topWidthSlider.maximumValue = Float(self.view.frame.width) + extraBufferSpace
        topWidthSlider.value = Float(view.frame.width)
        topHeightSlider.maximumValue = Float(self.view.frame.height) + extraBufferSpace
        topHeightSlider.value = Float(view.frame.height)
        
        topWidthSlider.minimumValueImage = UIImage(named: "W")?.imageWithColor(UIColor.whiteColor())
        topHeightSlider.minimumValueImage = UIImage(named: "H")?.imageWithColor(UIColor.whiteColor())
        
        
        
        topWidthSlider.minimumValue = 30
        topHeightSlider.minimumValue = 30
        
        topFontSizeSlider.maximumValue = 255.0
        topFontSizeSlider.minimumValue = 0.0
        
        bottomFontSizeSlider.maximumValue = 255.0
        topFontSizeSlider.minimumValue = 0.0
        
        topFontSizeSlider.value = 254.0
        bottomFontSizeSlider.value = 254.0
        
        
        
        switch editMode {
        case .BoxScale:
            junkSlider.maximumValue = 1.0
            junkSlider.value = Float(view.alpha)
            junkSlider.minimumValue = 0.0
            
            topJunkSlider.maximumValue = 1.0
            topJunkSlider.value = Float(view.alpha)
            topJunkSlider.minimumValue = 0.0
            
            junkSlider.minimumValueImage = UIImage(named: "O")?.imageWithColor(UIColor.whiteColor())
            topJunkSlider.minimumValueImage = UIImage(named: "O")?.imageWithColor(UIColor.whiteColor())
            
        case .TextScale:
            junkSlider.maximumValue = 60
            junkSlider.minimumValue = 6
            junkSlider.value = 20
            
            topJunkSlider.maximumValue = 60
            topJunkSlider.minimumValue = 6
            topJunkSlider.value = 20
            
            junkSlider.minimumValueImage = UIImage(named: "S")?.imageWithColor(UIColor.whiteColor())
            topJunkSlider.minimumValueImage = UIImage(named: "S")?.imageWithColor(UIColor.whiteColor())
            
        default:
            break
        }
    }
    
    // MARK: - Touch Functions
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let location = touches.first?.preciseLocationInView(quoteView) else { return }
        
        if quoteView.pointInside(location, withEvent: event) && viewMode == .EditMode {
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
