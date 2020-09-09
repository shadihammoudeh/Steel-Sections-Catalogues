//
//  FilterDataVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 9/1/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import RangeSeekSlider

class TableViewSteelSectionsDataFilterOptions: UIViewController {
    
    // MARK: - Assigning protocol delegate in order to be able to pass data back to the previous VC once this VC has been dismissed:
    
    weak var delegate: PassingDataBackwardsBetweenViewControllersProtocol?
    
    // The below line of code define a main big Array, whereby inside of it there are multiple Arrays, whereby each Array inside the big Array contain Dictionaries inside of it. The below big Array is required in order to define the minimum distance between each range slider's handles depending on the value being modified as well as the chosen open rolled steel section:
    
    let eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing: [[String: CGFloat]] = [["h": 65, "b": 25, "l": 0, "tw": 2.5, "tf": 4, "t": 0, "A": 50], ["h": 32, "b": 23, "l": 0, "tw": 6.5, "tf": 9, "t": 0, "A": 115], ["h": 11, "b": 12, "l": 0, "tw": 1.5, "tf": 1.5, "t": 0, "A": 16], ["h": 23, "b": 3.5, "l": 0, "tw": 0.45, "tf": 0.75, "t": 0, "A": 5], ["h": 0, "b": 0, "l": 12, "tw": 0, "tf": 0, "t": 1.5, "A": 6], ["h": 12, "b": 9, "l": 0, "tw": 0, "tf": 0, "t": 1, "A": 4], ["h": 16, "b": 15, "l": 0, "tw": 1, "tf": 2.25, "t": 0, "A": 11], ["h": 6, "b": 11.5, "l": 0, "tw": 0.95, "tf": 1.75, "t": 0, "A": 6.25]]
    
    // MARK: - Instance scope variables and constants declarations:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed from BlueBookUniversalBeamsVC, and when this ViewController gets dismissed, any made changes to these variables will be sent back to BlueBookUniversalBeamsVC using the Protocol:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    // This array of dictionary arrays will be passed from the previous VC once this VC has been displayed, and appropriate filtering and sorting will be applied to it in this VC depending on the user filtering criteria, then the modified version of this array will be pass back to the previous VC using the protocol in order to display the data inside the tableVC:
    
    var receivedSteelSectionsDataArrayFromSteelSectionsTableViewController = [SteelSectionParameters]()
    
    var userLastSelectedCollectionViewCellNumber: Int = 0
    
    let navigationBarTitleForOpenRolledSteelSections: [String] = ["UB Data Filters", "UC Data Filters", "UBP Data Filters", "PFC Data Filters", "Equal Leg Angles Data Filters", "Unequal Leg Angles Data Filters", "T split from UB Data Filters", "T split from UC Data Filters"]
    
    let movingOutTransition = CATransition()
    
    let rangeSliderTitleTopPaddingFromNavigationBarBottom: CGFloat = 20
    
    let rangeSliderTitleLeftAndRightPadding: CGFloat = 20
    
    let rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle: CGFloat = 10
    
    let rangeSliderTrackLeftAndRightPadding: CGFloat = 15
    
    let verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel: CGFloat = 10
    
    var extractedDepthOfSection: [Double]?
    
    var extractedWidthOfSection: [Double]?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg sections:
    
    var extractedSectionLegLength: [Double]?
    
    var extractedSectionWebThickness: [Double]?
    
    var extractedSectionFlangeThickness: [Double]?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg and Unequal Angle Leg sections:
    
    var extractedSectionLegThickness: [Double]?
    
    var extractedSectionArea: [Double]?
    
    var customDepthOfSectionRangeSlider: RangeSeekSlider?
    
    var customWidthOfSectionRangeSlider: RangeSeekSlider?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg sections:
    
    var customSectionLegLengthRangeSlider: RangeSeekSlider?
    
    var customSectionWebThicknessSlider: RangeSeekSlider?
    
    var customSectionFlangeThicknessSlider: RangeSeekSlider?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg and Unequal Angle Leg sections:
    
    var customSectionLegThicknessSlider: RangeSeekSlider?
    
    var customSectionAreaSlider: RangeSeekSlider?
    
    var minimumDepthOfSection: Double?
    
    var minimumWidthOfSection: Double?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg sections:
    
    var minimumSectionLegLength: Double?
    
    var minimumSectionWebThickness: Double?
    
    var minimumSectionFlangeThickness: Double?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg and Unequal Angle Leg sections:
    
    var minimumSectionLegThickness: Double?
    
    var minimumAreaOfSection: Double?
    
    var maximumDepthOfSection: Double?
    
    var maximumWidthOfSection: Double?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg sections:
    
    var maximumSectionLegLength: Double?
    
    var maximumSectionWebThickness: Double?
    
    var maximumSectionFlangeThickness: Double?
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg and Unequal Angle Leg sections:
    
    var maximumSectionLegThickness: Double?
    
    var maximumAreaOfSection: Double?
    
