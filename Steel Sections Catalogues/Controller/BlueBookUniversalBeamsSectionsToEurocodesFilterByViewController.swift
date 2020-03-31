//
//  FilterDataVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/1/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import RangeSeekSlider

class BlueBookUniversalBeamsSectionsToEurocodesFilterByViewController: UIViewController {
    
    // MARK: - Assigning protocol delegate:
    
    var delegate: PassingDataBackwardsProtocol?
    
    // MARK: - Instance scope variables and constants declarations:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed from BlueBookUniversalBeamsVC, and when this ViewController gets dismissed, any made changes to these variables will be sent back to BlueBookUniversalBeamsVC using the Protocol:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    var universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC = [IsectionsDimensionsParameters]()
    
    let rangeSliderTitleTopPaddingFromNavigationBarBottom: CGFloat = 20
    
    let rangeSliderTitleLeftAndRightPadding: CGFloat = 20
    
    let rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle: CGFloat = 10
    
    let rangeSliderTrackLeftAndRightPadding: CGFloat = 15
    
    let verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel: CGFloat = 10
                    
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
        
        button.setTitle("Clear Filters", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        button.setTitleColor(UIColor(named: "Filter View Controller Clear & Apply Filters Buttons Text Colour - Normal State"), for: .normal)
        
        button.setTitleColor(UIColor(named: "Filter View Controller Clear & Apply Filters Buttons Text Colour - Highlighted State"), for: .highlighted)
        
        button.titleLabel?.numberOfLines = 1
        
        button.tag = 1
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    var applyFiltersButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Apply Filters", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        button.setTitleColor(UIColor(named: "Filter View Controller Clear & Apply Filters Buttons Text Colour - Normal State"), for: .normal)
        
        button.setTitleColor(UIColor(named: "Filter View Controller Clear & Apply Filters Buttons Text Colour - Highlighted State"), for: .highlighted)
        
        button.titleLabel?.numberOfLines = 1
        
        button.tag = 2
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = UIColor(named: "Filter Results View Controller Background Colour")
        
        return scrollView
        
    }()
    
