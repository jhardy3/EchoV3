//
//  EchoViewControllerViewToggleExtension.swift
//  Echo
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

extension EchoViewController {
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
}