    var resetFiltersButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle("Clear Filters", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        button.setTitleColor(UIColor(named: "Filter Results VC - Clear & Apply Buttons Text Colour - Normal"), for: .normal)
        
        button.setTitleColor(UIColor(named: "Filter Results VC - Clear & Apply Buttons Text Colour - Highlighted State"), for: .highlighted)
        
        button.showsTouchWhenHighlighted = true
        
        button.tag = 1
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    var applyFiltersButton: UIButton = {
        
        let button = UIButton(type: .custom)
        
        button.setTitle("Apply Filters", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        button.setTitleColor(UIColor(named: "Filter Results VC - Clear & Apply Buttons Text Colour - Normal"), for: .normal)
        
        button.setTitleColor(UIColor(named: "Filter Results VC - Clear & Apply Buttons Text Colour - Highlighted State"), for: .highlighted)
        
        button.showsTouchWhenHighlighted = true
        
        button.tag = 2
        
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = UIColor(named: "Filter Results VC - Scroll View Background Colour")
        
        return scrollView
        
    }()
    
    let depthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Depth of Section, h [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 35, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let widthOfSectionRangeSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Width of Section, b [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 35, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    // The below will be used for Open Rolled Steel Section, Equal Angle Leg sections:
    
    let sectionLegLengthRangeSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Leg Length, h [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 37, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionWebThicknessSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Web Thickness, tw [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 40, abbreviationLettersLength: 2, containsSubScriptLetters: true, subScriptLettersStartingLocation: 41, subScriptLettersLength: 1, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionFlangeThicknessSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Flange Thickness, tf [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 43, abbreviationLettersLength: 2, containsSubScriptLetters: true, subScriptLettersStartingLocation: 44, subScriptLettersLength: 1, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    // The below will be used for Open Rolled Steel Section, Equal and Unequal Angle Leg sections:
    
    let sectionLegThicknessSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Section Leg Thickness, t [mm]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 40, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 0)
    
    let sectionAreaSliderTitle = CustomRangeSliderUILabel(rangeSliderTitle: "Range Slider for Area of Section, A [cm2]:", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 34, abbreviationLettersLength: 1, containsSubScriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptletters: true, superScriptLettersStartingLocation: 39, superScriptLettersLength: 1)
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "\(self.navigationBarTitleForOpenRolledSteelSections[self.userLastSelectedCollectionViewCellNumber])", navBarDelegate: self)
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupMoveOutTransition()
        
        // In order to prevent the movement of a UISlider's trackers to get confused with a swipeGesture (i.e. avoid the swipeGesture to get triggered when a user moves one of the slider's trackers in the right direction, which also correspond to the direction of the swipeGesture). We need to add a panGesture to the UISlider, whereby the panGesture does nothing at all. Then we need to set the cancelsTouchesInView property to be equal to false. As this will prevent the delivery of gestures to the view. Note that a UIGestureRecognizer is to be used with a single view:
        
        let panGestureRecogniseForDepthOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForDepthOfSectionUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForWidthOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForWidthOfSectionUISlider.cancelsTouchesInView = false
        
        let panGestureRecgoniserForSectionLegLengthUISlider = UIPanGestureRecognizer(target: nil, action: nil)
        
        panGestureRecgoniserForSectionLegLengthUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForWebThicknessUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForWebThicknessUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForFlangeThicknessUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForFlangeThicknessUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniserForSectionLegThicknessUISlider = UIPanGestureRecognizer(target: nil, action: nil)
        
        panGestureRecogniserForSectionLegThicknessUISlider.cancelsTouchesInView = false
        
        let panGestureRecogniseForAreaOfSectionUISlider = UIPanGestureRecognizer(target: nil, action:nil)
        
        panGestureRecogniseForAreaOfSectionUISlider.cancelsTouchesInView = false
        
        // MARK: - Adding right swipe gesture to allow the user to go back to the previous VC when a right swipe gesture is detected:
        
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(navigationBarLeftButtonPressed(sender:)))
        
        rightGestureRecognizer.direction = .right
        
        // MARK: - Extracting appropriate Arrays data for Range Sliders:
        
        extractedDepthOfSection = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionTotalDepth })
        
        extractedWidthOfSection = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionWidth })
        
