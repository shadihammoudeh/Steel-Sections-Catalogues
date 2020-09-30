//
//  SelectedSteelSectionSummaryVCCustomUILabel.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/11/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class SelectedSteelSectionSummaryVCCustomUILabel: UILabel {
    
    init(numberOfLineToBeDisplayed: Int, horizontalAlignmentOfTextToBeDisplayed: NSTextAlignment, rotationAngleTransformation: CGFloat, textToBeDisplayed: String, wholeTitleAttributesAssigned: Bool, attributesForTheWholeTitle: [NSAttributedString.Key : Any], startingLocationForWholeTitleAttributes: Int, abbreviationLettersAttributesAssigned: Bool, attributesForAbbreviationLetters: [NSAttributedString.Key : Any], startingLocationForAbbreviationLettersAttributes: Int, lengthOfAbbreviationLettersAttributes: Int, abbreviationSubscriptLettersFirstLocationAttributesAssigned: Bool, abbreviationSubscriptLettersFirstLocationAttributes: [NSAttributedString.Key : Any], startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes: Int, lengthOfAbbreviationSubscriptLettersFirstLocationAttributes: Int, abbreviationSubscriptLettersSecondLocationAttributesAssigned: Bool, abbreviationSubscriptLettersSecondLocationAttributes: [NSAttributedString.Key : Any], startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes: Int, lengthOfAbbreviationSubscriptLettersSecondLocationAttributes: Int, superscriptLettersAttributesAssigned: Bool, superscriptLettersAttributes: [NSAttributedString.Key : Any], startingLocationForSuperscriptLettersAttributes: Int, lengthOfSuperscriptLettersAttributes: Int) {
        
        super.init(frame: CGRect())
        
        setupUILabel(numberOfLineToBeDisplayed: numberOfLineToBeDisplayed, horizontalAlignmentOfTextToBeDisplayed: horizontalAlignmentOfTextToBeDisplayed, rotationAngleTransformation: rotationAngleTransformation, textToBeDisplayed: textToBeDisplayed, wholeTitleAttributesAssigned: wholeTitleAttributesAssigned, attributesForTheWholeTitle: attributesForTheWholeTitle, startingLocationForWholeTitleAttributes: startingLocationForWholeTitleAttributes, abbreviationLettersAttributesAssigned: abbreviationLettersAttributesAssigned, attributesForAbbreviationLetters: attributesForAbbreviationLetters, startingLocationForAbbreviationLettersAttributes: startingLocationForAbbreviationLettersAttributes, lengthOfAbbreviationLettersAttributes: lengthOfAbbreviationLettersAttributes, abbreviationSubscriptLettersFirstLocationAttributesAssigned: abbreviationSubscriptLettersFirstLocationAttributesAssigned, abbreviationSubscriptLettersFirstLocationAttributes: abbreviationSubscriptLettersFirstLocationAttributes, startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes: startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes, lengthOfAbbreviationSubscriptLettersFirstLocationAttributes: lengthOfAbbreviationSubscriptLettersFirstLocationAttributes, abbreviationSubscriptLettersSecondLocationAttributesAssigned: abbreviationSubscriptLettersSecondLocationAttributesAssigned, abbreviationSubscriptLettersSecondLocationAttributes: abbreviationSubscriptLettersSecondLocationAttributes, startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes: startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes, lengthOfAbbreviationSubscriptLettersSecondLocationAttributes: lengthOfAbbreviationSubscriptLettersSecondLocationAttributes, superscriptLettersAttributesAssigned: superscriptLettersAttributesAssigned, superscriptLettersAttributes: superscriptLettersAttributes, startingLocationForSuperscriptLettersAttributes: startingLocationForSuperscriptLettersAttributes, lengthOfSuperscriptLettersAttributes: lengthOfSuperscriptLettersAttributes)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupUILabel(numberOfLineToBeDisplayed: Int, horizontalAlignmentOfTextToBeDisplayed: NSTextAlignment, rotationAngleTransformation: CGFloat, textToBeDisplayed: String, wholeTitleAttributesAssigned: Bool, attributesForTheWholeTitle: [NSMutableAttributedString.Key : Any], startingLocationForWholeTitleAttributes: Int, abbreviationLettersAttributesAssigned: Bool, attributesForAbbreviationLetters: [NSMutableAttributedString.Key : Any], startingLocationForAbbreviationLettersAttributes: Int, lengthOfAbbreviationLettersAttributes: Int, abbreviationSubscriptLettersFirstLocationAttributesAssigned: Bool, abbreviationSubscriptLettersFirstLocationAttributes: [NSMutableAttributedString.Key : Any], startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes: Int, lengthOfAbbreviationSubscriptLettersFirstLocationAttributes: Int, abbreviationSubscriptLettersSecondLocationAttributesAssigned: Bool ,abbreviationSubscriptLettersSecondLocationAttributes: [NSMutableAttributedString.Key : Any], startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes: Int, lengthOfAbbreviationSubscriptLettersSecondLocationAttributes: Int ,superscriptLettersAttributesAssigned: Bool, superscriptLettersAttributes: [NSMutableAttributedString.Key : Any], startingLocationForSuperscriptLettersAttributes: Int, lengthOfSuperscriptLettersAttributes: Int) {
        
        numberOfLines = numberOfLineToBeDisplayed
        
        textAlignment = horizontalAlignmentOfTextToBeDisplayed
        
        transform = CGAffineTransform(rotationAngle: rotationAngleTransformation)
                
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: textToBeDisplayed)
        
        if wholeTitleAttributesAssigned == true {
            
            labelAttributedString.addAttributes(attributesForTheWholeTitle, range: NSRange(location: startingLocationForWholeTitleAttributes, length: textToBeDisplayed.count))
            
        }
        
        if abbreviationLettersAttributesAssigned == true {
            
            labelAttributedString.addAttributes(attributesForAbbreviationLetters, range: NSRange(location: startingLocationForAbbreviationLettersAttributes, length: lengthOfAbbreviationLettersAttributes))
            
        }
        
        if abbreviationSubscriptLettersFirstLocationAttributesAssigned == true {
            
            labelAttributedString.addAttributes(abbreviationSubscriptLettersFirstLocationAttributes, range: NSRange(location: startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes, length: lengthOfAbbreviationSubscriptLettersFirstLocationAttributes))
            
        }
        
        if abbreviationSubscriptLettersSecondLocationAttributesAssigned == true {
            
            labelAttributedString.addAttributes(abbreviationSubscriptLettersSecondLocationAttributes, range: NSRange(location: startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes, length: lengthOfAbbreviationSubscriptLettersSecondLocationAttributes))
            
        }
        
        if superscriptLettersAttributesAssigned == true {
            
            labelAttributedString.addAttributes(superscriptLettersAttributes, range: NSRange(location: startingLocationForSuperscriptLettersAttributes, length: lengthOfSuperscriptLettersAttributes))
            
        }
        
        attributedText = labelAttributedString
        
        layer.borderWidth = 1
        
        layer.borderColor = UIColor.black.cgColor
        
        sizeToFit()
                        
    }
    
}

