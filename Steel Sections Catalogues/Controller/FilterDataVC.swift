//
//  FilterDataVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/1/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import RangeSeekSlider

class FilterDataVC: UIViewController {
    
    let depthOfSectionTitleTopPadding: CGFloat = 10
    
    var depthOfSectionTitleLabelHeight: CGFloat = 0
    
    let depthOfSectionRangeSliderTopPadding: CGFloat = 10
    
    var depthOfSectionRangeSliderHeight: CGFloat = 0
    
    let widthOfSectionTitleTopPadding: CGFloat = 10
    
    var widthOfSectionTitleLabelHeight: CGFloat = 0
    
    let widthOfSectionRangeSliderTopPadding: CGFloat = 10
    
    var widthOfSectionRangeSliderHeight: CGFloat = 0
    
    let sectionWebThicknessTitleTopPadding: CGFloat = 10
    
    var sectionWebThicknessTitleLabelHeight: CGFloat = 0
    
    let sectionWebThicknessRangeSliderTopPadding: CGFloat = 10
    
    var sectionWebThicknessRangeSliderHeight: CGFloat = 0
    
    let sectionFlangeThicknessTitleTopPadding: CGFloat = 10
    
    var sectionFlangeThicknessTitleLabelHeight: CGFloat = 0
    
    let sectionFlangeThicknessRangeSliderTopPadding: CGFloat = 10
    
    var sectionFlangeThicknessRangeSliderHeight: CGFloat = 0
    
    let areaOfSectionTitleTopPadding: CGFloat = 10
    
    var areaOfSectionTitleLabelHeight: CGFloat = 0
    
    let areaOfSectionRangeSliderTopPadding: CGFloat = 10
    
    var areaOfSectionRangeSliderHeight: CGFloat = 0
        
    // MARK: - Scroll View
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .yellow
                        
