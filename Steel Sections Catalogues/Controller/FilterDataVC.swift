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
    
    // MARK: - Assigning protocol delegate:
    
    var delegate: PassingDataBackwardsProtocol?
    
    // MARK: - Instance scope variables and constants declarations:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed from BlueBookUniversalBeamsVC, and when this ViewController gets dismissed, any made changes to these variables will be sent back to BlueBookUniversalBeamsVC using the Protocol:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    var universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC = [IsectionsDimensionsParameters]()
    
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
    
    let resetFiltersButtonTopPadding: CGFloat = 10
    
    var resetFiltersButtonHeight: CGFloat = 0
    
    let applyFiltersButtonTopPadding: CGFloat = 10
    
    var applyFiltersButtonHeight: CGFloat = 0
    
    var resetAndApplyFiltersButtonsBottomPadding: CGFloat = 10
    
    let customRangeSlidersLeftAndRightPadding: CGFloat = 22
    
    var extractedDepthOfSection: [Double]?
    
    var extractedWidthOfSection: [Double]?
    
    var extractedSectionWebThickness: [Double]?
    
    var extractedSectionFlangeThickness: [Double]?
    
    var extractedSectionArea: [Double]?
    
    var customDepthOfSectionRangeSlider: RangeSeekSlider?
    
    var customWidthOfSectionRangeSlider: RangeSeekSlider?
    
    var customSectionWebThicknessSlider: RangeSeekSlider?
    
    var customSectionFlangeThicknessSlider: RangeSeekSlider?
    
    var customSectionAreaSlider: RangeSeekSlider?
    
    var minimumDepthOfSection: Double?
    
    var minimumWidthOfSection: Double?
    
    var minimumSectionWebThickness: Double?
    
    var minimumSectionFlangeThickness: Double?
    
    var minimumAreaOfSection: Double?
    
    var maximumDepthOfSection: Double?
    
    var maximumWidthOfSection: Double?
    
    var maximumSectionWebThickness: Double?
    
    var maximumSectionFlangeThickness: Double?
    
    var maximumAreaOfSection: Double?
    
    var resetFiltersButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Remove Filters", for: .normal)
        
        button.setTitleColor(.blue, for: .normal)
        
        button.setTitleColor(.red, for: .highlighted)
        
        button.layer.borderWidth = 1
        
        button.titleLabel?.numberOfLines = 1
        
        button.tag = 1
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    var applyFiltersButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Add Filters", for: .normal)
        
        button.setTitleColor(.blue, for: .normal)
        
        button.setTitleColor(.red, for: .highlighted)
        
        button.layer.borderWidth = 1
        
        button.titleLabel?.numberOfLines = 1
        
        button.tag = 2
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .yellow
        
        return scrollView
        
    }()
    
    let depthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(textToDisplay: "Slider Range for Depth of Section, h [mm]:", textFontName: "AppleSDGothicNeo-Light", textFontSize: 20, textHexColourCode: "#033E8C")
    
    let widthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(textToDisplay: "Slider Range for Width of Section, b [mm]:", textFontName: "AppleSDGothicNeo-Light", textFontSize: 20, textHexColourCode: "#033E8C")
    
    let sectionWebThicknessSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Section Web Thickness, tw [mm]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 41)
    
    let sectionFlangeThicknessSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Section Flange Thickness, tf [mm]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 44)
    
    let sectionAreaSliderTitle = CustomRangeSliderUILabel(attributedStringFontName: "AppleSDGothicNeo-Light", attributedStringFontSize: 18, attributedStringFontHexColourCode: "#D454FF", textToDisplay: "Slider Range for Area of Section, A [cm2]:", subOrSuperScriptFontName: "AppleSDGothicNeo-Light", subOrSuperScriptFontSize: 10, subOrSuperScriptLocation: 39)
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "UB Data Filter", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048")
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("FilterDataVC viewDidLoad()")
        
        // MARK: - Extracting appropriate Arrays data for Range Sliders:
        
        extractedDepthOfSection = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.depthOfSection })
        
        extractedWidthOfSection = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.widthOfSection })
        
        extractedSectionWebThickness = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.sectionWebThickness })
        
        extractedSectionFlangeThickness = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.sectionFlangeThickness })
        
        extractedSectionArea = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.areaOfSection })
        
        // MARK: - Declaring range sliders:
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionArea = extractedSectionArea {
            
            customDepthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedDepthOfSection, minimumDistanceBetweenSliders: 80, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customWidthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedWidthOfSection, minimumDistanceBetweenSliders: 30, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionWebThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionWebThickness, minimumDistanceBetweenSliders: 3, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionFlangeThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionFlangeThickness, minimumDistanceBetweenSliders: 5, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
            customSectionAreaSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionArea, minimumDistanceBetweenSliders: 55, slidersHexColourCode: "#A0DBF2", minimumSliderLabelHexColourCode: "#3068D9", maximumSliderLabelHexColourCode: "#2955D9", trackColourBetweenSliders: "#698C35", hexColourCodeOfRangeSliderWhenSlidersAtMaxAndMinValues: "#3068D9")
            
        }
        
        // MARK: - Setting Range Sliders delegates:
        
        customDepthOfSectionRangeSlider!.delegate = self
        
        customWidthOfSectionRangeSlider!.delegate = self
        
        customSectionWebThicknessSlider!.delegate = self
        
        customSectionFlangeThicknessSlider!.delegate = self
        
        customSectionAreaSlider!.delegate = self
        
        // MARK: - Adding subViews:
        
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
        
        scrollView.addSubview(resetFiltersButton)
        
        scrollView.addSubview(applyFiltersButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("FilterDataVC viewWillAppear()")
        
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
        
        print("FilterDataVC viewWillLayoutSubviews()")
        
        // MARK: - Assigning UILabels heights and customRangeSliders heights to their corresponding instances:
        
        depthOfSectionTitleLabelHeight = depthOfSectionRangeSliderTitle.frame.size.height
        
        widthOfSectionTitleLabelHeight = widthOfSectionRangeSliderTitle.frame.size.height
        
        sectionWebThicknessTitleLabelHeight = sectionWebThicknessSliderTitle.frame.size.height
        
        sectionFlangeThicknessTitleLabelHeight = sectionFlangeThicknessSliderTitle.frame.size.height
        
        areaOfSectionTitleLabelHeight = sectionAreaSliderTitle.frame.size.height
        
        resetFiltersButtonHeight = CGFloat(resetFiltersButton.intrinsicContentSize.height)
        
        applyFiltersButtonHeight = CGFloat(applyFiltersButton.intrinsicContentSize.height)
        
        if let customDepthOfSectionRangeSlider = customDepthOfSectionRangeSlider, let customWidthOfSectionRangeSlider = customWidthOfSectionRangeSlider, let customSectionWebThicknessSlider = customSectionWebThicknessSlider, let customSectionFlangeThicknessSlider = customSectionFlangeThicknessSlider, let customSectionAreaSlider = customSectionAreaSlider {
            
            depthOfSectionRangeSliderHeight = customDepthOfSectionRangeSlider.frame.size.height
            
            widthOfSectionRangeSliderHeight = customWidthOfSectionRangeSlider.frame.size.height
            
            sectionWebThicknessRangeSliderHeight = customSectionWebThicknessSlider.frame.size.height
            
            sectionFlangeThicknessRangeSliderHeight = customSectionFlangeThicknessSlider.frame.size.height
            
            areaOfSectionRangeSliderHeight = customSectionAreaSlider.frame.size.height
            
        }
        
        // MARK: - Calculating ScrollView ContentSize:
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: depthOfSectionTitleTopPadding + depthOfSectionTitleLabelHeight + depthOfSectionRangeSliderTopPadding + depthOfSectionRangeSliderHeight + widthOfSectionTitleTopPadding + widthOfSectionTitleLabelHeight + widthOfSectionRangeSliderTopPadding + widthOfSectionRangeSliderHeight + sectionWebThicknessTitleTopPadding + sectionWebThicknessTitleLabelHeight + sectionWebThicknessRangeSliderTopPadding + sectionWebThicknessRangeSliderHeight + sectionFlangeThicknessTitleTopPadding + sectionFlangeThicknessTitleLabelHeight + sectionFlangeThicknessRangeSliderTopPadding + sectionFlangeThicknessRangeSliderHeight + areaOfSectionTitleTopPadding + areaOfSectionTitleLabelHeight + areaOfSectionRangeSliderTopPadding + areaOfSectionRangeSliderHeight + resetFiltersButtonTopPadding + max(resetFiltersButtonHeight, applyFiltersButtonHeight) + resetAndApplyFiltersButtonsBottomPadding)
        
        // MARK: - Calling the setupConstraints function:
        
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
    
    // MARK: - Button pressed method:
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        // MARK: - Reset Filters button pressed:
        
        if sender.tag == 1 {
            
            if let minimumDepthOfSection = minimumDepthOfSection, let maximumDepthOfSection = maximumDepthOfSection, let minimumWidthOfSection = minimumWidthOfSection, let maximumWidthOfSection = maximumWidthOfSection, let minimumSectionWebThickness = minimumSectionWebThickness, let maximumSectionWebThickness = maximumSectionWebThickness, let minimumSectionFlangeThickness = minimumSectionFlangeThickness, let maximumSectionFlangeThickness = maximumSectionFlangeThickness, let minimumSectionArea = minimumAreaOfSection, let maximumSectionArea = maximumAreaOfSection {
                
                customDepthOfSectionRangeSlider?.selectedMinValue = CGFloat(minimumDepthOfSection)
                
                customDepthOfSectionRangeSlider?.selectedMaxValue = CGFloat(maximumDepthOfSection)
                
                customDepthOfSectionRangeSlider?.layoutSubviews()
                
                customWidthOfSectionRangeSlider?.selectedMinValue = CGFloat(minimumWidthOfSection)
                
                customWidthOfSectionRangeSlider?.selectedMaxValue = CGFloat(maximumWidthOfSection)
                
                customWidthOfSectionRangeSlider?.layoutSubviews()
                
                customSectionWebThicknessSlider?.selectedMinValue = CGFloat(minimumSectionWebThickness)
                
                customSectionWebThicknessSlider?.selectedMaxValue = CGFloat(maximumSectionWebThickness)
                
                customSectionWebThicknessSlider?.layoutSubviews()
                
                customSectionFlangeThicknessSlider?.selectedMinValue = CGFloat(minimumSectionFlangeThickness)
                
                customSectionFlangeThicknessSlider?.selectedMaxValue = CGFloat(maximumSectionFlangeThickness)
                
                customSectionFlangeThicknessSlider?.layoutSubviews()
                
                customSectionAreaSlider?.selectedMinValue = CGFloat(minimumSectionArea)
                
                customSectionAreaSlider?.selectedMaxValue = CGFloat(maximumSectionArea)
                
                customSectionAreaSlider?.layoutSubviews()
                
            }
            
        }
            
            // MARK: - Apply Filters button pressed:
            
        else if sender.tag == 2 {
            
            
            
            if delegate != nil {
                
                let filteredArray = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.filter( { return (($0.depthOfSection >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.depthOfSection <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue))) } )
                
                print("Filtered Array is equal to \(filteredArray)")
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: filteredArray, sortBy: "None", filtersApplied: true, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        }
        
    }
    
    // MARK: - Defining the setupConstraints function:
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            depthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: depthOfSectionTitleTopPadding),
            
            depthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            depthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            customDepthOfSectionRangeSlider!.topAnchor.constraint(equalTo: depthOfSectionRangeSliderTitle.bottomAnchor, constant: depthOfSectionRangeSliderTopPadding),
            
            customDepthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: customRangeSlidersLeftAndRightPadding),
            
            customDepthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (customRangeSlidersLeftAndRightPadding)),
            
            widthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: customDepthOfSectionRangeSlider!.bottomAnchor, constant: widthOfSectionTitleTopPadding),
            
            widthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            widthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            customWidthOfSectionRangeSlider!.topAnchor.constraint(equalTo: widthOfSectionRangeSliderTitle.bottomAnchor, constant: widthOfSectionRangeSliderTopPadding),
            
            customWidthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: customRangeSlidersLeftAndRightPadding),
            
            customWidthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (customRangeSlidersLeftAndRightPadding)),
            
            sectionWebThicknessSliderTitle.topAnchor.constraint(equalTo: customWidthOfSectionRangeSlider!.bottomAnchor, constant: sectionWebThicknessTitleTopPadding),
            
            sectionWebThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            sectionWebThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            customSectionWebThicknessSlider!.topAnchor.constraint(equalTo: sectionWebThicknessSliderTitle.bottomAnchor, constant: sectionWebThicknessRangeSliderTopPadding),
            
            customSectionWebThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: customRangeSlidersLeftAndRightPadding),
            
            customSectionWebThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (customRangeSlidersLeftAndRightPadding)),
            
            sectionFlangeThicknessSliderTitle.topAnchor.constraint(equalTo: customSectionWebThicknessSlider!.bottomAnchor, constant: sectionFlangeThicknessTitleTopPadding),
            
            sectionFlangeThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            sectionFlangeThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            customSectionFlangeThicknessSlider!.topAnchor.constraint(equalTo: sectionFlangeThicknessSliderTitle.bottomAnchor, constant: sectionFlangeThicknessRangeSliderTopPadding),
            
            customSectionFlangeThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: customRangeSlidersLeftAndRightPadding),
            
            customSectionFlangeThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (customRangeSlidersLeftAndRightPadding)),
            
            sectionAreaSliderTitle.topAnchor.constraint(equalTo: customSectionFlangeThicknessSlider!.bottomAnchor, constant: areaOfSectionTitleTopPadding),
            
            sectionAreaSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            
            sectionAreaSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            
            customSectionAreaSlider!.topAnchor.constraint(equalTo: sectionAreaSliderTitle.bottomAnchor, constant: areaOfSectionRangeSliderTopPadding),
            
            customSectionAreaSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: customRangeSlidersLeftAndRightPadding),
            
            customSectionAreaSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (customRangeSlidersLeftAndRightPadding)),
            
            resetFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: resetFiltersButtonTopPadding),
            
            resetFiltersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ((((view.frame.size.width) / 2) - (resetFiltersButton.intrinsicContentSize.width)) / 2)),
            
            resetFiltersButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -1 * ((((view.frame.size.width) / 2) - (resetFiltersButton.intrinsicContentSize.width)) / 2)),
            
            applyFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: applyFiltersButtonTopPadding),
            
            applyFiltersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * ((((view.frame.size.width) / 2) - (applyFiltersButton.intrinsicContentSize.width)) / 2)),
            
            applyFiltersButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: ((((view.frame.size.width) / 2) - (applyFiltersButton.intrinsicContentSize.width)) / 2)),
            
        ])
        
    }
    
}


