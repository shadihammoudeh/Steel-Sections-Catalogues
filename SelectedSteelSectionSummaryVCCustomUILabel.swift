//
//  SelectedSteelSectionSummaryVCCustomUILabel.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/11/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class SelectedSteelSectionSummaryVCCustomUILabel: UILabel {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupUILabel(numberOfLineToBeDisplayed: Int, rotationAngleTransformation: CGFloat, textToBeDisplayed: String, wholeTitleAttributesAssigned: Bool, attributesForTheWholeTitle: [NSMutableAttributedString.Key : Any], startingLocationForWholeTitleAttributes: Int, abbreviationLettersAttributesAssigned: Bool, attributesForAbbreviationLetters: [NSMutableAttributedString.Key : Any], startingLocationForAbbreviationLettersAttributes: Int, lengthOfAbbreviationLettersAttributes: Int, abbreviationSubscriptLettersAttributesAssigned: Bool, abbreviationSubscriptLettersAttributes: [NSMutableAttributedString.Key : Any], startingLocationForAbbreviationSubscriptLettersAttributes: Int, lengthOfAbbreviationSubscriptLettersAttributes: Int, superscriptLettersAttributesAssigned: Bool, superscriptLettersAttributes: [NSMutableAttributedString.Key : Any], startingLocationForSuperscriptLettersAttributes: Int, lengthOfSuperscriptLettersAttributes: Int) {
        
        numberOfLines = numberOfLineToBeDisplayed
        
        transform = CGAffineTransform(rotationAngle: rotationAngleTransformation)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: textToBeDisplayed)
        
        if wholeTitleAttributesAssigned == true {
            
            labelAttributedString.addAttributes(attributesForTheWholeTitle, range: NSRange(location: startingLocationForWholeTitleAttributes, length: textToBeDisplayed.count))
            
        }
        
        if abbreviationLettersAttributesAssigned == true {
            
            labelAttributedString.addAttributes(attributesForAbbreviationLetters, range: NSRange(location: startingLocationForAbbreviationLettersAttributes, length: lengthOfAbbreviationLettersAttributes))
            
        }
        
        if abbreviationSubscriptLettersAttributesAssigned == true {
            
             labelAttributedString.addAttributes(abbreviationSubscriptLettersAttributes, range: NSRange(location: startingLocationForAbbreviationSubscriptLettersAttributes, length: lengthOfAbbreviationSubscriptLettersAttributes))
            
        }
        
        if superscriptLettersAttributesAssigned == true {
            
            labelAttributedString.addAttributes(superscriptLettersAttributes, range: NSRange(location: startingLocationForSuperscriptLettersAttributes, length: lengthOfSuperscriptLettersAttributes))
            
        }
        
        attributedText = labelAttributedString
        
    }
    
}

