//
//  CustomRangeSliderUILabel.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/8/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

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
    
    func returnedNSAttributedStringTobeDisplayedForRangeSliderTitle(rangeSliderTitle titleText: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubscriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptLetters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) -> NSAttributedString {
        
        let rangeSliderTitle: String = titleText
        
        let rangeSliderAttributedTitleString: NSMutableAttributedString = NSMutableAttributedString(string: rangeSliderTitle)
        
        let rangeSliderTitleGeneralAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!,
                
            .foregroundColor: UIColor(named: "Filter Results VC - Range Slider Title Text Colour")!,
            
        ]
        
        let rangeSliderTitleAbbrivationLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 19)!,
            
            .foregroundColor: UIColor(named: "Filter Results VC - Range Slider Title Abbreviation Letter Colour")!,
            
        ]
        
        let rangeSliderTitleSubScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: -7,
            
        ]
        
        let rangeSliderTitleSuperScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: 7,
            
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)!
            
        ]
        
        rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleGeneralAttributes, range: NSRange(location: 0, length: rangeSliderAttributedTitleString.length))

        if containsAbbreviationLetters == true && containsSubscriptLetters == false && containsSuperScriptLetters == false {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))

        } else if containsAbbreviationLetters == true && containsSubscriptLetters == true && containsSuperScriptLetters == false {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSubScriptLettersAttributes, range: NSRange(location: subScriptLettersStartingLocation, length: subScriptLettersLength))


        } else if containsAbbreviationLetters == true && containsSuperScriptLetters == true && containsSubscriptLetters == false {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSuperScriptLettersAttributes, range: NSRange(location: superScriptLettersStartingLocation, length: superScriptLettersLength))
            
        } else {
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSubScriptLettersAttributes, range: NSRange(location: subScriptLettersStartingLocation, length: subScriptLettersLength))
            
            rangeSliderAttributedTitleString.addAttributes(rangeSliderTitleSuperScriptLettersAttributes, range: NSRange(location: superScriptLettersStartingLocation, length: superScriptLettersLength))
            
        }
        
        return rangeSliderAttributedTitleString
                
    }
    
    func setupLabel(rangeSliderTitle: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubScriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptLetters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) {
                        
        textAlignment = .left
        
        numberOfLines = 0
        
        attributedText = returnedNSAttributedStringTobeDisplayedForRangeSliderTitle(rangeSliderTitle: rangeSliderTitle, containsAbbreviationLetters: containsAbbreviationLetters, abbreviationLettersStartingLocation: abbreviationLettersStartingLocation, abbreviationLettersLength: abbreviationLettersLength, containsSubscriptLetters: containsSubScriptLetters, subScriptLettersStartingLocation: subScriptLettersStartingLocation, subScriptLettersLength: subScriptLettersLength, containsSuperScriptLetters: containsSuperScriptLetters, superScriptLettersStartingLocation: superScriptLettersStartingLocation, superScriptLettersLength: superScriptLettersLength)
                
    }
    
}