// MARK: - Extensions:

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
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionArea = extractedSectionArea {
            
            minimumDepthOfSection = extractedDepthOfSection.min()
            
            minimumWidthOfSection = extractedWidthOfSection.min()
            
            minimumSectionWebThickness = extractedSectionWebThickness.min()
            
            minimumSectionFlangeThickness = extractedSectionFlangeThickness.min()
            
            minimumAreaOfSection = extractedSectionArea.min()
            
        }
        
        if minValue == CGFloat(minimumDepthOfSection!) || minValue == CGFloat(minimumWidthOfSection!) || minValue == CGFloat(minimumSectionWebThickness!) || minValue == CGFloat(minimumSectionFlangeThickness!) || minValue == CGFloat(minimumAreaOfSection!) {
            
            return "Min"
            
        } else {
            
            let minimumSliderLabelString: String? = slider.numberFormatter.string(from: minValue as NSNumber)
            
            return minimumSliderLabelString ?? ""
            
        }
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionArea = extractedSectionArea {
            
            maximumDepthOfSection = extractedDepthOfSection.max()
            
            maximumWidthOfSection = extractedWidthOfSection.max()
            
            maximumSectionWebThickness = extractedSectionWebThickness.max()
            
            maximumSectionFlangeThickness = extractedSectionFlangeThickness.max()
            
            maximumAreaOfSection = extractedSectionArea.max()
            
        }
        
        if maxValue == CGFloat(maximumDepthOfSection!) || maxValue == CGFloat(maximumWidthOfSection!) || maxValue == CGFloat(maximumSectionWebThickness!) || maxValue == CGFloat(maximumSectionFlangeThickness!) || maxValue == CGFloat(maximumAreaOfSection!
            ) {
            
            return "Max"
            
        } else {
            
            let maximumSliderLabelString: String? = slider.numberFormatter.string(from: maxValue as NSNumber)
            
            return maximumSliderLabelString ?? ""
            
        }
        
    }
    
}