        return scrollView
        
    }()
    
    // MARK: Instance Variables definitions:
    
    var universalBeamsDataArrayPassedFromPreviousVC = [IsectionsDimensionsParameters]()
    
    var extractedDepthOfSection: [Double]?
    
    var extractedWidthOfSection: [Double]?
    
    var extractedSectionWebThickness: [Double]?
    
    var extractedSectionFlangeThickness: [Double]?
    
    var extractedSectionArea: [Double]?
    
    let depthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(textToDisplay: "Slider Range for Depth of Section, h [mm]:", textFontName: "AppleSDGothicNeo-Light", textFontSize: 20, textHexColourCode: "#033E8C")
    
    let widthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(textToDisplay: "Slider Range for Width of Section, b [mm]:", textFontName: "AppleSDGothicNeo-Light", textFontSize: 20, textHexColourCode: "#033E8C")
    
    let sectionWebThicknessSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Section Web Thickness, tw [mm]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 41)
    
    let sectionFlangeThicknessSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Section Flange Thickness, tf [mm]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 44)
    
    let sectionAreaSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Area of Section, A [cm2]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 39)
    
    var customDepthOfSectionRangeSlider: RangeSeekSlider?
    
    var customWidthOfSectionRangeSlider: RangeSeekSlider?
    
    var customSectionWebThicknessSlider: RangeSeekSlider?
    
    var customSectionFlangeThicknessSlider: RangeSeekSlider?
    
    var customSectionAreaSlider: RangeSeekSlider?
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "UB Data Filter", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("FilterDataVC viewDidLoad()")
        
        extractedDepthOfSection = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.depthOfSection })
        
        extractedWidthOfSection = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.widthOfSection })
        
        extractedSectionWebThickness = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.sectionWebThickness })
        
        extractedSectionFlangeThickness = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.sectionFlangeThickness })
        
        extractedSectionArea = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.areaOfSection })
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionArea = extractedSectionArea {
            
            customDepthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedDepthOfSection, minimumDistanceBetweenSliders: 100, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customWidthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedWidthOfSection, minimumDistanceBetweenSliders: 100, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionWebThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionWebThickness, minimumDistanceBetweenSliders: 5, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionFlangeThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionFlangeThickness, minimumDistanceBetweenSliders: 5, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionAreaSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionArea, minimumDistanceBetweenSliders: 5, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
        }
        
        customDepthOfSectionRangeSlider!.delegate = self
        
        customWidthOfSectionRangeSlider!.delegate = self
        
        customSectionWebThicknessSlider!.delegate = self
        
        customSectionFlangeThicknessSlider!.delegate = self
        
        customSectionAreaSlider!.delegate = self
        
        view.addSubview(navigationBar)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(depthOfSectionRangeSliderTitle)
        
        scrollView.addSubview(widthOfSectionRangeSliderTitle)
        
        scrollView.addSubview(sectionWebThicknessSliderTitle)
        
        scrollView.addSubview(sectionFlangeThicknessSliderTitle)

        scrollView.addSubview(sectionAreaSliderTitle)
        
        scrollView.addSubview(customDepthOfSectionRangeSlider!)
        
        scrollView.addSubview(customWidthOfSectionRangeSlider!)
        
        scrollView.addSubview(customSectionWebThicknessSlider!)
        
        scrollView.addSubview(customSectionFlangeThicknessSlider!)
        
        scrollView.addSubview(customSectionAreaSlider!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("FilterDataVC viewWillAppear()")
        
    }
    
    override func viewWillLayoutSubviews() {
        
        print("FilterDataVC viewWillLayoutSubviews()")
        
        depthOfSectionTitleLabelHeight = depthOfSectionRangeSliderTitle.frame.size.height
        
        print("Depth Of Section Label Height is equal to \(depthOfSectionTitleLabelHeight)")
        
        widthOfSectionTitleLabelHeight = widthOfSectionRangeSliderTitle.frame.size.height
        
        sectionWebThicknessTitleLabelHeight = sectionWebThicknessSliderTitle.frame.size.height
        
        sectionFlangeThicknessTitleLabelHeight = sectionFlangeThicknessSliderTitle.frame.size.height
        
        areaOfSectionTitleLabelHeight = sectionAreaSliderTitle.frame.size.height
        
        if let customDepthOfSectionRangeSlider = customDepthOfSectionRangeSlider, let customWidthOfSectionRangeSlider = customWidthOfSectionRangeSlider, let customSectionWebThicknessSlider = customSectionWebThicknessSlider, let customSectionFlangeThicknessSlider = customSectionFlangeThicknessSlider, let customSectionAreaSlider = customSectionAreaSlider {
            
            depthOfSectionRangeSliderHeight = customDepthOfSectionRangeSlider.frame.size.height
            
            widthOfSectionRangeSliderHeight = customWidthOfSectionRangeSlider.frame.size.height
            
            sectionWebThicknessRangeSliderHeight = customSectionWebThicknessSlider.frame.size.height
            
            sectionFlangeThicknessRangeSliderHeight = customSectionFlangeThicknessSlider.frame.size.height
            
            areaOfSectionRangeSliderHeight = customSectionAreaSlider.frame.size.height
            
        }
        
        print("Depth Of Section Range Slider Height is equal to \(depthOfSectionRangeSliderHeight)")
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: depthOfSectionTitleTopPadding + depthOfSectionTitleLabelHeight + depthOfSectionRangeSliderTopPadding + depthOfSectionRangeSliderHeight + widthOfSectionTitleTopPadding + widthOfSectionTitleLabelHeight + widthOfSectionRangeSliderTopPadding + widthOfSectionRangeSliderHeight + sectionWebThicknessTitleTopPadding + sectionWebThicknessTitleLabelHeight + sectionWebThicknessRangeSliderTopPadding + sectionWebThicknessRangeSliderHeight + sectionFlangeThicknessTitleTopPadding + sectionFlangeThicknessTitleLabelHeight + sectionFlangeThicknessRangeSliderTopPadding + sectionFlangeThicknessRangeSliderHeight + areaOfSectionTitleTopPadding + areaOfSectionTitleLabelHeight + areaOfSectionRangeSliderTopPadding + areaOfSectionRangeSliderHeight)
        
        setupConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("FilterDataVC viewDidLayoutSubviews()")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("FilterDataVC viewDidAppear()")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("FilterDataVC viewWillDisappear()")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("FilterDataVC viewDidDisappear()")
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            depthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            
            depthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            depthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            customDepthOfSectionRangeSlider!.topAnchor.constraint(equalTo: depthOfSectionRangeSliderTitle.bottomAnchor, constant: 10),
            
            customDepthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            customDepthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            widthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: customDepthOfSectionRangeSlider!.bottomAnchor, constant: 20),
            
            widthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            widthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            customWidthOfSectionRangeSlider!.topAnchor.constraint(equalTo: widthOfSectionRangeSliderTitle.bottomAnchor, constant: 10),
            
            customWidthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            customWidthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            sectionWebThicknessSliderTitle.topAnchor.constraint(equalTo: customWidthOfSectionRangeSlider!.bottomAnchor, constant: 20),
            
            sectionWebThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            sectionWebThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            customSectionWebThicknessSlider!.topAnchor.constraint(equalTo: sectionWebThicknessSliderTitle.bottomAnchor, constant: 10),
            
            customSectionWebThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            customSectionWebThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            sectionFlangeThicknessSliderTitle.topAnchor.constraint(equalTo: customSectionWebThicknessSlider!.bottomAnchor, constant: 20),
            
            sectionFlangeThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            sectionFlangeThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            customSectionFlangeThicknessSlider!.topAnchor.constraint(equalTo: sectionFlangeThicknessSliderTitle.bottomAnchor, constant: 10),
            
            customSectionFlangeThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            customSectionFlangeThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            sectionAreaSliderTitle.topAnchor.constraint(equalTo: customSectionFlangeThicknessSlider!.bottomAnchor, constant: 20),
            
            sectionAreaSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            sectionAreaSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            customSectionAreaSlider!.topAnchor.constraint(equalTo: sectionAreaSliderTitle.bottomAnchor, constant: 10),
            
            customSectionAreaSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            customSectionAreaSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
            
            ])
        
    }
    
    //    func setupRangeSlider() {
    //
    //        let extractedDepthsOfSectionsFromPassedArray = universalBeamsDataArrayPassedFromPreviousVC.map({ return $0.depthOfSection })
    //
    //        let minimumSectionDepthExtractedFromPassedArray = extractedDepthsOfSectionsFromPassedArray.min()
    //
    //        let maximumSectionDepthExtractedFromPassedArray = extractedDepthsOfSectionsFromPassedArray.max()
    //
    //        depthOfSectionRangeSlider.translatesAutoresizingMaskIntoConstraints = false
    //
    //        if let minimumSectionDepthExtractedFromPassedArray = minimumSectionDepthExtractedFromPassedArray, let maximumSectionDepthExtractedFromPassedArray = maximumSectionDepthExtractedFromPassedArray {
    //
    //            depthOfSectionRangeSlider.minValue = CGFloat(minimumSectionDepthExtractedFromPassedArray)
    //
    //            depthOfSectionRangeSlider.maxValue = CGFloat(maximumSectionDepthExtractedFromPassedArray)
    //
    //        }
    //
    //        depthOfSectionRangeSlider.selectedMinValue = 200
    //
    //        depthOfSectionRangeSlider.selectedMaxValue = 800
    //
    //        // If set it will update the color of the handles. Default is tintColor:
    //
    //        depthOfSectionRangeSlider.handleColor = .green
    //
    //        depthOfSectionRangeSlider.handleDiameter = 30
    //
    //        // If set it update the scaling factor of the handle when selected. Default is 1.7. If you don't want any scaling, set it to 1.0:
    //
    //        depthOfSectionRangeSlider.selectedHandleDiameterMultiplier = 1.3
    //
    //        depthOfSectionRangeSlider.numberFormatter.numberStyle = .decimal
    //
    //        depthOfSectionRangeSlider.numberFormatter.locale = Locale(identifier: "en_US")
    //
    //        depthOfSectionRangeSlider.numberFormatter.maximumFractionDigits = 2
    //
    //        // The font of the minimum value text label. If not set, the default is system font size 12.0:
    //
    //        depthOfSectionRangeSlider.minLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!
    //
    //        // The font of the maximum value text label. If not set, the default is system font size 12.0:
    //
    //        depthOfSectionRangeSlider.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!
    //
    //        // The color of the minimum value text label. If not set, the default is the tintColor:
    //
    //        depthOfSectionRangeSlider.minLabelColor = .red
    //
    //        // The color of the maximum value text label. If not set, the default is the tintColor:
    //
    //        depthOfSectionRangeSlider.maxLabelColor = .blue
    //
    //        // The colorBetweenHandles property sets the color of the line between the two handles:
    //
    //        depthOfSectionRangeSlider.colorBetweenHandles = .yellow
    //
    //        // If set it will update the size of the handle borders. Default is 0.0:
    //
    //        depthOfSectionRangeSlider.handleBorderWidth = 8
    //
    //        // If set it will update the color of the handle borders. Default is tintColor:
    //
    //        depthOfSectionRangeSlider.handleBorderColor = .black
    //
    //        // The color of the entire slider when the handle is set to the minimum value and the maximum value. Default is nil:
    //
    //        depthOfSectionRangeSlider.initialColor = .cyan
    //
    //        // If true the control will snap to point at each step (property) between minValue and maxValue. Default value is disabled:
    //
    ////        depthOfSectionRangeSlider.enableStep = true
    //
    ////        depthOfSectionRangeSlider.step = 100
    //
    //        // If set the image passed will be used for the handles:
    //
    //        depthOfSectionRangeSlider.handleImage = #imageLiteral(resourceName: "HighlightedRect")
    //
    //        // Set the height of the line. It will automatically round the corners. If not specified, the default value will be 1.0:
    //
    //        depthOfSectionRangeSlider.lineHeight = 5
    //
    //        // If set it will update the size of the padding between label and handle. Default is 8.0:
    //
    //        depthOfSectionRangeSlider.labelPadding = -70
    //
    //    }
    
    //    fileprivate func priceString(value: CGFloat) -> String {
    //
    ////        let index: Int = Int(roundf(Float(value)))
    //
    ////        let sectionPropertyValueAtSliderPosition: Double = testArray[index]
    //
    //        if customDepthOfSectionRangeSlider.minValue == CGFloat(testArray.min()!) {
    //            return "Min"
    //        } else if customDepthOfSectionRangeSlider.maxValue == CGFloat(testArray.max()!)  {
    //            return "Max"
    //
    //        } else {
    //            let priceString: String? = customDepthOfSectionRangeSlider.numberFormatter.string(from: customDepthOfSectionRangeSlider.selectedMinValue as NSNumber)
    //            return priceString ?? ""
    //        }
    //    }
    
    
}

