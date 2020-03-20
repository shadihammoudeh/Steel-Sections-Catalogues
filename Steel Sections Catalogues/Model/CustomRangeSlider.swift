//
//  CustomRangeSlider.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 08/09/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import RangeSeekSlider

import ChameleonFramework

class CustomRangeSeekSlider: RangeSeekSlider {
    
    convenience init(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat) {
        
        self.init()
        
        setupRangeSlider(sectionPropertyDataArrayForRangeSlide: sectionPropertyDataArrayForRangeSlide, minimumDistanceBetweenSliders: minimumDistanceBetweenSliders)
        
    }
    
    func setupRangeSlider(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
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
        
        handleColor = UIColor(named: "Range Slider Handle Colour inside Filter View Controller")
        
        minLabelColor = UIColor(named: "Range Slider Minimum & Maximum Value Label Text Colour inside Filter View Controller")
        
        maxLabelColor = UIColor(named: "Range Slider Minimum & Maximum Value Label Text Colour inside Filter View Controller")
        
        colorBetweenHandles = UIColor(named: "Range Slider Track Colour in between Handles")
        
        lineHeight = 5
        
        minLabelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)!
        
        maxLabelFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)!

        // The below line of code sets the colour of the range slider track not in between the two handles:
        
        tintColor = UIColor(named: "Range Slider Track Colour not between Handles")
        
        // The color of the entire slider when the handle is set to the minimum value and the maximum value:

        
        initialColor = UIColor(named: "Range Slider Colour when Values Set to Max and Min")
        
        handleBorderWidth = 1.5
        
        handleBorderColor = UIColor(named: "Range Slider Handle Border Colour inside Filter View Controller")
        
        numberFormatter.numberStyle = .decimal
        
        labelsFixed = false
                
        handleDiameter = 22
        
        selectedHandleDiameterMultiplier = 1.3
        
        numberFormatter.maximumFractionDigits = 1
        
        labelPadding = -45
        
    }
    
}
