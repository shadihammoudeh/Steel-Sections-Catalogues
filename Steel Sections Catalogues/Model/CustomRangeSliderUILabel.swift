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
    
    convenience init(rangeSliderTitle: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubScriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptletters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) {
        
        self.init()
        
        setupLabel(rangeSliderTitle: rangeSliderTitle, containsAbbreviationLetters: containsAbbreviationLetters, abbreviationLettersStartingLocation: abbreviationLettersStartingLocation, abbreviationLettersLength: abbreviationLettersLength, containsSubScriptLetters: containsSubScriptLetters, subScriptLettersStartingLocation: subScriptLettersStartingLocation, subScriptLettersLength: subScriptLettersLength, containsSuperScriptLetters: containsSuperScriptletters, superScriptLettersStartingLocation: superScriptLettersStartingLocation, superScriptLettersLength: superScriptLettersLength)
        
    }
    
//    convenience init(textToDisplay: String, subOrSuperScriptLocation: Int) {
//
//        self.init()
//
//        setupSubOrSuperScriptLettersInTitle(textToDisplay: textToDisplay, subOrSuperScriptLocation: subOrSuperScriptLocation)
//
//    }
    
    func returnedNSAttributedStringTobeDisplayedForRangeSliderTitle(rangeSliderTitle titleText: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubscriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptLetters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) -> NSAttributedString {
        
        let rangeSliderTitle: String = titleText
        
        let rangeSliderAttributedTitleString: NSMutableAttributedString = NSMutableAttributedString(string: rangeSliderTitle)
        
        let rangeSliderTitleGeneralAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!,
                
            .foregroundColor: UIColor(named: "Filter Results Range Slide Title Text Colour")!,
            
        ]
        
        let rangeSliderTitleAbbrivationLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 19)!,
            
            .foregroundColor: UIColor(named: "Filter Results Range Slider Abbreviation Letters Text Colour")!,
            
        ]
        
        let rangeSliderTitleSubScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: -7,
            
        ]
        
        let rangeSliderTitleSuperScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: 7,
            
        ]
        
        rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleGeneralAttributes, range: NSRange(location: 0, length: rangeSliderAttributedTitleString.length))

        if containsAbbreviationLetters == true {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))

        } else {
            
            return rangeSliderAttributedTitleString
            
        }
        
        if containsSubscriptLetters == true {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSubScriptLettersAttributes, range: NSRange(location: subScriptLettersStartingLocation, length: subScriptLettersLength))

            
        } else {
            
            return rangeSliderAttributedTitleString
            
        }
        
        if containsSuperScriptLetters == true {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSuperScriptLettersAttributes, range: NSRange(location: superScriptLettersStartingLocation, length: superScriptLettersLength))

        } else {
            
            return rangeSliderAttributedTitleString
            
        }
        
        return rangeSliderAttributedTitleString
                
    }
    
    func setupLabel(rangeSliderTitle: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubScriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptLetters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) {
                
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .left
        
        numberOfLines = 0
        
        attributedText = returnedNSAttributedStringTobeDisplayedForRangeSliderTitle(rangeSliderTitle: rangeSliderTitle, containsAbbreviationLetters: containsAbbreviationLetters, abbreviationLettersStartingLocation: abbreviationLettersStartingLocation, abbreviationLettersLength: abbreviationLettersLength, containsSubscriptLetters: containsSubScriptLetters, subScriptLettersStartingLocation: subScriptLettersStartingLocation, subScriptLettersLength: subScriptLettersLength, containsSuperScriptLetters: containsSuperScriptLetters, superScriptLettersStartingLocation: superScriptLettersStartingLocation, superScriptLettersLength: superScriptLettersLength)
                
    }
    
//    func setupSubOrSuperScriptLettersInTitle(textToDisplay: String, subOrSuperScriptLocation: Int) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        numberOfLines = 0
//
//        let paragraphStyle = NSMutableParagraphStyle()
//
//        paragraphStyle.alignment = .left
//
//        let attributes: [NSAttributedString.Key: Any] = [
//
//            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!,
//
//            .foregroundColor: UIColor(named: "Filter Results Range Slide Title Text Colour")!,
//
//            .paragraphStyle: paragraphStyle
//
//        ]
//
//        let attributedString = NSMutableAttributedString(string: textToDisplay, attributes: attributes)
//
//        attributedString.setAttributes([.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 15)!, .baselineOffset: -7, .foregroundColor: UIColor(named: "Filter Results Range Slide Title Text Colour")!], range: NSRange(location: subOrSuperScriptLocation,length: 1))
//
//        attributedText = attributedString
//
//    }
    

}
