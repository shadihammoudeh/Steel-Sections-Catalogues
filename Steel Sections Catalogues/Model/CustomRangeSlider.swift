//
//  CustomRangeSlider.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 08/09/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import RangeSeekSlider

class CustomRangeSeekSlider: RangeSeekSlider {
    
    convenience init(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat) {
        
        self.init()
        
        setupRangeSlider(sectionPropertyDataArrayForRangeSlide: sectionPropertyDataArrayForRangeSlide, minimumDistanceBetweenSliders: minimumDistanceBetweenSliders)
        
    }
    
    func setupRangeSlider(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat) {
                
        let sectionPropertyMappedArray: [Double] = sectionPropertyDataArrayForRangeSlide
        
        if let minimumRangeSliderValue = sectionPropertyMappedArray.min() {
            
            minValue = CGFloat(minimumRangeSliderValue)
            
        }
        
        if let maximumRangeSliderValue = sectionPropertyMappedArray.max() {
            
            maxValue = CGFloat(maximumRangeSliderValue)
            
        }
        
        let preselectedRangeSliderMinimumValue = ((maxValue - minValue) / 3) + minValue
        
        selectedMinValue = preselectedRangeSliderMinimumValue
        
        let preselectedRangeSliderMaximumValue = maxValue - ((maxValue - minValue) / 3)
        
        selectedMaxValue = preselectedRangeSliderMaximumValue
        
        minDistance = minimumDistanceBetweenSliders
        
        handleColor = UIColor(named: "Filter Results VC - Range Slider Track Handles Colour")
        
        minLabelColor = UIColor(named: "Filter Results VC - Range Slider Min & Max Value Titles Text Colours")
        
        maxLabelColor = UIColor(named: "Filter Results VC - Range Slider Min & Max Value Titles Text Colours")
        
        colorBetweenHandles = UIColor(named: "Filter Results VC - Range Slider Track Colour in between Handles")
        
        lineHeight = 5
        
        minLabelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)!
        
        maxLabelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)!

        // The below line of code sets the colour of the range slider track not in between the two handles:
        
        tintColor = UIColor(named: "Filter Results VC - Range Slider Track Colour Outside the Area Enclosed by the Handles")
        
        // The color of the entire slider when the handle is set to the minimum value and the maximum value:

        
        initialColor = UIColor(named: "Filter Results VC - Range Slider Track and Handles Colours when Handles are on Max & Min Values")
        
        handleBorderWidth = 1.5
        
        handleBorderColor = UIColor(named: "Filter Results VC - Range Slider Handles Borders Colours")
        
        numberFormatter.numberStyle = .decimal
        
        labelsFixed = false
                
        handleDiameter = 22
        
        selectedHandleDiameterMultiplier = 1.3
        
        numberFormatter.maximumFractionDigits = 1
        
        labelPadding = -45
        
    }
    
}