// MARK: Navigation Bar Extension:

extension FilterDataVC: UINavigationBarDelegate {
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "BlueBookUniversalBeamsVC")
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

extension FilterDataVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        
        print("did start touches")
        
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        
        print("did end touches")
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        
        var minimumDepthOfSection: Double?
        
        var minimumWidthOfSection: Double?
        
        var minimumSectionWebThickness: Double?
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness {
            
            minimumDepthOfSection = extractedDepthOfSection.min()
            
            minimumWidthOfSection = extractedWidthOfSection.min()
            
            minimumSectionWebThickness = extractedSectionWebThickness.min()
            
        }
        
        if minValue == CGFloat(minimumDepthOfSection!) || minValue == CGFloat(minimumWidthOfSection!) || minValue == CGFloat(minimumSectionWebThickness!) {
            
            return "Min"
            
        } else {
            
            let minimumSliderLabelString: String? = slider.numberFormatter.string(from: minValue as NSNumber)
            
            return minimumSliderLabelString ?? ""
            
        }
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        
        var maximumDepthOfSection: Double?
        
        var maximumWidthOfSection: Double?
        
        var maximumSectionWebThickness: Double?
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness {
            
            maximumDepthOfSection = extractedDepthOfSection.max()
            
            maximumWidthOfSection = extractedWidthOfSection.max()
            
            maximumSectionWebThickness = extractedSectionWebThickness.max()
            
        }
        
        if maxValue == CGFloat(maximumDepthOfSection!) || maxValue == CGFloat(maximumWidthOfSection!) || maxValue == CGFloat(maximumSectionWebThickness!) {
            
            return "Max"
            
        } else {
            
            let maximumSliderLabelString: String? = slider.numberFormatter.string(from: maxValue as NSNumber)
            
            return maximumSliderLabelString ?? ""
            
        }
        
    }
    
}