        extractedSectionLegLength = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionLegLength })
        
        extractedSectionWebThickness = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionWebThickness })
        
        extractedSectionFlangeThickness = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionFlangeThickness })
        
        extractedSectionLegThickness = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionLegThickness })
        
        extractedSectionArea = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.map({ return $0.sectionArea })
        
        // MARK: - Declaring range sliders:
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionLegLength = extractedSectionLegLength, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionLegThickness = extractedSectionLegThickness, let extractedSectionArea = extractedSectionArea {
            
            customDepthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedDepthOfSection, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["h"]!)
            
            customWidthOfSectionRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedWidthOfSection, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["b"]!)
            
            // The below Range Slider will be displayed when the user selects Open Rolled Equal Angle Sections:
            
            customSectionLegLengthRangeSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionLegLength, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["l"]!)
            
            customSectionWebThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionWebThickness, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["tw"]!)
            
            customSectionFlangeThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionFlangeThickness, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["tf"]!)
            
            // The below Range Slider will be displayed when the user selects Open Rolled Equal and Unequal Angle Leg Sections:
            
            customSectionLegThicknessSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionLegThickness, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["t"]!)
            
            customSectionAreaSlider = CustomRangeSeekSlider(sectionPropertyDataArrayForRangeSlide: extractedSectionArea, minimumDistanceBetweenSliders: eurocodeOpenRolledSteelSectionRangeSliderHandlesMinimumSpacing[userLastSelectedCollectionViewCellNumber]["A"]!)
            
        }
        
        // MARK: - Setting Range Sliders delegates:
        
        customDepthOfSectionRangeSlider!.delegate = self
        
        customWidthOfSectionRangeSlider!.delegate = self
        
        customSectionLegLengthRangeSlider!.delegate = self
        
        customSectionWebThicknessSlider!.delegate = self
        
        customSectionFlangeThicknessSlider!.delegate = self
        
        customSectionLegThicknessSlider!.delegate = self
        
        customSectionAreaSlider!.delegate = self
        
        // MARK: - Adding subViews:
        
        view.addSubview(navigationBar)
        
        view.addGestureRecognizer(rightGestureRecognizer)
        
        view.addSubview(scrollView)
        
        // The below will be executed for all Open Rolled Steel Sections expect Equal and Unequal Leg Sections:
        
        if userLastSelectedCollectionViewCellNumber != 4 && userLastSelectedCollectionViewCellNumber != 5 {
            
            customDepthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForDepthOfSectionUISlider)
            
            scrollView.addSubview(depthOfSectionRangeSliderTitle)
            
            scrollView.addSubview(customDepthOfSectionRangeSlider!)
            
            customWidthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForWidthOfSectionUISlider)
            
            scrollView.addSubview(widthOfSectionRangeSliderTitle)
            
            scrollView.addSubview(customWidthOfSectionRangeSlider!)
            
            customSectionWebThicknessSlider!.addGestureRecognizer(panGestureRecogniseForWebThicknessUISlider)
            
            scrollView.addSubview(sectionWebThicknessSliderTitle)
            
            scrollView.addSubview(customSectionWebThicknessSlider!)
            
            customSectionFlangeThicknessSlider!.addGestureRecognizer(panGestureRecogniseForFlangeThicknessUISlider)
            
            scrollView.addSubview(sectionFlangeThicknessSliderTitle)
            
            scrollView.addSubview(customSectionFlangeThicknessSlider!)
            
        }
            
            // The below IF STATEMENT will be executed for Open Rolled Steel Equal Angle Leg Sections:
            
        else if userLastSelectedCollectionViewCellNumber == 4 {
            
            customSectionLegLengthRangeSlider!.addGestureRecognizer(panGestureRecgoniserForSectionLegLengthUISlider)
            
            scrollView.addSubview(sectionLegLengthRangeSliderTitle)
            
            scrollView.addSubview(customSectionLegLengthRangeSlider!)
            
            customSectionLegThicknessSlider!.addGestureRecognizer(panGestureRecogniserForSectionLegThicknessUISlider)
            
            scrollView.addSubview(sectionLegThicknessSliderTitle)
            
            scrollView.addSubview(customSectionLegThicknessSlider!)
            
        }
            
            // The below will be executed for Open Rolled Steel Unequal Leg Sections:
            
        else {
            
            customDepthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForDepthOfSectionUISlider)
            
            scrollView.addSubview(depthOfSectionRangeSliderTitle)
            
            scrollView.addSubview(customDepthOfSectionRangeSlider!)
            
            customWidthOfSectionRangeSlider!.addGestureRecognizer(panGestureRecogniseForWidthOfSectionUISlider)
            
            scrollView.addSubview(widthOfSectionRangeSliderTitle)
            
            scrollView.addSubview(customWidthOfSectionRangeSlider!)
            
            customSectionLegThicknessSlider!.addGestureRecognizer(panGestureRecogniserForSectionLegThicknessUISlider)
            
            scrollView.addSubview(sectionLegThicknessSliderTitle)
            
            scrollView.addSubview(customSectionLegThicknessSlider!)
            
        }
        
        customSectionAreaSlider!.addGestureRecognizer(panGestureRecogniseForAreaOfSectionUISlider)
        
        scrollView.addSubview(sectionAreaSliderTitle)
        
        scrollView.addSubview(customSectionAreaSlider!)
        
        scrollView.addSubview(resetFiltersButton)
        
        scrollView.addSubview(applyFiltersButton)
        
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
        
        let clearFiltersButtonCoordinatesInRelationToItsScrollView = applyFiltersButton.convert(applyFiltersButton.bounds.origin, to: scrollView)
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: clearFiltersButtonCoordinatesInRelationToItsScrollView.y + applyFiltersButton.intrinsicContentSize.height + rangeSliderTitleTopPaddingFromNavigationBarBottom)
        
        // MARK: - Calling the setupConstraints function:
        
        setupNavigationBarAndScrollViewAndClearAndApplyButtonsConstraints()
        
        if userLastSelectedCollectionViewCellNumber != 4 && userLastSelectedCollectionViewCellNumber != 5 {
            
            setupConstraintsForAllOpenSteelSectionsExceptEqualAndUnequalLegSections()
            
        } else if userLastSelectedCollectionViewCellNumber == 4 {
            
            setupConstraintsForOpenSteelSectionsEqualLegAngles()
            
        } else {
            
            setupConstraintsForOpenSteelSectionsUnequalLegAngles()
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.scrollView.flashScrollIndicators()
        
    }
    
    func setupMoveOutTransition() {
        
        movingOutTransition.duration = 0.65
        
        movingOutTransition.type = CATransitionType.reveal
        
        movingOutTransition.subtype = CATransitionSubtype.fromTop
        
        movingOutTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
    }
    
    // MARK: - Button pressed method:
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        // MARK: - Clear Filters button pressed:
        
        if sender.tag == 1 {
            
            // The below IF STATEMENT will be executed for all Open Rolled Steel Sections except Equal and Unequal Angle Leg Sections:
            
            if userLastSelectedCollectionViewCellNumber != 4 && userLastSelectedCollectionViewCellNumber != 5 {
                
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
                
                // The below line of code will be executed for Open Rolled Equal Angle Steel Sections:
                
            else if userLastSelectedCollectionViewCellNumber == 4 {
                
                if let minimumSectionLegLength = minimumSectionLegLength, let maximumSectionLegLength = maximumSectionLegLength, let minimumSectionLegThickness = minimumSectionLegThickness, let maximumSectionLegThickness = maximumSectionLegThickness, let minimumSectionArea = minimumAreaOfSection, let maximumSectionArea = maximumAreaOfSection {
                    
                    customSectionLegLengthRangeSlider?.selectedMinValue = CGFloat(minimumSectionLegLength)
                    
                    customSectionLegLengthRangeSlider?.selectedMaxValue = CGFloat(maximumSectionLegLength)
                    
                    customSectionLegLengthRangeSlider?.layoutSubviews()
                    
                    customSectionLegThicknessSlider?.selectedMinValue = CGFloat(minimumSectionLegThickness)
                    
                    customSectionLegThicknessSlider?.selectedMaxValue = CGFloat(maximumSectionLegThickness)
                    
                    customSectionLegThicknessSlider?.layoutSubviews()
                    
                    customSectionAreaSlider?.selectedMinValue = CGFloat(minimumSectionArea)
                    
                    customSectionAreaSlider?.selectedMaxValue = CGFloat(maximumSectionArea)
                    
                    customSectionAreaSlider?.layoutSubviews()
                    
                }
                
            } else {
                
                if let minimumDepthOfSection = minimumDepthOfSection, let maximumDepthOfSection = maximumDepthOfSection, let minimumWidthOfSection = minimumWidthOfSection, let maximumWidthOfSection = maximumWidthOfSection, let minimumSectionLegThickness = minimumSectionLegThickness, let maximumSectionLegThickness = maximumSectionLegThickness , let minimumSectionArea = minimumAreaOfSection, let maximumSectionArea = maximumAreaOfSection {
                    
                    customDepthOfSectionRangeSlider?.selectedMinValue = CGFloat(minimumDepthOfSection)
                    
                    customDepthOfSectionRangeSlider?.selectedMaxValue = CGFloat(maximumDepthOfSection)
                    
                    customDepthOfSectionRangeSlider?.layoutSubviews()
                    
                    customWidthOfSectionRangeSlider!.selectedMinValue = CGFloat(minimumWidthOfSection)
                    
                    customWidthOfSectionRangeSlider!.selectedMaxValue = CGFloat(maximumWidthOfSection)
                    
                    customWidthOfSectionRangeSlider?.layoutSubviews()
                    
                    customSectionLegThicknessSlider?.selectedMinValue = CGFloat(minimumSectionLegThickness)
                    
                    customSectionLegThicknessSlider?.selectedMaxValue = CGFloat(maximumSectionLegThickness)
                    
                    customSectionLegThicknessSlider?.layoutSubviews()
                    
                    customSectionAreaSlider?.selectedMinValue = CGFloat(minimumSectionArea)
                    
                    customSectionAreaSlider?.selectedMaxValue = CGFloat(maximumSectionArea)
                    
                    customSectionAreaSlider?.layoutSubviews()
                    
                }
                
            }
            
        }
            
            // MARK: - Apply Filters button pressed:
            
        else if sender.tag == 2 {
            
            var filteredArrayToBeSentBack = [SteelSectionParameters]()
            
            // The below IF STATEMENT will be triggered whenever the user has selected any Open Rolled Steel section apart from Equal and Unequal Leg Angle Sections:
            
            if userLastSelectedCollectionViewCellNumber != 4 && userLastSelectedCollectionViewCellNumber != 5 {
                
                // The below IF STATEMEMT represents the case where the user has first tapped on the CLEAR FILTERS button and then hit the APPLY BUTTON, basically in this case the user will be redirected to the tableViewVC with no filters applied and data will be sorted in Section Designation in Ascending order:
                
                if (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                    
                    filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: true, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                } else {
                    
                    // The below IF STATEMENT represents the case where the user only applied filters to the total depth of the section, in this case filtered data will be sorted by Section Depth in Ascending order:
                    
                    if (customDepthOfSectionRangeSlider?.selectedMinValue != CGFloat(minimumDepthOfSection!) || customDepthOfSectionRangeSlider?.selectedMaxValue != CGFloat(maximumDepthOfSection!)) && (customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionTotalDepth >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionTotalDepth <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue))) })
                        
                        // The below code will sort out the results to be displayed according to their totalDepth in ascending order:
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionTotalDepth != $1.sectionTotalDepth {
                                
                                return $0.sectionTotalDepth < $1.sectionTotalDepth
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below IF STATEMENT represents the case where the user has filtered results only by their Width, in this instance filtered data will be sorted by Width of Section in Ascending Order:
                        
                    else if (customWidthOfSectionRangeSlider?.selectedMinValue != CGFloat(minimumWidthOfSection!) || customWidthOfSectionRangeSlider?.selectedMaxValue != CGFloat(maximumWidthOfSection!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionWidth >= Double(customWidthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionWidth <= Double(customWidthOfSectionRangeSlider!.selectedMaxValue))) })
                        
                        // The below code will sort out the results to be displayed according to their totalDepth in ascending order:
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionWidth != $1.sectionWidth {
                                
                                return $0.sectionWidth < $1.sectionWidth
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below case will be triggered when the user filter results only by Section Web Thickness, filtered data will be sorted by Section WEb Thickness in Ascending order:
                        
                    else if (customSectionWebThicknessSlider?.selectedMinValue != CGFloat(minimumSectionWebThickness!) || customSectionWebThicknessSlider?.selectedMaxValue != CGFloat(maximumSectionWebThickness!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionWebThickness >= Double(customSectionWebThicknessSlider!.selectedMinValue)) && ($0.sectionWebThickness <= Double(customSectionWebThicknessSlider!.selectedMaxValue))) })
                        
                        // The below code will sort out the results to be displayed according to their totalDepth in ascending order:
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionWebThickness != $1.sectionWebThickness {
                                
                                return $0.sectionWebThickness < $1.sectionWebThickness
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below IF STATEMENT will be triggered whenever the user filter data only by Section Flange Thickness, filtered data will be sorted in Section Flange Thickness in Ascending order:
                        
                    else if (customSectionFlangeThicknessSlider?.selectedMinValue != CGFloat(minimumSectionFlangeThickness!) || customSectionFlangeThicknessSlider?.selectedMaxValue != CGFloat(maximumSectionFlangeThickness!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionFlangeThickness >= Double(customSectionFlangeThicknessSlider!.selectedMinValue)) && ($0.sectionFlangeThickness <= Double(customSectionFlangeThicknessSlider!.selectedMaxValue))) })
                        
                        // The below code will sort out the results to be displayed according to their totalDepth in ascending order:
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionFlangeThickness != $1.sectionFlangeThickness {
                                
                                return $0.sectionFlangeThickness < $1.sectionFlangeThickness
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below IF STATEMENT will be triggered when the user has filtered results only by Section Area, filtered data will be sorted by Section Area in Ascending order:
                        
                    else if (customSectionAreaSlider?.selectedMinValue != CGFloat(minimumAreaOfSection!) || customSectionAreaSlider?.selectedMaxValue != CGFloat(maximumAreaOfSection!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionWebThicknessSlider?.selectedMinValue == CGFloat(minimumSectionWebThickness!) && customSectionWebThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionWebThickness!) && customSectionFlangeThicknessSlider?.selectedMinValue == CGFloat(minimumSectionFlangeThickness!) && customSectionFlangeThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionFlangeThickness!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) })
                        
                        // The below code will sort out the results to be displayed according to their totalDepth in ascending order:
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionArea != $1.sectionArea {
                                
                                return $0.sectionArea < $1.sectionArea
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below will get executed whenever the user selected multiple filtering criteria togther and hit the Apply button:
                        
                    else {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter( { return (($0.sectionTotalDepth >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionTotalDepth <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue)) && ($0.sectionWidth >= Double(customWidthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionWidth <= Double(customWidthOfSectionRangeSlider!.selectedMaxValue)) && ($0.sectionWebThickness >= Double(customSectionWebThicknessSlider!.selectedMinValue)) && ($0.sectionWebThickness <= Double(customSectionWebThicknessSlider!.selectedMaxValue)) && ($0.sectionFlangeThickness >= Double(customSectionFlangeThicknessSlider!.selectedMinValue)) && ($0.sectionFlangeThickness <= Double(customSectionFlangeThicknessSlider!.selectedMaxValue)) && ($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) } )
                        
                    }
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: false, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: true, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                }
                
            }
                
                // The below IF STATEMENT will be triggered for Open Rolled Steel Equal Angle Sections:
                
            else if userLastSelectedCollectionViewCellNumber == 4 {
                
                // The below IF STATEMEMT represents the case where the user has first tapped on the CLEAR FILTERS button and then hit the APPLY BUTTON, basically in this case the user will be redirected to the tableViewVC with no filters applied and data will be sorted in Section Designation in Ascending order:
                
                if (customSectionLegLengthRangeSlider?.selectedMinValue == CGFloat(minimumSectionLegLength!) && customSectionLegLengthRangeSlider?.selectedMaxValue == CGFloat(maximumSectionLegLength!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                    
                    filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: true, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                } else {
                    
                    // The below IF STATEMENT represents the case where the user only applied filters to the section leg length only, in this case filtered data will be sorted by Section Leg Length in Ascending order:
                    
                    if (customSectionLegLengthRangeSlider?.selectedMinValue != CGFloat(minimumSectionLegLength!) || customSectionLegLengthRangeSlider?.selectedMaxValue != CGFloat(maximumSectionLegLength!)) && (customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionLegLength >= Double(customSectionLegLengthRangeSlider!.selectedMinValue)) && ($0.sectionLegLength <= Double(customSectionLegLengthRangeSlider!.selectedMaxValue))) })
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionLegLength != $1.sectionLegLength {
                                
                                return $0.sectionLegLength < $1.sectionLegLength
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                        // The below IF STATEMENT represents the case where the user has filtered results only by their Section Leg Thickness, in this instance filtered data will be sorted by Section Leg Thickness in Ascending Order:
                        
                    else if (customSectionLegThicknessSlider?.selectedMinValue != CGFloat(minimumSectionLegThickness!) || customSectionLegThicknessSlider?.selectedMaxValue != CGFloat(maximumSectionLegThickness!)) && (customSectionLegLengthRangeSlider?.selectedMinValue == CGFloat(minimumSectionLegLength!) && customSectionLegLengthRangeSlider?.selectedMaxValue == CGFloat(maximumSectionLegLength!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionLegThickness >= Double(customSectionLegThicknessSlider!.selectedMinValue)) && ($0.sectionLegThickness <= Double(customSectionLegThicknessSlider!.selectedMaxValue))) })
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionLegThickness != $1.sectionLegThickness {
                                
                                return $0.sectionLegThickness < $1.sectionLegThickness
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                    // The below IF STATEMENT will be triggered when the user has filtered results only by Section Area, filtered data will be sorted by Section Area in Ascending order:
                        
                    else if (customSectionAreaSlider?.selectedMinValue != CGFloat(minimumAreaOfSection!) || customSectionAreaSlider?.selectedMaxValue != CGFloat(maximumAreaOfSection!)) && (customSectionLegLengthRangeSlider?.selectedMinValue == CGFloat(minimumSectionLegLength!) && customSectionLegLengthRangeSlider?.selectedMaxValue == CGFloat(maximumSectionLegLength!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) })
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionArea != $1.sectionArea {
                                
                                return $0.sectionArea < $1.sectionArea
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                    // The below will get executed whenever the user selected multiple filtering criteria togther and hit the Apply button:
                        
                    else {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter( { return (($0.sectionLegLength >= Double(customSectionLegLengthRangeSlider!.selectedMinValue)) && ($0.sectionLegLength <= Double(customSectionLegLengthRangeSlider!.selectedMaxValue)) && ($0.sectionLegThickness >= Double(customSectionLegThicknessSlider!.selectedMinValue)) && ($0.sectionLegThickness <= Double(customSectionLegThicknessSlider!.selectedMaxValue)) && ($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) } )
                        
                    }
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: false, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: true, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                }
                
            }
            
            // The below will be trigged for Open Rolled Unequal Steel Sections:
            
            else {
                
                // The below IF STATEMEMT represents the case where the user has first tapped on the CLEAR FILTERS button and then hit the APPLY BUTTON, basically in this case the user will be redirected to the tableViewVC with no filters applied and data will be sorted in Section Designation in Ascending order:
                
                if (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                    
                    filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: true, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                } else {
                    
                    // The below IF STATEMENT represents the case where the user only applied filters to the Depth of Section only, in this case filtered data will be sorted by Depth of Section in Ascending order:
                    
                    if (customDepthOfSectionRangeSlider?.selectedMinValue != CGFloat(minimumDepthOfSection!) || customDepthOfSectionRangeSlider?.selectedMaxValue != CGFloat(maximumDepthOfSection!)) && (customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionTotalDepth >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionTotalDepth <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue))) })
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionTotalDepth != $1.sectionTotalDepth {
                                
                                return $0.sectionTotalDepth < $1.sectionTotalDepth
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                    // The below IF STATEMENT represents the case where the user has filtered results only by their Width of Section, in this instance filtered data will be sorted by Width of Section in Ascending Order:
                        
                    else if (customWidthOfSectionRangeSlider?.selectedMinValue != CGFloat(minimumWidthOfSection!) || customWidthOfSectionRangeSlider?.selectedMaxValue != CGFloat(maximumWidthOfSection!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegLength!) && customSectionLegLengthRangeSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionWidth >= Double(customWidthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionWidth <= Double(customWidthOfSectionRangeSlider!.selectedMaxValue))) })
                        
                        filteredArrayToBeSentBack.sort {
                            
                            if $0.sectionWidth != $1.sectionWidth {
                                
                                return $0.sectionWidth < $1.sectionWidth
                                
                            } else {
                                
                                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                    
                                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                    
                                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                    
                                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                    
                                } else {
                                    
                                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                        
                    // The below IF STATEMENT will be triggered when the user has filtered results only by Section Leg Thickness, filtered data will be sorted by Section Leg Thickness in Ascending order:
                        
                    else if (customSectionLegThicknessSlider?.selectedMinValue != CGFloat(minimumSectionLegThickness!) || customSectionLegThicknessSlider?.selectedMaxValue != CGFloat(maximumSectionLegThickness!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionAreaSlider?.selectedMinValue == CGFloat(minimumAreaOfSection!) && customSectionAreaSlider?.selectedMaxValue == CGFloat(maximumAreaOfSection!)) {
                            
                            filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionLegThickness >= Double(customSectionLegThicknessSlider!.selectedMinValue)) && ($0.sectionLegThickness <= Double(customSectionLegThicknessSlider!.selectedMaxValue))) })
                            
                            filteredArrayToBeSentBack.sort {
                                
                                if $0.sectionLegThickness != $1.sectionLegThickness {
                                    
                                    return $0.sectionLegThickness < $1.sectionLegThickness
                                    
                                } else {
                                    
                                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                        
                                        return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                        
                                    } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                        
                                        return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                        
                                    } else {
                                        
                                        return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    // The below IF STATEMENT will be triggered when the user has filtered results only by Area of Section, filtered data will be sorted by Area of Section in Ascending order:

                    else if (customSectionAreaSlider?.selectedMinValue != CGFloat(minimumAreaOfSection!) || customSectionAreaSlider?.selectedMaxValue != CGFloat(maximumAreaOfSection!)) && (customDepthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumDepthOfSection!) && customDepthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumDepthOfSection!) && customWidthOfSectionRangeSlider?.selectedMinValue == CGFloat(minimumWidthOfSection!) && customWidthOfSectionRangeSlider?.selectedMaxValue == CGFloat(maximumWidthOfSection!) && customSectionLegThicknessSlider?.selectedMinValue == CGFloat(minimumSectionLegThickness!) && customSectionLegThicknessSlider?.selectedMaxValue == CGFloat(maximumSectionLegThickness!)) {
                            
                            filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter({ return (($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) })
                            
                            filteredArrayToBeSentBack.sort {
                                
                                if $0.sectionArea != $1.sectionArea {
                                    
                                    return $0.sectionArea < $1.sectionArea
                                    
                                } else {
                                    
                                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                                        
                                        return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                                        
                                    } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                                        
                                        return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                                        
                                    } else {
                                        
                                        return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        // The below will get executed whenever the user selected multiple filtering criteria togther and hit the Apply button:
                        
                    else {
                        
                        filteredArrayToBeSentBack = receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.filter( { return (($0.sectionTotalDepth >= Double(customDepthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionTotalDepth <= Double(customDepthOfSectionRangeSlider!.selectedMaxValue)) && ($0.sectionWidth >= Double(customWidthOfSectionRangeSlider!.selectedMinValue)) && ($0.sectionWidth <= Double(customWidthOfSectionRangeSlider!.selectedMaxValue)) && ($0.sectionLegThickness >= Double(customSectionLegThicknessSlider!.selectedMinValue)) && ($0.sectionLegThickness <= Double(customSectionLegThicknessSlider!.selectedMaxValue)) && ($0.sectionArea >= Double(customSectionAreaSlider!.selectedMinValue)) && ($0.sectionArea <= Double(customSectionAreaSlider!.selectedMaxValue))) } )
                        
                    }
                    
                    delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "TableViewSteelSectionsDataFilterOptions", filteringSlidersCleared: false, userLastSelectedCollectionViewCellNumber: self.userLastSelectedCollectionViewCellNumber, configuredArrayContainingSteelSectionsData: filteredArrayToBeSentBack, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "None", configuredFiltersAppliedVariable: true, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                    
                }
                
            }
            
            view.window!.layer.add(movingOutTransition, forKey: kCATransition)
            
            dismiss(animated: false, completion: {})
            
        }
        
    }
    
    // MARK: - Defining the setupConstraints function:
    
    func setupNavigationBarAndScrollViewAndClearAndApplyButtonsConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            resetFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: rangeSliderTitleTopPaddingFromNavigationBarBottom),
            
            resetFiltersButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * (self.view.frame.width/4)),
            
            applyFiltersButton.topAnchor.constraint(equalTo: customSectionAreaSlider!.bottomAnchor, constant: rangeSliderTitleTopPaddingFromNavigationBarBottom),
            
            applyFiltersButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width/4)
            
        ])
        
        scrollView.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: true, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: navigationBar.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: 0, rightAnchorConstant: 0, bottomAnchorConstant: 0, leftAnchorConstant: 0)
        
    }
    
    func setupConstraintsForAllOpenSteelSectionsExceptEqualAndUnequalLegSections() {
        
        depthOfSectionRangeSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: scrollView.topAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTitleTopPaddingFromNavigationBarBottom, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customDepthOfSectionRangeSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: depthOfSectionRangeSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        widthOfSectionRangeSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customDepthOfSectionRangeSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customWidthOfSectionRangeSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: widthOfSectionRangeSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionWebThicknessSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customWidthOfSectionRangeSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionWebThicknessSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionWebThicknessSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionFlangeThicknessSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customSectionWebThicknessSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionFlangeThicknessSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionFlangeThicknessSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionAreaSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customSectionFlangeThicknessSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionAreaSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionAreaSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
    }
    
    func setupConstraintsForOpenSteelSectionsEqualLegAngles() {
        
        sectionLegLengthRangeSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: scrollView.topAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTitleTopPaddingFromNavigationBarBottom, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionLegLengthRangeSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionLegLengthRangeSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionLegThicknessSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customSectionLegLengthRangeSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionLegThicknessSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionLegThicknessSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionAreaSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customSectionLegThicknessSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionAreaSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionAreaSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
    }
    
    func setupConstraintsForOpenSteelSectionsUnequalLegAngles() {
        
        depthOfSectionRangeSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: scrollView.topAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTitleTopPaddingFromNavigationBarBottom, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customDepthOfSectionRangeSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: depthOfSectionRangeSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        widthOfSectionRangeSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customDepthOfSectionRangeSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customWidthOfSectionRangeSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: widthOfSectionRangeSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionLegThicknessSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customWidthOfSectionRangeSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionLegThicknessSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionLegThicknessSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
        sectionAreaSliderTitle.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: customSectionLegThicknessSlider!.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: verticalSpacingBetweenBottomOfRangeSliderTrackAndTopOfRangeSliderTitleLabel, rightAnchorConstant: -1 * rangeSliderTitleLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTitleLeftAndRightPadding)
        
        customSectionAreaSlider!.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: sectionAreaSliderTitle.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: rangeSliderTrackTopPaddingFromBottomOfRangeSlideTitle, rightAnchorConstant: -1 * rangeSliderTrackLeftAndRightPadding, bottomAnchorConstant: 1, leftAnchorConstant: rangeSliderTrackLeftAndRightPadding)
        
    }
    
}

