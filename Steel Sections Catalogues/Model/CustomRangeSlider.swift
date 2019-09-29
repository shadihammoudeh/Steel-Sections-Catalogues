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
    
    convenience init(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat, slidersHexColourCode: String, minimumSliderLabelHexColourCode: String, maximumSliderLabelHexColourCode: String, trackColourBetweenSliders: String, hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: String) {
        
        self.init()
        
        setupRangeSlider(sectionPropertyDataArrayForRangeSlide: sectionPropertyDataArrayForRangeSlide, minimumDistanceBetweenSliders: minimumDistanceBetweenSliders, slidersHexColourCode: slidersHexColourCode, minimumSliderLabelHexColourCode: minimumSliderLabelHexColourCode, maximumSliderLabelHexColourCode: maximumSliderLabelHexColourCode, trackColourBetweenSliders: trackColourBetweenSliders, hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues)
        
    }
    
    func setupRangeSlider(sectionPropertyDataArrayForRangeSlide: [Double], minimumDistanceBetweenSliders: CGFloat, slidersHexColourCode: String, minimumSliderLabelHexColourCode: String, maximumSliderLabelHexColourCode: String, trackColourBetweenSliders: String, hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: String) {
        
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
        
        handleColor = UIColor(hexString: slidersHexColourCode)
        
        minLabelColor = UIColor(hexString: minimumSliderLabelHexColourCode)
        
        maxLabelColor = UIColor(hexString: maximumSliderLabelHexColourCode)
        
        colorBetweenHandles = UIColor(hexString: trackColourBetweenSliders)
        
        numberFormatter.numberStyle = .decimal
        
        labelsFixed = false
        
        initialColor = UIColor(hexString: hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues)
        
        handleDiameter = 20
        
        selectedHandleDiameterMultiplier = 1.3
        
        numberFormatter.maximumFractionDigits = 1
        
        labelPadding = -40
        
    }
    
}
