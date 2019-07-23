//
//  ViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomUIButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    convenience init(normalStateButtonTitleHexColourCode: String, highlightedStateButtonTitleHexColourCode: String, buttonTitleFontName: String, buttonTitleFontSize: CGFloat, normalStateButtonTitleText: String, buttonBackgroundColourHexCode: String, buttonBackgroundColourAlphaValue: CGFloat, buttonCornerRadius: CGFloat, buttonBorderWidth: CGFloat, buttonBorderHexColourCode: String, highlightButtonWhenTapped: Bool, buttonContentHorizontalAlignment: UIControl.ContentHorizontalAlignment, buttonContentVerticalAlignment: UIControl.ContentVerticalAlignment, buttonTagValue: Int, buttonTarget: Any?, buttonSelector: Selector, normalStateButtonImage: String) {
        
        self.init()
        
        setupButtonEssentials(normalStateButtonTitleHexColourCode: normalStateButtonTitleHexColourCode, highlightedStateButtonTitleHexColourCode: highlightedStateButtonTitleHexColourCode, buttonTitleFontName: buttonTitleFontName, buttonTitleFontSize: buttonTitleFontSize, normalStateButtonTitleText: normalStateButtonTitleText, buttonBackgroundColourHexCode: buttonBackgroundColourHexCode, buttonBackgroundColourAlphaValue: buttonBackgroundColourAlphaValue, buttonCornerRadius: buttonCornerRadius, buttonBorderWidth: buttonBorderWidth, buttonBorderHexColourCode: buttonBorderHexColourCode, highlightButtonWhenTapped: highlightButtonWhenTapped, buttonContentHorizontalAlignment: buttonContentHorizontalAlignment, buttonContentVerticalAlignment: buttonContentVerticalAlignment, buttonTagValue: buttonTagValue, buttonTarget: buttonTarget, buttonSelector: buttonSelector, normalStateButtonImage: normalStateButtonImage)
        
    }
    
    func setupButtonEssentials(normalStateButtonTitleHexColourCode: String, highlightedStateButtonTitleHexColourCode: String, buttonTitleFontName: String, buttonTitleFontSize: CGFloat, normalStateButtonTitleText: String, buttonBackgroundColourHexCode: String, buttonBackgroundColourAlphaValue: CGFloat, buttonCornerRadius: CGFloat, buttonBorderWidth: CGFloat, buttonBorderHexColourCode: String, highlightButtonWhenTapped: Bool, buttonContentHorizontalAlignment: UIControl.ContentHorizontalAlignment, buttonContentVerticalAlignment: UIControl.ContentVerticalAlignment, buttonTagValue: Int, buttonTarget: Any?, buttonSelector: Selector, normalStateButtonImage: String) {
        
        setTitleColor(UIColor(hexString: normalStateButtonTitleHexColourCode), for: .normal)
        
        setTitleColor(UIColor(hexString: highlightedStateButtonTitleHexColourCode), for: .highlighted)
        
        titleLabel?.font = UIFont(name: buttonTitleFontName, size: buttonTitleFontSize)
        
        setTitle(normalStateButtonTitleText, for: .normal)
        
        backgroundColor = UIColor(hexString: buttonBackgroundColourHexCode, withAlpha: buttonBackgroundColourAlphaValue)
        
        layer.cornerRadius = buttonCornerRadius
        
        layer.borderWidth =  buttonBorderWidth
        
        layer.borderColor = UIColor(hexString: buttonBorderHexColourCode)?.cgColor
        
        showsTouchWhenHighlighted = highlightButtonWhenTapped
        
        contentHorizontalAlignment = buttonContentHorizontalAlignment
        
        contentVerticalAlignment = buttonContentVerticalAlignment
        
        self.tag = buttonTagValue
        
        addTarget(buttonTarget, action: buttonSelector, for: .touchUpInside)
        
        if let buttonImage = UIImage(named: normalStateButtonImage) {
            
            setImage(buttonImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
            contentMode = .scaleAspectFit
            
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    //    private func setShadow() {
    //
    //        layer.shadowColor = UIColor.black.cgColor
    //
    //        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
    //
    //        layer.shadowRadius = 8
    //
    //        layer.shadowOpacity = 0.5
    //
    //        clipsToBounds = true
    //
    //        layer.masksToBounds = false
    //
    //    }
    
    //    override var intrinsicContentSize: CGSize {
    //        get {
    //
    //            let baseSize = super.intrinsicContentSize
    //
    //            return CGSize(width: baseSize.width + 20, height: baseSize.height)
    //
    //        }
    //
    //    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        
        shake.duration = 0.1
        
        shake.repeatCount = 2
        
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x-8, y: center.y)
        
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x+8, y: center.y)
        
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
        
    }
    
}


