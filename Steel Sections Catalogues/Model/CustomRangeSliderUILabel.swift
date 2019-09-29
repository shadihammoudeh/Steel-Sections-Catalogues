//
//  CustomRangeSliderUILabel.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/8/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomRangeSliderUILabel: UILabel {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(textToDisplay: String, textFontName: String, textFontSize: CGFloat, textHexColourCode: String) {
        
        self.init()
        
        setupLabel(textToDisplay: textToDisplay, textFontName: textFontName, textFontSize: textFontSize, textHexColourCode: textHexColourCode)
        
    }
    
    convenience init(attributedStringFontName: String, attributedStringFontSize: CGFloat, attributedStringFontHexColourCode: String, textToDisplay: String, subOrSuperScriptFontName: String, subOrSuperScriptFontSize: CGFloat, subOrSuperScriptLocation: Int) {
        
        self.init()
        
        setupSubOrSuperScriptLettersInTitle(attributedStringFontName: attributedStringFontName, attributedStringFontSize: attributedStringFontSize, attributedStringFontHexColourCode: attributedStringFontHexColourCode, textToDisplay: textToDisplay, subOrSuperScriptFontName: subOrSuperScriptFontName, subOrSuperScriptFontSize: subOrSuperScriptFontSize, subOrSuperScriptLocation: subOrSuperScriptLocation)
        
    }
    
    func setupLabel(textToDisplay: String, textFontName: String, textFontSize: CGFloat, textHexColourCode: String) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .left
        
        numberOfLines = 0
        
        layer.borderWidth = 1.0
        
        layer.borderColor = UIColor.black.cgColor
        
        font = UIFont(name: textFontName, size: textFontSize)
        
        textColor = UIColor(hexString: textHexColourCode)
        
        text = textToDisplay
        
    }
    
    func setupSubOrSuperScriptLettersInTitle(attributedStringFontName: String, attributedStringFontSize: CGFloat, attributedStringFontHexColourCode: String, textToDisplay: String, subOrSuperScriptFontName: String, subOrSuperScriptFontSize: CGFloat, subOrSuperScriptLocation: Int) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1.0
        
        numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: attributedStringFontName, size: attributedStringFontSize),
            
            .foregroundColor: UIColor(hexString: attributedStringFontHexColourCode),
            
            .paragraphStyle: paragraphStyle
            
        ]
        
        let attributedString = NSMutableAttributedString(string: textToDisplay, attributes: attributes)
        
        attributedString.setAttributes([.font: UIFont(name: subOrSuperScriptFontName, size: subOrSuperScriptFontSize), .baselineOffset: -3, .foregroundColor: UIColor(hexString: attributedStringFontHexColourCode)], range: NSRange(location: subOrSuperScriptLocation,length: 1))
        
        attributedText = attributedString
        
    }
    

}