// MARK: - Extensions:

extension TableViewSteelSectionsDataFilterOptions: UINavigationBarDelegate {
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        view.window!.layer.add(movingOutTransition, forKey: kCATransition)
        
        dismiss(animated: false, completion: {})
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

extension TableViewSteelSectionsDataFilterOptions: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionLegLength = extractedSectionLegLength, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionLegThickness = extractedSectionLegThickness , let extractedSectionArea = extractedSectionArea {
            
            minimumDepthOfSection = extractedDepthOfSection.min()
            
            minimumWidthOfSection = extractedWidthOfSection.min()
            
            minimumSectionLegLength = extractedSectionLegLength.min()
            
            minimumSectionWebThickness = extractedSectionWebThickness.min()
            
            minimumSectionFlangeThickness = extractedSectionFlangeThickness.min()
            
            minimumSectionLegThickness = extractedSectionLegThickness.min()
            
            minimumAreaOfSection = extractedSectionArea.min()
            
        }
        
        if minValue == CGFloat(minimumDepthOfSection!) || minValue == CGFloat(minimumWidthOfSection!) || minValue == CGFloat(minimumSectionLegLength!) || minValue == CGFloat(minimumSectionWebThickness!) || minValue == CGFloat(minimumSectionFlangeThickness!) || minValue == CGFloat(minimumSectionLegThickness!) || minValue == CGFloat(minimumAreaOfSection!) {
            
            return "Min"
            
        } else {
            
            let minimumSliderLabelString: String? = slider.numberFormatter.string(from: minValue as NSNumber)
            
            return minimumSliderLabelString ?? ""
            
        }
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        
        if let extractedDepthOfSection = extractedDepthOfSection, let extractedWidthOfSection = extractedWidthOfSection, let extractedSectionLegLength = extractedSectionLegLength, let extractedSectionWebThickness = extractedSectionWebThickness, let extractedSectionFlangeThickness = extractedSectionFlangeThickness, let extractedSectionLegThickness = extractedSectionLegThickness , let extractedSectionArea = extractedSectionArea {
            
            maximumDepthOfSection = extractedDepthOfSection.max()
            
            maximumWidthOfSection = extractedWidthOfSection.max()
            
            maximumSectionLegLength = extractedSectionLegLength.max()
            
            maximumSectionWebThickness = extractedSectionWebThickness.max()
            
            maximumSectionFlangeThickness = extractedSectionFlangeThickness.max()
            
            maximumSectionLegThickness = extractedSectionLegThickness.max()
            
            maximumAreaOfSection = extractedSectionArea.max()
            
        }
        
        if maxValue == CGFloat(maximumDepthOfSection!) || maxValue == CGFloat(maximumWidthOfSection!) || maxValue == CGFloat(maximumSectionLegLength!) || maxValue == CGFloat(maximumSectionWebThickness!) || maxValue == CGFloat(maximumSectionFlangeThickness!) || maxValue == CGFloat(maximumSectionLegThickness!) || maxValue == CGFloat(maximumAreaOfSection!
            ) {
            
            return "Max"
            
        } else {
            
            let maximumSliderLabelString: String? = slider.numberFormatter.string(from: maxValue as NSNumber)
            
            return maximumSliderLabelString ?? ""
            
        }
        
    }
    
}