    let depthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Depth of Section, h [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 35, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let widthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Width of Section, b [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 35, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionWebThicknessSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Web Thickness, tw [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 40, abbreviationLettersLength: 2, containsSubScriptLetters: true, subScriptLettersStartingLocation: 41, subScriptLettersLength: 1, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionFlangeThicknessSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Flange Thickness, tf [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 43, abbreviationLettersLength: 2, containsSubScriptLetters: true, subScriptLettersStartingLocation: 44, subScriptLettersLength: 1, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionAreaSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Area of Section, A [cm2]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 34, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: true, superScriptLettersStartingLocation: 39, superScriptLettersLength: 1)
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "UB Data Filter", navBarDelegate: self)
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // In order to prevent the movement of a UISlider's trackers to get confused with a swipeGesture (i.e. avoid the swipeGesture to get triggered when a user moves one of the slider's trackers in the right direction, which also correspond to the direction of the swipeGesture). We need to add a panGesture to the UISlider, whereby the panGesture does nothing at all. Then we need to set the cancelsTouchesInView property to be equal to false. As this will prevent the delivery of gestures to the view. Note that a UIGestureRecognizer is to be used with a single view:
        
        let panGestureRecogniseForDepthOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForDepthOfSectionUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForWidthOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForWidthOfSectionUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForWebThicknessUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForWebThicknessUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForFlangeThicknessUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForFlangeThicknessUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForAreaOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForAreaOfSectionUISlider.cancelsTouchesInView = false
        
        // MARK: - Adding right swipe gesture:
        
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(navigationBarLeftButtonPressed(sender:)))
                
        rightGestureRecognizer.direction = .right
        
        // MARK: - Extracting appropriate Arrays data for Range Sliders:
        
        extractedDepthOfSection = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.depthOfSection })
        
        extractedWidthOfSection = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.widthOfSection })
        
        extractedSectionWebThickness = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.sectionWebThickness })
        
        extractedSectionFlangeThickness = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.sectionFlangeThickness })
        
        extractedSectionArea = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.map({ return $0.areaOfSection })
        
        // MARK: - Declaring range sliders:
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionArea = extractedSectionArea {
            
            customDepthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedDepthOfSection, minimumDistanceBetweenSliders: 80)
            
            customWidthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedWidthOfSection, minimumDistanceBetweenSliders: 30)
            
            customSectionWebThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionWebThickness, minimumDistanceBetweenSliders: 3)
            
            customSectionFlangeThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionFlangeThickness, minimumDistanceBetweenSliders: 5)
            
            customSectionAreaSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionArea, minimumDistanceBetweenSliders: 55)
            
        }
        
        // MARK: - Setting Range Sliders delegates:
        
        customDepthOfSectionRangeSlider!.delegate = self
        
        customWidthOfSectionRangeSlider!.delegate = self
        
        customSectionWebThicknessSlider!.delegate = self
        
        customSectionFlangeThicknessSlider!.delegate = self
        
        customSectionAreaSlider!.delegate = self
        
        // MARK: - Adding subViews:
        
        view.addSubview(navigationBar)
        
        view.addGestureRecognizer(rightGestureRecognizer)
        
        customDepthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForDepthOfSectionUISlider)
        
        customWidthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForWidthOfSectionUISlider)
        
        customSectionWebThicknessSlider!.addGestureRecognizer(panGestureRecogniseForWebThicknessUISlider)
        
        customSectionFlangeThicknessSlider!.addGestureRecognizer(panGestureRecogniseForFlangeThicknessUISlider)
        
        customSectionAreaSlider!.addGestureRecognizer(panGestureRecogniseForAreaOfSectionUISlider)
        
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
                
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
                
        let clearFiltersButtonCoordinatesInRelationToItsScrollView = applyFiltersButton.convert(applyFiltersButton.bounds.origin, to: scrollView)
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: clearFiltersButtonCoordinatesInRelationToItsScrollView.y + applyFiltersButton.intrinsicContentSize.height + rangeSliderTitleTopPaddingFromNavigationBarBottom)
        
    // MARK: - Calling the setupConstraints function:
    
    setupConstraints()
            
        }
    
    override func viewDidAppear(_ animated: Bool) {
                
        self.scrollView.flashScrollIndicators()

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
            
            var filteredArrayToBeSentBack = [IsectionsDimensionsParameters]()
            
            if customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!) {
                
                filteredArrayToBeSentBack = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: filteredArrayToBeSentBack, sortBy: "None", filtersApplied: false, isSearching: false)
                
            } else {
                
                if delegate != nil {
                    
                    filteredArrayToBeSentBack = universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.filter( { return (($0.depthOfSection >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.depthOfSection <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue)) && ($0.widthOfSection >= Double(customWidthOfSectionRangeSlider!.selectedMinValue)) && ($0.widthOfSection <= Double(customWidthOfSectionRangeSlider!.selectedMaxValue)) && ($0.sectionWebThickness >= Double(customSectionWebThicknessSlider!.selectedMinValue)) && ($0.sectionWebThickness <= Double(customSectionWebThicknessSlider!.selectedMaxValue)) && ($0.sectionFlangeThickness >= Double(customSectionFlangeThicknessSlider!.selectedMinValue)) && ($0.sectionFlangeThickness <= Double(customSectionFlangeThicknessSlider!.selectedMaxValue)) && ($0.areaOfSection >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.areaOfSection <= Double(customSectionAreaSlider!.selectedMaxValue))) } )
                    
                    delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: filteredArrayToBeSentBack, sortBy: "None", filtersApplied: true, isSearching: false)
                    
                }
                
            }
            
            
            
            dismiss(animated: true, completion: {})
            
        }
        
    }
    
    // MARK: - Defining the setupConstraints function:
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),

            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                        
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            depthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: rangeSliderTitleTopPaddingFromNavigationBarBottom),
            
            depthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTitleLeftAndRightPadding),
            
            depthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTitleLeftAndRightPadding),
            
            customDepthOfSectionRangeSlider!.topAnchor.constraint(equalTo: depthOfSectionRangeSliderTitle.bottomAnchor, constant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle),
            
            customDepthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTrackLeftAndRightPadding),
            
            customDepthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTrackLeftAndRightPadding),
            
            widthOfSectionRangeSliderTitle.topAnchor.constraint(equalTo: customDepthOfSectionRangeSlider!.bottomAnchor, constant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel),
            
            widthOfSectionRangeSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTitleLeftAndRightPadding),
            
            widthOfSectionRangeSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTitleLeftAndRightPadding),
                        
            customWidthOfSectionRangeSlider!.topAnchor.constraint(equalTo: widthOfSectionRangeSliderTitle.bottomAnchor, constant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle),
            
            customWidthOfSectionRangeSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTrackLeftAndRightPadding),
            
            customWidthOfSectionRangeSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTrackLeftAndRightPadding),
            
            sectionWebThicknessSliderTitle.topAnchor.constraint(equalTo: customWidthOfSectionRangeSlider!.bottomAnchor, constant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel),
            
            sectionWebThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTitleLeftAndRightPadding),
            
            sectionWebThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTitleLeftAndRightPadding),
                        
            customSectionWebThicknessSlider!.topAnchor.constraint(equalTo: sectionWebThicknessSliderTitle.bottomAnchor, constant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle),
            
            customSectionWebThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTrackLeftAndRightPadding),
            
            customSectionWebThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTrackLeftAndRightPadding),
                        
            sectionFlangeThicknessSliderTitle.topAnchor.constraint(equalTo: customSectionWebThicknessSlider!.bottomAnchor, constant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel),
            
            sectionFlangeThicknessSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTitleLeftAndRightPadding),
            
            sectionFlangeThicknessSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTitleLeftAndRightPadding),
                        
            customSectionFlangeThicknessSlider!.topAnchor.constraint(equalTo: sectionFlangeThicknessSliderTitle.bottomAnchor, constant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle),
            
            customSectionFlangeThicknessSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTrackLeftAndRightPadding),
            
            customSectionFlangeThicknessSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTrackLeftAndRightPadding),
            
            sectionAreaSliderTitle.topAnchor.constraint(equalTo: customSectionFlangeThicknessSlider!.bottomAnchor, constant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel),
            
            sectionAreaSliderTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * rangeSliderTitleLeftAndRightPadding),

            sectionAreaSliderTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTitleLeftAndRightPadding),
                        
            customSectionAreaSlider!.topAnchor.constraint(equalTo: sectionAreaSliderTitle.bottomAnchor, constant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle),
            
            customSectionAreaSlider!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * (rangeSliderTrackLeftAndRightPadding)),
            
            customSectionAreaSlider!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: rangeSliderTrackLeftAndRightPadding),
                        
            resetFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: rangeSliderTitleTopPaddingFromNavigationBarBottom),

            resetFiltersButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * (self.view.frame.width/4)),

            applyFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: rangeSliderTitleTopPaddingFromNavigationBarBottom),

            applyFiltersButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width/4)
            
        ])
        
    }
    
}


// MARK: - Extensions:

extension BlueBookUniversalBeamsSectionsToEurocodesFilterByViewController: UINavigationBarDelegate {
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "BlueBookUniversalBeamsSectionsToEurocodesViewController")
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

extension BlueBookUniversalBeamsSectionsToEurocodesFilterByViewController: RangeSeekSliderDelegate {
    
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
