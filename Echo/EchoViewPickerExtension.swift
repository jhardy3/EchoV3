//
//  EchoViewPickerExtension.swift
//  Echo
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

extension EchoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontNames.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if let view = view as? UILabel {
            return view
        } else {
            let view = UILabel()
            view.text = fontNames[row]
            view.textColor = UIColor.whiteColor()
            view.font = UIFont(name: fontNames[row], size: 25)
            view.textAlignment = .Center
            return view
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let font = fontNames[row]
        
        let size = CGFloat(topFontSizeSlider.value)
        quoteLabel.font = UIFont(name: font, size: size)
    }

    
}