//
//  BlueBookUniversalBeamDataSummaryVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SelectedSteelSectionSummaryPage: UIViewController {
        
    // MARK: - Assigning protocol delegate:
        
    // Here we are setting a delegate inside this View Controller in order to be able to access all the methods inside the Protocol. Notice that the delegate is defined as a "weak" one, as in most cases you do not want a child object maintaining a string reference to a parent object:
    
    weak var delegate: PassingDataBackwardsBetweenViewControllersProtocol?
    
    // The below property is defined in order to animate how this VC will go back to the previous VC once a rightSwipeGesture has been recognised or the user tapped on the back navigation bar button item located inside the navigation bar:
    
    let movingBackTransitionToPreviousVC = CATransition()
    
    // The below variables will get their values from the previous viewController (i.e. SteelSectionsTableViewController) once the user tapped on one of the disclosure icons next to the displayed table view rows:
    
    var sortBy: String = "None"

    var isSearching: Bool = false

    var filtersApplied: Bool = false
    
    // The below variable value will be passed from OpenRolledSteelSectionsCollectionVC which will be passed to SteelSectionsTableVC then passed onto this VC:
    
    var userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController: Int = 0
    
    // The below will be passed later on to the previous viewController later on using the Protocol in order to re-divert the user to the exact position inside the tableView he was on before getting diverted to this viewController:
    
    var receivedSelectedTableViewCellSectionNumberFromSteelSectionsTableViewController: Int = 0
    
    var receivedSelectedTableViewCellRowNumberFromSteelSectionsTableViewController: Int = 0
    
    // The below arrays and variables which gets passed from the previous viewController (i.e. SteelSectionsTableViewController) to this viewController contains all steel sections data used in the previois viewController to populate its tableView. These will be passed back to the previous viewController using the Protocol later on, in order to display the extact data the user was one as well as the exact location in terms of tableView Section and Row, before being diverted to this viewController:
    
    var receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData = [SteelSectionParameters]()
    
    // The below array contains data only related to the sections serial numbers, this will be passed later on using the protocol back to the previous viewController in order to decide how many sections the tableView needs to display:
    
    var receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsSerialNumbersOnly: [String] = []
    
    // Variables to be displayed for all steel sections, these will get their values later on inside this VC:
    
    var userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController: String = ""
    
    // Variables to be displayed for Open Rolled UB Steel Sections:
       
    var userSelectedSteelSectionMassPerMetreReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionDepthReceivedFromPreviousViewController: CGFloat = 0
    
    var userSelectedSteelSectionWidthReceivedFromPreviousViewController: CGFloat = 0

    var userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController: CGFloat = 0

    var userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController: CGFloat = 0

    var userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController: CGFloat = 0

    var userSelectedSteelSectionDepthBetweenFilletsReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionRatioForWebLocalBucklingReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionRatioForFlangeLocalBucklingReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionEndClearanceDetailingDimensionReceivedFromPreviousViewController: Int = 0

    var userSelectedSteelSectionNotchNdetailingDimensionReceivedFromPreviousViewController: Int = 0

    var userSelectedSteelSectionNotchnDetailingDimensionReceivedFromPreviousViewController: Int = 0

    var userSelectedSteelSectionSurfaceAreaPerMetreReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionSurfaceAreaPerTonneReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionSecondMomentOfAreaAboutMajorAxisReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionSecondMomentOfAreaAboutMinorAxisReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionRadiusOfGyrationAboutMajorAxisReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionRadiusOfGyrationAboutMinorAxisReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionElasticModulusAboutMajorAxisReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionElasticModulusAboutMinorAxisReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionPlasticModulusAboutMajorAxisReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionPlasticModulusAboutMinorAxisReceivedFromPreviousViewController: Double = 0
    
    var userSelectedSteelSectionBucklingParameterReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionTorsionalIndexReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionWarpingConstantReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionTorsionalConstantReceivedFromPreviousViewController: Double = 0

    var userSelectedSteelSectionAreaReceivedFromPreviousViewController: Double = 0

    // MARK: - navigationBar instance declaration:
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: self.userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController, navBarDelegate: self)
    
    // MARK: - Font colour, type, size and strings attributes used for labels inside the Section Profile Drawing Area:
    
    // The below are needed to define the attributes of the text to be used to represent the whole string:
    
    let steelSectionProfileDimensionAnnotationLabelsFontSizeAndTypeInsideTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-Light", size: 11.5)
    
    let steelSectionProfileDimensionAnnotationLabelsFontColourInsideTheProfileDrawingArea = UIColor(named: "SelectedSteelSectionSummaryPageVC - Scroll Area Sub Titles Labels Abbreviation Letters Text Font Colours")
    
    lazy var steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: steelSectionProfileDimensionAnnotationLabelsFontColourInsideTheProfileDrawingArea!,
        
        .font: steelSectionProfileDimensionAnnotationLabelsFontSizeAndTypeInsideTheProfileDrawingArea!,
        
    ]
    
    // The below are needed to define the attributes of the text to be used to represent the abbrivation letters (i.e. the letters that need to be in bold and of different colour):
    
    let steelSectionProfileDimensionLabelsAbbreviationLettersFontSizeAndTypeInsideTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12.5)
    
    let steelSectionProfileDimensionLabelsAbbreviationLettersFontColourInsideTheProfileDrawingArea = UIColor(named: "SelectedSteelSectionSummaryPageVC - Scroll Area Sub Titles Labels Abbreviation Letters Text Font Colours")
    
    lazy var steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: steelSectionProfileDimensionLabelsAbbreviationLettersFontColourInsideTheProfileDrawingArea!,
        
        .font: steelSectionProfileDimensionLabelsAbbreviationLettersFontSizeAndTypeInsideTheProfileDrawingArea!,
        
    ]
    
    // The below is needed to define the attributes of the text that needs to be represented as sub-character (i.e. lower centreline in comparison to the other letters):
    
    lazy var steelSectionProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: -6,
        
    ]
    
    // The below are needed to define the attributes of the text to be used to represent the abbreviation letters to be used for Major and Minor steel section axes:
    
    let steelSectionProfileMajorAndMinorAxisLabelFontSizeAndTypeInsideTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 16)
    
    let steelSectionProfileMajorAndMinorAxisLabelFontColourInsideTheProfileDrawingArea = UIColor(named: "Text Font Colour for Table Title and Table Columns Titles Inside the Section Dimensional & Structural Properties Scroll View")
    
    lazy var steelSectionProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: steelSectionProfileMajorAndMinorAxisLabelFontColourInsideTheProfileDrawingArea!,
        
        .font: steelSectionProfileMajorAndMinorAxisLabelFontSizeAndTypeInsideTheProfileDrawingArea!,
        
    ]
    
    // MARK: - Declaration of the selected steel section drawing area (this is where the steel section will ne drawn using CoreGraphics and CoreAnimation):
    
    lazy var steelSectionDrawingView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "SelectedSteelSectionSummaryPageVC - Background Colour for Section Profile Drawing Area")
                
        return view
        
    }()
    
    // MARK: - Declaration of UILabels to be displayed inside the steel section drawing area. These labels will be used to display information such as section's dimensions as well as major and minor axes labels):
    
    lazy var drawingAreaDepthOfSectionLabel = SelectedSteelSectionSummaryVCCustomUILabel(frame: CGRect(), numberOfLineToBeDisplayed: 0, horizontalAlignmentOfTextToBeDisplayed: .center, rotationAngleTransformation: -1 * (CGFloat.pi/2), textToBeDisplayed: "h = 500 mm", wholeTitleAttributesAssigned: true, attributesForTheWholeTitle: steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, startingLocationForWholeTitleAttributes: 0, abbreviationLettersAttributesAssigned: true, attributesForAbbreviationLetters: steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, startingLocationForAbbreviationLettersAttributes: 0, lengthOfAbbreviationLettersAttributes: 1, abbreviationSubscriptLettersFirstLocationAttributesAssigned: false, abbreviationSubscriptLettersFirstLocationAttributes: steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, startingLocationForAbbreviationSubscriptLettersFirstLocationAttributes: 0, lengthOfAbbreviationSubscriptLettersFirstLocationAttributes: 1, abbreviationSubscriptLettersSecondLocationAttributesAssigned: false, abbreviationSubscriptLettersSecondLocationAttributes: steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, startingLocationForAbbreviationSubscriptLettersSecondLocationAttributes: 0, lengthOfAbbreviationSubscriptLettersSecondLocationAttributes: 1, superscriptLettersAttributesAssigned: false, superscriptLettersAttributes: steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, startingLocationForSuperscriptLettersAttributes: 0, lengthOfSuperscriptLettersAttributes: 1)
    
//    lazy var selectedSectionDimensionDepthLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//
//        let labelString: String = "h = \(self.userSelectedSteelSectionDepthReceivedFromPreviousViewController) mm"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var selectedSectionDimensionWidthLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "b = \(self.userSelectedSteelSectionWidthReceivedFromPreviousViewController) mm"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var selectedSectionDimensionThicknessOfWebLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "tw = \(self.userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController) mm"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 2))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 1, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var selectedSectionDimensionThicknessOfFlangeLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "tf = \(self.userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController) mm"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 2))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 1, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var selectedSectionDimensionRootRadiusLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
//
//        let labelString: String = "r = \(self.userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController) mm"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(steelSectionProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var steelSectionMinorAxisBottomAnnotationLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "z"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//    labelAttributedString.addAttributes(steelSectionProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var steelSectionMinorAxisTopAnnotationLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "z"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var steelSectionMajorAxisLeftAnnotationLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "y"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
//
//    lazy var steelSectionMajorAxisRightAnnotationLabel: UILabel = {
//
//        var label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "y"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(steelSectionProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()

    // MARK: - CoreAnimation layers used to draw paths inside the Section Profile Drawing Area:
    
    let steelSectionShapeLayer = CAShapeLayer()
    
    let depthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let widthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let sectionWebThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionFlangeThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionRootRadiusAnnotationShapeLayer = CAShapeLayer()
    
    let dimensioningAnnotationDashedLinesShapeLayer = CAShapeLayer()
    
    let steelSectionMinorAndMajorAxisLinesShapeLayer = CAShapeLayer()
    
    let rootRadiusDimensioningAnnotationLineShapeLayer = CAShapeLayer()
        
    // MARK: - BezierPaths stroke colours and line widths inside the Section Profile Drawing Area:
    
    let steelSectionProfilePathStrokeColour: String = "SelectedSteelSectionSummaryPageVC - Drawing Area Section Profile Stroke Colour"
    
    let steelSectionShapeLayerPathLineWidth: CGFloat = 1.50
    
    let steelSectionProfileDimensionalAnnotationLinesPathsStrokeColour: String = "SelectedSteelSectionSummaryPageVC - Drawing Area Section Profile Dimensional Annotation Lines Paths Stroke Colour"
    
    let steelSectionProfileDimensionalAnnotationLinesPathsLineWidths: CGFloat = 1.0
    
    let steelSectionMinorAndMajorAxisLinesStrokePathColour: String = "SelectedSteelSectionSummaryPageVC - Drawing Area and Scroll Area Major And Minor Axes Colours"
    
    let steelSectionMinorAndMajorAxisLinesStrokePathLineWidth: CGFloat = 0.80
        
    // MARK: - depthOfSection Vertical Annotation Line X & Mid Y Coordinates, the below gets their values later on from the draw steel section profile function:
    
    var depthOfSectionDimensioningAnnotationLineXcoordinate: CGFloat = 0
    
    var depthOfSectionAnnotationLineMidYcoordinate: CGFloat = 0
    
    // MARK: - widthOfSection Horizontal Annotation Line Y & Mid X Coordinates Coordinate, the below gets their values later on from the draw steel section profile function:
    
    var widthOfSectionAnnotationLineMidXcoordinate: CGFloat = 0
    
    var widthOfSectionDimensioningAnnotationLineYcoordinate: CGFloat = 0
    
    // MARK: - sectionWebThickness Left hand side Horizontal Annotation Line starting X & Y coordinate Declaration, the below gets their values later on from the draw steel section profile function:
    
    var sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate: CGFloat = 0
    
    var sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate: CGFloat = 0
    
    // MARK: - sectionFlangeThickness Top Vertical Annotation Line Starting X & Y Coordinates Declaration, the below gets their values later on from the draw steel section profile function:
    
    var sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate: CGFloat = 0
    
    var sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate: CGFloat = 0
    
    // MARK: - sectionMinor Vertical Annotation Top and Bottom Y Coordinates Declaration, the below gets their values later on from the draw steel section profile function:
    
    var sectionMinorAnnotationVerticalLineTopYcoordinate: CGFloat = 0
    
    var sectionMinorAnnotationVerticalLineBottomYcoordinate: CGFloat = 0
    
    // MARK: - sectionMajor Horizontal Annotation Line Left and Right X Coordinates Declaration, the below gets their values later on from the draw steel section profile function:
    
    var sectionMajorAnnotationHorizontalLineLeftXcoordinate: CGFloat = 0
    
    var sectionMajorAnnotationHorizontalLineRightXcoordinate: CGFloat = 0
    
    // MARK: - section dimensions labels and annotations distances, the below gets their values later on from the draw steel section profile function:
    
    let distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    let distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    // MARK: - Section root radius inclined dimensioning annotation line starting point, the below gets their values later on from the draw steel section profile function:
    
    var steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate: CGFloat = 0
    
    var steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate: CGFloat = 0
    
    var halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds: CGFloat = 0
    
    var rootRadiusAnnotationLabelTopYcoordinate: CGFloat = 0
            
    // MARK: - Font colour, type, size and strings attributes used for labels inside the Section Dimensions and Structural Properties Scroll View:
    
    let mainTitlesTextFontColourInsideSectionDimensionalAndStructuralPropertiesScrollView = UIColor(named: "SelectedSteelSectionSummaryPageVC - Scroll Area Main Titles Labels Text Font Colours")
    
    let mainTitlesTextFontTypeAndSizeInsideSectionDimensionalAndStructuralPropertiesScrollView = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
    
    lazy var mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: mainTitlesTextFontTypeAndSizeInsideSectionDimensionalAndStructuralPropertiesScrollView!,
        
        .foregroundColor: mainTitlesTextFontColourInsideSectionDimensionalAndStructuralPropertiesScrollView!,
        
        .underlineStyle: NSUnderlineStyle.single.rawValue
        
    ]
    
    // The below are needed to define the whole general text attributes for the UILabels underneath the main title inside the UIScrollView:
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontColour = UIColor(named: "SelectedSteelSectionSummaryPageVC - Scroll Area Sub Titles Labels Text Font Colours")
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
    
    lazy var subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize!,
        
        .foregroundColor: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontColour!,
        
    ]
    
    // The below are needed to define the text attributes for the abbreviation letters (i.e. the ones in bold and of different colour) used inside of the sub-labels underneath the main title inside the UIScrollView:
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewAbbreviationLettersFontColour = UIColor(named: "SelectedSteelSectionSummaryPageVC - Scroll Area Sub Titles Labels Abbreviation Letters Text Font Colours")
    
    let subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
    
    lazy var subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewFontTypeAndSize!,
        
        .foregroundColor: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewAbbreviationLettersFontColour!,
        
    ]
    
    // The below is needed to define the text attributes for the sub-letters letters (i.e. the ones that needs to be offset downwards) used inside of the sub-labels underneath the main title inside the UIScrollView:
    
    lazy var subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: -7,
        
    ]
    
    // The below are needed to define the text attributes for the super-letters letters (i.e. the ones that needs to be offset upwards) used inside of the sub-labels underneath the main title inside the UIScrollView:
    
    let subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-Light", size: 11)
    
    lazy var subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: 7,
        
        .font: subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize!
        
    ]
    
    // The below are needed to define the text attributes for the table titles to be used to illustrate selected steel section major and minor values to be used inside the UIScrollView:
    
    let tableTitleAndTableColumnsTitlesFontColourUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView = UIColor(named: "SelectedSteelSectionSummaryPageVC - Drawing Area and Scroll Area Major And Minor Axes Colours")
    
    let tableTitleAndTableColumnsTitlesFontTypeAndSizeUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    
    lazy var tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView: [NSAttributedString.Key: Any] = [
        
        .font: tableTitleAndTableColumnsTitlesFontTypeAndSizeUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView!,
        
        .foregroundColor: tableTitleAndTableColumnsTitlesFontColourUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView!,
        
    ]
    
    let tableColumnsSubTitlesFontTypeAndSizeUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 16)
    
    lazy var tableColumnsSubTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView: [NSAttributedString.Key: Any] = [
        
        .font: tableColumnsSubTitlesFontTypeAndSizeUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView!,
        
        .foregroundColor: tableTitleAndTableColumnsTitlesFontColourUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView!,
        
    ]
    
    // MARK: - CoreAnimation layers used to draw paths inside the Section Dimensions and Structural Properties Scroll View:

    let verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer = CAShapeLayer()
    
    // MARK: - BezierPaths stroke colours and line widths inside the Section Dimensional & Structural Properties Scroll View:
       
       let verticalAndHorizontalSeparationLinesColourInsideSectionDimensionalAndPropertiesScrollView: String = "SelectedSteelSectionSummaryPageVC - Scroll Area Vertical and Horizontal Separation Lines For Major and Minor Axes Properties Table"
       
       let verticalAndHorizontalSeparationLinesWidthsInsideSectionDimensionalAndPropertiesScrollView: CGFloat = 1
        
    // MARK: - Declaring section dimensions and properties inside UIScrollView margins and spacings:
    
    // There are two main titles inside the scrollView, which are (1) Section Dimensional Properties (2) Section Structural Properties:
    
    let scrollViewMainTitleTopMargin: CGFloat = 15
    
    let scrollViewMainTitleRightMarginFromScreenEdge: CGFloat = 15
    
    let scrollViewMainTitleLeftMarginFromScreenEdge:CGFloat = 15
    
    //There are 8 labels that fall either exactly underneath a main title or above a main title. These are (1) Depth of Section (2) Width of Section (3) Ratio for Web Local Buckling (4) Ratio for Flange Local Buckling (5) Section Detailing Dimensions Image (6) Notch n (7) Axis (8) Torsional Constant:
    
    let scrollViewVerticalSpacingForLabelUnderneathMainTitles: CGFloat = 20
    
    // Vertical spacing between labels underneath main title:
    
    let scrollViewSubLabelsVerticalSpacings: CGFloat = 10
    
    // These are the left/right margins for labels underneath main titles either from the edge of the screen or scroll view separation lines:
    
    let scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView: CGFloat = 25
    
    let scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView: CGFloat = 25
    
    let scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin: CGFloat = 5
    
    let scrollViewSectionStructuralPropertiesLabelContainingValuesRightMargin: CGFloat = 5
    
    lazy var  scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX: CGFloat = ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4) - scrollViewSectionStructuralPropertiesLabelContainingValuesRightMargin
    
    lazy var scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor: CGFloat = -1 * (scrollViewSectionStructuralPropertiesLabelContainingValuesRightMargin + scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)
    
    lazy var scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX: CGFloat = ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4) + scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin
    
    // MARK: - Declaring section dimensions and properties UIScrollView:
    
    lazy var sectionDimensionsAndPropertiesScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = UIColor(named: "SelectedSteelSectionSummaryPageVC - Drawing and Scroll Area Background Colour")
        
        return scrollView
        
    }()
    
    // MARK: - ScrollView section dimensions and geometric properties labels:
    
//    lazy var scrollViewSectionDimensionalPropertiesTitleLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Dimensional Properties:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
//
//        label.attributedText = attributedStringInsideUILabel
//
//        return label
//
//    }()
    
//    lazy var scrollViewDepthOfSectionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "Depth, h [mm] = \(self.userSelectedSteelSectionDepthReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewWidthOfSectionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString: String = "Width, b [mm] = \(self.userSelectedSteelSectionWidthReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewFlangeThicknessLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Flange thickness, tf [mm] = \(self.userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 19, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewWebThicknessLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Web thickness, tw [mm] = \(self.userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 15, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 16, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSectionRootRadiusLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Root radius, r [mm] = \(self.userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 13, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewDepthOfSectionBetweenFilletsLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Depth between fillets, d [mm] = \(self.userSelectedSteelSectionDepthBetweenFilletsReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 23, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewAreaOfSectionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Area of section, A [cm2] = \(self.userSelectedSteelSectionAreaReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 22, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSurfaceAreaPerMetre: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Surface area per metre [m2] = \(self.userSelectedSteelSectionSurfaceAreaPerMetreReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 25, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSurfaceAreaPerTonne: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Surface area per tonne [m2] = \(self.userSelectedSteelSectionSurfaceAreaPerTonneReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 25, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSectionMassPerMetreLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Mass per metre [kg/m] = \(self.userSelectedSteelSectionMassPerMetreReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewRatioForWebLocalBuckling: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Ratio for web local buckling, cw/tw = \(self.userSelectedSteelSectionRatioForWebLocalBucklingReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 30, length: 5))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 31, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 34, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewRatioForFlangeLocalBuckling: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Ratio for flange local buckling, cf/tf = \(self.userSelectedSteelSectionRatioForFlangeLocalBucklingReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 33, length: 5))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 34, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 37, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSectionDetailingDimensionsTitle: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Detailing Dimensions:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
//
//        label.attributedText = attributedStringInsideUILabel
//
//        return label
//
//    }()
    
//    lazy var scrollViewUniversalBeamDetailingDimensionsImage: UIImageView = {
//
//        let image = UIImageView()
//
//        image.translatesAutoresizingMaskIntoConstraints = false
//
//        image.image = UIImage(named: "UniversalBeamDetailingDimensionsImage")
//
//        image.contentMode = .scaleAspectFit
//
//        image.clipsToBounds = true
//
//        image.layer.borderColor = UIColor.blue.cgColor
//
//        return image
//
//    }()
    
//    lazy var scrollViewEndClearanceDetailingDimensionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "End clearance, C [mm] = \(self.userSelectedSteelSectionEndClearanceDetailingDimensionReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 15, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewNotchNdetailingDimensionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Notch, N [mm] = \(self.userSelectedSteelSectionNotchNdetailingDimensionReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewNotchnDetailingDimensionLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Notch, n [mm] = \(self.userSelectedSteelSectionNotchnDetailingDimensionReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewSectionStructuralPropertiesTitle: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Structural Properties:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
//
//        label.attributedText = attributedStringInsideUILabel
//
//        return label
//
//    }()
    
//    lazy var scrollViewAxisLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Axis"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMajorAxisLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = "Major \n(y-y)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(tableColumnsSubTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 7, length: 5))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    

    
//    lazy var scrollViewSecondMomentOfAreaLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Second moment of area, I [cm4]:"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 23, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 28, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMajorSecondMomentOfAreaValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionSecondMomentOfAreaAboutMajorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMinorSecondMomentOfAreaValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionSecondMomentOfAreaAboutMinorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewRadiusOfGyrationLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Radius of gyration, i [cm]:"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMajorRadiusOfGyrationValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionRadiusOfGyrationAboutMajorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMinorRadiusOfGyrationValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionRadiusOfGyrationAboutMinorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewElasticModulusLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Elastic modulus, Wel [cm3]:"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 3))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMajorElasticModulusValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionElasticModulusAboutMajorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMinorElasticModulusValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionElasticModulusAboutMinorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewPlasticModulusLabel: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Plastic modulus, Wpl [cm3]:"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 3))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMajorPlasticModulusValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionPlasticModulusAboutMajorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewMinorPlasticModulusValue: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        label.textAlignment = NSTextAlignment.center
//
//        let labelString = String(self.userSelectedSteelSectionPlasticModulusAboutMinorAxisReceivedFromPreviousViewController)
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewBucklingParameter: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Buckling parameter, U = \(self.userSelectedSteelSectionBucklingParameterReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewTorsionalIndex: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Torsional index, X = \(self.userSelectedSteelSectionTorsionalIndexReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewWarpingConstant: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Warping constant, Iw [dm6] = \(self.userSelectedSteelSectionWarpingConstantReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 19, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
//    lazy var scrollViewTorsionalConstant: UILabel = {
//
//        let label = UILabel()
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 0
//
//        let labelString = "Torsional constant, IT [cm4] = \(self.userSelectedSteelSectionTorsionalConstantReceivedFromPreviousViewController)"
//
//        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
//
//        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
//
//        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 2))
//
//        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 21, length: 1))
//
//        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 26, length: 1))
//
//        label.attributedText = labelAttributedString
//
//        return label
//
//    }()
    
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupMoveBackTransitionToPreviousVC()
        
        // The below gesture is needed in order to enable the user to navigate to the previous viewController once a right swipe gesture gets detected:
                
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(navigationBarLeftButtonPressed(sender:)))

        rightGestureRecognizer.direction = .right

        view.addGestureRecognizer(rightGestureRecognizer)

        // MARK: - Adding SubViews to the main View Controller:

        view.addSubview(navigationBar)

        view.addSubview(steelSectionDrawingView)

        view.addSubview(sectionDimensionsAndPropertiesScrollView)

        // MARK: - Adding SubViews to universalBeamDrawingView:

        steelSectionDrawingView.layer.addSublayer(steelSectionShapeLayer)

        steelSectionDrawingView.layer.addSublayer(depthOfSectionAnnotationShapeLayer)

        steelSectionDrawingView.layer.addSublayer(widthOfSectionAnnotationShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(dimensioningAnnotationDashedLinesShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(sectionWebThicknessAnnotationShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(sectionFlangeThicknessAnnotationShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(sectionRootRadiusAnnotationShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(steelSectionMinorAndMajorAxisLinesShapeLayer)
        
        steelSectionDrawingView.layer.addSublayer(rootRadiusDimensioningAnnotationLineShapeLayer)
        
        steelSectionDrawingView.addSubview(drawingAreaDepthOfSectionLabel)
//
//        steelSectionDrawingView.addSubview(selectedSectionDimensionWidthLabel)
//
//        steelSectionDrawingView.addSubview(selectedSectionDimensionThicknessOfWebLabel)
//
//        steelSectionDrawingView.addSubview(selectedSectionDimensionThicknessOfFlangeLabel)
//
//        steelSectionDrawingView.addSubview(selectedSectionDimensionRootRadiusLabel)
//
//        steelSectionDrawingView.addSubview(steelSectionMinorAxisBottomAnnotationLabel)
//
//        steelSectionDrawingView.addSubview(steelSectionMinorAxisTopAnnotationLabel)
//
//        steelSectionDrawingView.addSubview(steelSectionMajorAxisLeftAnnotationLabel)
//
//        steelSectionDrawingView.addSubview(steelSectionMajorAxisRightAnnotationLabel)

        // MARK: - Adding scrollView subViews:
        
        sectionDimensionsAndPropertiesScrollView.layer.addSublayer(verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer)

//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDimensionalPropertiesTitleLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWidthOfSectionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewFlangeThicknessLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWebThicknessLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionRootRadiusLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionBetweenFilletsLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewAreaOfSectionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSurfaceAreaPerMetre)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSurfaceAreaPerTonne)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionMassPerMetreLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRatioForWebLocalBuckling)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRatioForFlangeLocalBuckling)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDetailingDimensionsTitle)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewEndClearanceDetailingDimensionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchNdetailingDimensionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchnDetailingDimensionLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewUniversalBeamDetailingDimensionsImage)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionStructuralPropertiesTitle)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSecondMomentOfAreaLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewAxisLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorAxisLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorAxisLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorSecondMomentOfAreaValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorSecondMomentOfAreaValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRadiusOfGyrationLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorRadiusOfGyrationValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorRadiusOfGyrationValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewElasticModulusLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorElasticModulusValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorElasticModulusValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewPlasticModulusLabel)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorPlasticModulusValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorPlasticModulusValue)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewBucklingParameter)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewTorsionalIndex)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWarpingConstant)
//
//        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewTorsionalConstant)
        
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
        
        // In order for the selected steel section profile as well as its annotation to re-draw themselves when the system theme changes from light to dark or visa versa, we need to place the draw function inside viewWillLayoutSubviews:
        
//        switch userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController {
//
//        // The user has selected Universal Beams:
//
//        case 0:
//
////            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Universal Columns:
//
//        case 1:
//
////            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Universal Bearing Piles:
//
//        case 2:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Parallel Flange Channels:
//
//        case 3:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Equal Leg Angles:
//
//        case 4:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Unequal Leg Angles:
//
//        case 5:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Tees (T) split from UB:
//
//        case 6:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        // The user has selected Tees (T) split from UC:
//
//        case 7:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        default:
//
//            drawSelectedIsteelSectionProfilePathAndItsAnnotations()
//
//        }
        
        
        // MARK: - Assigning needed constraints:
        
        setupConstraints()

//        setupSubViewsConstraints()

//        drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel()

//        let scrollViewTorsionalConstantLabelCoordinatesOriginInRelationToItsScrollView = scrollViewTorsionalConstant.convert(scrollViewTorsionalConstant.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)

        // MARK: - Defining sectionDimensionsAndPropertiesScrollView contentSize:

//        sectionDimensionsAndPropertiesScrollView.contentSize = CGSize(width: view.frame.size.width, height: scrollViewTorsionalConstantLabelCoordinatesOriginInRelationToItsScrollView.y + scrollViewMainTitleTopMargin + scrollViewTorsionalConstant.intrinsicContentSize.height)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        super.viewDidAppear(animated)
//
//        self.sectionDimensionsAndPropertiesScrollView.flashScrollIndicators()
        
    }
    
    //
    
    func setupMoveBackTransitionToPreviousVC() {
        
        movingBackTransitionToPreviousVC.duration = 0.55
        
        movingBackTransitionToPreviousVC.type = CATransitionType.reveal
        
        movingBackTransitionToPreviousVC.subtype = CATransitionSubtype.fromLeft
        
        movingBackTransitionToPreviousVC.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
    }
    
    func drawAnIorTSectionSteelProfile(drawingAreaMargins: CGFloat, widthOfSteelSection: Double, totalHeightOfSteelSection: Double, centreOfGravityInYDirectionFromTopOfSectionForTProfiles: Double, flangeThicknessOfSteelSection: Double, webThicknessOfSteelSection: Double, rootRadiusOfSteelSection: Double, drawingAreaUIView: UIView) {
        
    // Declaring drawing margins:
        
        let allDrawingMargins: CGFloat = drawingAreaMargins
        
    // Defining drawing scale:
        
        let drawingScale = min((drawingAreaUIView.layer.frame.width - (2 * drawingAreaMargins)) / CGFloat(widthOfSteelSection), (drawingAreaUIView.layer.frame.height - (2 * drawingAreaMargins)) / CGFloat(totalHeightOfSteelSection))
                
    // Drawing area centre point coordinates:
        
        let drawingAreaCentrePointCoordinates: (x: CGFloat, y: CGFloat) = (x: (drawingAreaUIView.layer.frame.width)/2, y: (drawingAreaUIView.layer.frame.height)/2)
        
    // Step-01 Draw the right top quarter of the steel profile:
        
        // Point-01 coordinates, which is located at the mid length of the top horziontal line:
        
        var pointOneCoordinates: (x: CGFloat, y: CGFloat) = (0, 0)
        
            // The below IF STATEMENT will be executed for Open Rolled UB, UC and UBP steel sections:
        
        if userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 0 || userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 1 || userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 2 {
            
            pointOneCoordinates = (x: drawingAreaCentrePointCoordinates.x, y: drawingAreaCentrePointCoordinates.y - ((CGFloat(totalHeightOfSteelSection) / 2) * drawingScale))
            
        }
            
            // The below IF STATEMENT will be executed for Open Rolled T-sections split from UB or UC profiles:
        
        else if userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 6 || userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 7 {
            
            pointOneCoordinates = (x: drawingAreaCentrePointCoordinates.x, y: drawingAreaCentrePointCoordinates.y - (CGFloat(centreOfGravityInYDirectionFromTopOfSectionForTProfiles) * drawingScale))
            
        }
        
        // Point-02 coordinates, which is located at the far right top corner of the section:
        
        let pointTwoCoordinates: (x: CGFloat, y: CGFloat) = (x: drawingAreaCentrePointCoordinates.x + ((CGFloat(widthOfSteelSection) / 2) * drawingScale), y: pointOneCoordinates.y)
        
        // Point-03 coordinates, which is located at the far right bottom corner of the section:
        
        let pointThreeCoordinates: (x: CGFloat, y: CGFloat) = (x: pointTwoCoordinates.x, y: pointTwoCoordinates.y + (CGFloat(flangeThicknessOfSteelSection) * drawingScale))
        
        // Point-04 coordinates, which is located at the right inner-side corner of the section at the start of the root radius curve:
        
        let pointFourCoordinates: (x: CGFloat, y: CGFloat) = (x: pointThreeCoordinates.x - (CGFloat(((widthOfSteelSection / 2) - (webThicknessOfSteelSection / 2) - rootRadiusOfSteelSection)) * drawingScale), y: pointThreeCoordinates.y)
        
        // Point-05 coordinates, which is located at the right inner-side corner of the section at the end of the root radius curve:
        
        let pointFiveCoordinates: (x: CGFloat, y: CGFloat) = (x: pointFourCoordinates.x - (CGFloat(rootRadiusOfSteelSection) * drawingScale), y: pointFourCoordinates.y + (CGFloat(rootRadiusOfSteelSection) * drawingScale))
        
        // Point-06 coordinates, which is located at the right side centre of gravity of the section in the Y-direction:
        
        
        
    // Step-02 Mirror the drawn top right quarter in Step-01 above along the Y-axis to obtain a T-Section:
        
    // Step-03 If we are drawing an I Section then the next step is to mirror what have been drawn in Step-02 along the X-axis in order to obtain an I-Section:
        
        
    }
    
//    func drawSelectedIsteelSectionProfilePathAndItsAnnotations() {
//
//        // MARK: - Set of common distances:
//
//        let minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges: CGFloat = 10
//
//        let sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength: CGFloat = 20
//
//        let distanceFromMajorOrMinorSteelSectionAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine: CGFloat = 5
//
//        let distanceBetweenEndOfWidthOfSectionVerticalDashedDimensioningAnnotationLineAndDrawingViewTopOrBottomBorder: CGFloat = 5
//
//        let distanceBetweenEndOfDepthOfSectionHorizontalDashedDimensioningAnnotationLinesndDrawingViewLeftOrRightBorder: CGFloat = 5
//
//        let widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths: CGFloat = (minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges + steelSectionMinorAxisTopAnnotationLabel.intrinsicContentSize.height + distanceFromMajorOrMinorSteelSectionAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine) * 2
//
//        let depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths: CGFloat = (minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges + steelSectionMajorAxisRightAnnotationLabel.intrinsicContentSize.width + distanceFromMajorOrMinorSteelSectionAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine) * 2
//
//        let drawingViewTopAndBottomMargin: CGFloat = widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths + distanceBetweenEndOfWidthOfSectionVerticalDashedDimensioningAnnotationLineAndDrawingViewTopOrBottomBorder
//
//        let drawingViewLeftAndRightMargin: CGFloat = depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths + distanceBetweenEndOfDepthOfSectionHorizontalDashedDimensioningAnnotationLinesndDrawingViewLeftOrRightBorder
//
//        // MARK: - Calculating I-section drawing scale and setting triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol:
//
//        let widthScale: CGFloat = (self.view.frame.size.width - (drawingViewLeftAndRightMargin * 2)) / userSelectedSteelSectionWidthReceivedFromPreviousViewController
//
//        let depthScale: CGFloat = (self.view.frame.size.width - (drawingViewTopAndBottomMargin * 2)) / userSelectedSteelSectionDepthReceivedFromPreviousViewController
//
//        let scaleToBeApplied = min(widthScale, depthScale)
//
//         let distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines: CGFloat = ((userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController/2) + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController*2)) * scaleToBeApplied
//
//        let distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines: CGFloat = -1 * (steelSectionMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2 + 2 * (userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied))
//
//        let triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol: CGFloat = (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied)/2
//
//        halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds = triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol * sin(CGFloat.pi/4)
//
//        // MARK: - Set of points that define the quarter of the I-section profile contained in the +ve x and +ve y quadrant:
//
//        let steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: self.view.frame.width/2 , y: drawingViewTopAndBottomMargin)
//
//        let steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((userSelectedSteelSectionWidthReceivedFromPreviousViewController/2) * scaleToBeApplied), y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
//
//        let steelIsectionSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: (steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied))
//
//        rootRadiusAnnotationLabelTopYcoordinate = steelIsectionSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y
//
//        let steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied)/2) + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied), y: (steelIsectionSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied))
//
//        let steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) - (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied), y: (steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + ((userSelectedSteelSectionDepthReceivedFromPreviousViewController/2) * scaleToBeApplied))
//
//        let topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates: (x: CGFloat, y: CGFloat) = (x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (steelSectionShapeLayerPathLineWidth/2) + (depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths/2),y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
//
//        let leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes: (x: CGFloat, y: CGFloat) = (x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - ((userSelectedSteelSectionWidthReceivedFromPreviousViewController/2) * scaleToBeApplied),y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - steelSectionShapeLayerPathLineWidth/2 - (widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/2))
//
//        // Below are the points coordinates definitions used to draw the bottom half of the selected parallel flange channel by the user. Which will then be reflected to create the profile of the full section:
//
//            let channelStartingDrawingPointCoordinates: (x: CGFloat, y: CGFloat) = (x: self.view.frame.width/2 - (userSelectedSteelSectionWidthReceivedFromPreviousViewController * scaleToBeApplied)/2, y: steelSectionDrawingView.frame.height/2)
//
//            let channelBottomLeftCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelStartingDrawingPointCoordinates.x, y: channelStartingDrawingPointCoordinates.y + ((userSelectedSteelSectionDepthReceivedFromPreviousViewController/2) * scaleToBeApplied))
//
//            let channelBottomRightCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelBottomLeftCornerPointCoordinates.x + (userSelectedSteelSectionWidthReceivedFromPreviousViewController * scaleToBeApplied), y: channelBottomLeftCornerPointCoordinates.y)
//
//            let channelTopBottomRightCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelBottomRightCornerPointCoordinates.x, y: channelBottomRightCornerPointCoordinates.y - (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied))
//
//            let channelCornerPointCoordinatesJustBeforeBeginningOfRootRadius: (x: CGFloat, y: CGFloat) = (x: channelBottomLeftCornerPointCoordinates.x + ((userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied) + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)), y: channelTopBottomRightCornerPointCoordinates.y)
//
//            let channelBottomInnerCornerRootRadiusCentrePointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelCornerPointCoordinatesJustBeforeBeginningOfRootRadius.x, y: channelTopBottomRightCornerPointCoordinates.y - (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied))
//
//            let channelBottomHalfEndPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelStartingDrawingPointCoordinates.x + (userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied), y: channelStartingDrawingPointCoordinates.y)
//
//        // MARK: - Declaring the various paths stroke colours:
//
//        let sectionProfilePathStrokeColour = UIColor(named: steelSectionProfilePathStrokeColour)!.cgColor
//
//        let sectionProfileDimensionalAnnotationLinesPathsStrokeColour = UIColor(named: steelSectionProfileDimensionalAnnotationLinesPathsStrokeColour)!.cgColor
//
//        let sectionProfileMajorAndMinorAnnotationAxisPathStrokeColour = UIColor(named: steelSectionMinorAndMajorAxisLinesStrokePathColour)!.cgColor
//
//        // MARK: - Defining selected steel section profile Outline UIBezierPath:
//
//        let iSectionFirstQuarterBezierPath = UIBezierPath()
//
//        let iSectionReflectedSecondQuarterBezierPath = UIBezierPath()
//
//        let halfOfIsectionBezierPath = UIBezierPath()
//
//        let iSectionReflectedSecondHalfBezierPath = UIBezierPath()
//
//        let iSectionFullPathBezierPath = UIBezierPath()
//
//        // The below will draw the UIBezierPath first quarter of the overall required I-Section profile:
//
//        if userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 0 || userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 1 || userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 2 {
//
//            iSectionFirstQuarterBezierPath.move(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//            iSectionFirstQuarterBezierPath.addLine(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//            iSectionFirstQuarterBezierPath.addLine(to: CGPoint(x: steelIsectionSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.x , y: steelIsectionSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//            iSectionFirstQuarterBezierPath.addLine(to: CGPoint(x: steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: (steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)))
//
//            iSectionFirstQuarterBezierPath.addArc(withCenter: CGPoint(x: steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y), radius: -1 * (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied), startAngle: (CGFloat.pi)/2, endAngle: 0, clockwise: false)
//
//            iSectionFirstQuarterBezierPath.addLine(to: CGPoint(x: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//            // Here we are carrying out the first reflection and translation process about the X-Axis in order to obtain half of the final path:
//
//            let reflectionLineAboutXaxis = CGAffineTransform(scaleX: 1, y: -1)
//
//            let translationInYaxisAfterReflectionIsDone = CGAffineTransform(translationX: 0, y: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) * 2)
//
//            let requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess = reflectionLineAboutXaxis.concatenating(translationInYaxisAfterReflectionIsDone)
//
//            halfOfIsectionBezierPath.append(iSectionFirstQuarterBezierPath)
//
//            halfOfIsectionBezierPath.apply(requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess)
//
//            halfOfIsectionBezierPath.append(iSectionFirstQuarterBezierPath)
//
//            halfOfIsectionBezierPath.append(halfOfIsectionBezierPath)
//
//            // Here we are carrying out the second reflection and translation process about the Y-Axis in order to obtain the full section path:
//
//            let reflectionLineAboutYaxis = CGAffineTransform(scaleX: -1, y: 1)
//
//            let translationInXaxisAfterReflectionIsDone = CGAffineTransform(translationX: (steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) * 2, y: 0)
//
//            let requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess = reflectionLineAboutYaxis.concatenating(translationInXaxisAfterReflectionIsDone)
//
//            iSectionReflectedSecondHalfBezierPath.append(halfOfIsectionBezierPath)
//
//            iSectionReflectedSecondHalfBezierPath.apply(requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess)
//
//            iSectionFullPathBezierPath.append(halfOfIsectionBezierPath)
//
//            iSectionFullPathBezierPath.append(iSectionReflectedSecondHalfBezierPath)
//
//            // MARK: - Assigning selected steel section profile UIBezierPath Properties:
//
//            steelSectionShapeLayer.path = iSectionFullPathBezierPath.cgPath
//
//            steelSectionShapeLayer.fillColor = UIColor.clear.cgColor
//
//            steelSectionShapeLayer.strokeColor = sectionProfilePathStrokeColour
//
//            steelSectionShapeLayer.lineWidth = steelSectionShapeLayerPathLineWidth
//
//            // The below will draw the bottom half UIBezierPath of the selected parallel flange channel section:
//
//        } else if userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController == 3 {
//
////            selectedSteelSectionBezierPath.move(to: CGPoint(x: channelStartingDrawingPointCoordinates.x, y: channelStartingDrawingPointCoordinates.y))
////
////            selectedSteelSectionBezierPath.addLine(to: CGPoint(x: channelBottomLeftCornerPointCoordinates.x, y: channelBottomLeftCornerPointCoordinates.y))
////
////            selectedSteelSectionBezierPath.addLine(to: CGPoint(x: channelBottomRightCornerPointCoordinates.x, y: channelBottomRightCornerPointCoordinates.y))
////
////            selectedSteelSectionBezierPath.addLine(to: CGPoint(x: channelTopBottomRightCornerPointCoordinates.x, y: channelTopBottomRightCornerPointCoordinates.y))
////
////            selectedSteelSectionBezierPath.addLine(to: CGPoint(x: channelCornerPointCoordinatesJustBeforeBeginningOfRootRadius.x, y: channelCornerPointCoordinatesJustBeforeBeginningOfRootRadius.y))
////
////            selectedSteelSectionBezierPath.addArc(withCenter: CGPoint(x: channelBottomInnerCornerRootRadiusCentrePointCoordinates.x, y: channelBottomInnerCornerRootRadiusCentrePointCoordinates.y), radius: userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied, startAngle: (CGFloat.pi)/2, endAngle: (CGFloat.pi), clockwise: true)
////
////            selectedSteelSectionBezierPath.addLine(to: CGPoint(x: channelBottomHalfEndPointCoordinates.x, y: channelBottomHalfEndPointCoordinates.y))
////
////            steelSectionShapeLayer.path = selectedSteelSectionBezierPath.cgPath
////
////            steelSectionShapeLayer.fillColor = UIColor.clear.cgColor
////
////            steelSectionShapeLayer.strokeColor = sectionProfilePathStrokeColour
////
////            steelSectionShapeLayer.lineWidth = steelSectionShapeLayerPathLineWidth
//
//        }
//
//        // MARK: - Defining selected steel section profile Dimensioning Annotation UIBezierPath:
//
//        let widthOfSectionHalfOfTheLeftSideArrowHeadPath = UIBezierPath()
//
//        let widthOfSectionReflectedLeftArrowHeadHalfPath = UIBezierPath()
//
//        let widthOfSectionHalfOfHorizontalLinePath = UIBezierPath()
//
//        let widthOfSectionLeftSideDashedLinePath = UIBezierPath()
//
//        let widthOfSectionRightSideDashedLinePath = UIBezierPath()
//
//        let widthOfSectionFullLeftSideHalfPath = UIBezierPath()
//
//        let widthOfSectionReflectedFullLeftSideHalfPath = UIBezierPath()
//
//        let widthOfSectionFullPath = UIBezierPath()
//
//        let dashedAnnotationLines = UIBezierPath()
//
//        widthOfSectionAnnotationLineMidXcoordinate = steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x
//
//        widthOfSectionDimensioningAnnotationLineYcoordinate = leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y
//
//        widthOfSectionHalfOfTheLeftSideArrowHeadPath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
//
//        widthOfSectionHalfOfTheLeftSideArrowHeadPath.addLine(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
//
//        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
//
//        // Below code lines are needed to reflect the left hand side half of the arrow head about the horizontal x-axis:
//
//        let widthOfSectionLeftHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
//
//        let widthOfSectionReflectedLeftHandArrowHeadTranslation = CGAffineTransform(translationX: 0, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y * 2)
//
//        let widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation = widthOfSectionLeftHandSideArrowHeadReflectionAxis.concatenating(widthOfSectionReflectedLeftHandArrowHeadTranslation)
//
//        widthOfSectionReflectedLeftArrowHeadHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
//
//        widthOfSectionReflectedLeftArrowHeadHalfPath.apply(widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation)
//
//        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionReflectedLeftArrowHeadHalfPath)
//
//        // Below lines of codes are needed to draw the left hand side horizontal line half needed for the width of section annotation:
//
//        widthOfSectionHalfOfHorizontalLinePath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
//
//        widthOfSectionHalfOfHorizontalLinePath.addLine(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
//        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfHorizontalLinePath)
//
//        // Below code lines are needed in order to reflect the left hand side half of the Width Of Section Annotation elements about the vertical y-axis:
//
//        let widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath = CGAffineTransform(scaleX: -1, y: 1)
//
//        let widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath = CGAffineTransform(translationX: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x * 2, y: 0)
//
//        let requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath = widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath.concatenating(widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath)
//
//        widthOfSectionReflectedFullLeftSideHalfPath.append(widthOfSectionFullLeftSideHalfPath)
//
//        widthOfSectionReflectedFullLeftSideHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath)
//
//        widthOfSectionFullPath.append(widthOfSectionFullLeftSideHalfPath)
//
//        widthOfSectionFullPath.append(widthOfSectionReflectedFullLeftSideHalfPath)
//
//        // MARK: - Defining Steel Section Width Dashed Dimensioning Annotation UIBezierPath:
//
//        widthOfSectionLeftSideDashedLinePath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (steelSectionShapeLayerPathLineWidth/2)))
//
//        widthOfSectionLeftSideDashedLinePath.addLine(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (steelSectionShapeLayerPathLineWidth/2) - widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths))
//
//        widthOfSectionRightSideDashedLinePath.move(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (steelSectionShapeLayerPathLineWidth/2)))
//
//        widthOfSectionRightSideDashedLinePath.addLine(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (steelSectionShapeLayerPathLineWidth/2) - widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths))
//
//        dashedAnnotationLines.append(widthOfSectionLeftSideDashedLinePath)
//
//        dashedAnnotationLines.append(widthOfSectionRightSideDashedLinePath)
//
//        // MARK: - Assigning selected steel section width UIBezierPath Properties:
//
//        widthOfSectionAnnotationShapeLayer.path = widthOfSectionFullPath.cgPath
//
//        widthOfSectionAnnotationShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        widthOfSectionAnnotationShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//        // MARK: - Defining selected steel section Major & Minor Axis Annotation UIBezierPath:
//
//        let selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath = UIBezierPath()
//
//        sectionMinorAnnotationVerticalLineTopYcoordinate = steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
//
//        sectionMinorAnnotationVerticalLineBottomYcoordinate = steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
//
//        sectionMajorAnnotationHorizontalLineLeftXcoordinate = leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
//
//        sectionMajorAnnotationHorizontalLineRightXcoordinate = steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
//
//        selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//        selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath.addLine(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//        selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath.move(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
//
//        selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath.addLine(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + minorAndMajorSteelSectionProfileDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
//
//        // MARK: - Assigning Selected Steel Section Major & Minor Axis Annotation UIBezierPath Properties:
//
//        steelSectionMinorAndMajorAxisLinesShapeLayer.path = selectedSteelSectionMinorAndMajorAxisAnnotationLinesBezierPath.cgPath
//
//        steelSectionMinorAndMajorAxisLinesShapeLayer.lineWidth = steelSectionMinorAndMajorAxisLinesStrokePathLineWidth
//
//        steelSectionMinorAndMajorAxisLinesShapeLayer.strokeColor = sectionProfileMajorAndMinorAnnotationAxisPathStrokeColour
//
//        steelSectionMinorAndMajorAxisLinesShapeLayer.lineDashPattern = [10, 2]
//
//        // MARK: - Defining Selected Steel Depth of Section Dimensioning Annotation UIBezierPath:
//
//        let depthOfSectionHalfOfBottomArrowHeadPath = UIBezierPath()
//
//        let depthOfSectionReflectedBottomArrowHeadHalfPath = UIBezierPath()
//
//        let depthOfSectionHalfOfVerticalLinePath = UIBezierPath()
//
//        let depthOfSectionBottomDashedLinePath = UIBezierPath()
//
//        let depthOfSectionTopDashedLinePath = UIBezierPath()
//
//        let depthOfSectionFullBottomHalfPath = UIBezierPath()
//
//        let depthOfSectionReflectedFullBottomHalfPath = UIBezierPath()
//
//        let depthOfSectionFullPath = UIBezierPath()
//
//        depthOfSectionDimensioningAnnotationLineXcoordinate = topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x
//
//        depthOfSectionAnnotationLineMidYcoordinate = steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y
//
//        depthOfSectionHalfOfBottomArrowHeadPath.move(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y))
//
//        depthOfSectionHalfOfBottomArrowHeadPath.addLine(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x - triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
//
//        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
//
//        // Below code lines are needed to reflect the bottom half of the arrow head about the vertical y-axis:
//
//        let depthOfSectionBottomArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
//
//        let depthOfSectionReflectedBottomArrowHeadTranslation = CGAffineTransform(translationX: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x * 2, y: 0)
//
//        let depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation = depthOfSectionBottomArrowHeadReflectionAxis.concatenating(depthOfSectionReflectedBottomArrowHeadTranslation)
//
//        depthOfSectionReflectedBottomArrowHeadHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
//
//        depthOfSectionReflectedBottomArrowHeadHalfPath.apply(depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation)
//
//        depthOfSectionFullBottomHalfPath.append(depthOfSectionReflectedBottomArrowHeadHalfPath)
//
//        // Below lines of codes are needed to draw the bottom vertical line half needed for the depth of section annotation:
//
//        depthOfSectionHalfOfVerticalLinePath.move(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y))
//
//        depthOfSectionHalfOfVerticalLinePath.addLine(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfVerticalLinePath)
//
//        // Below code lines are needed in order to reflect the bottom half of the Depth Of Section Annotation elements about the horziontal x-axis:
//
//        let depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath = CGAffineTransform(scaleX: 1, y: -1)
//
//        let depthOfSectionTranslationForTheReflectedFullBottomHalfPath = CGAffineTransform(translationX: 0, y: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y * 2)
//
//        let requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath = depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath.concatenating(depthOfSectionTranslationForTheReflectedFullBottomHalfPath)
//
//        depthOfSectionReflectedFullBottomHalfPath.append(depthOfSectionFullBottomHalfPath)
//
//        depthOfSectionReflectedFullBottomHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath)
//
//        depthOfSectionFullPath.append(depthOfSectionReflectedFullBottomHalfPath)
//
//        depthOfSectionFullPath.append(depthOfSectionFullBottomHalfPath)
//
//        // MARK: - Defining Selected Steel Section Depth of Section Dashed Dimensioning Annotation UIBezierPath:
//
//        depthOfSectionBottomDashedLinePath.move(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + steelSectionShapeLayerPathLineWidth/2, y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//        depthOfSectionBottomDashedLinePath.addLine(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + steelSectionShapeLayerPathLineWidth/2 + depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths, y: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
//
//        depthOfSectionTopDashedLinePath.move(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + steelSectionShapeLayerPathLineWidth/2, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied)))
//
//        depthOfSectionTopDashedLinePath.addLine(to: CGPoint(x: steelIsectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + steelSectionShapeLayerPathLineWidth/2 + depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied)))
//
//        dashedAnnotationLines.append(depthOfSectionBottomDashedLinePath)
//
//        dashedAnnotationLines.append(depthOfSectionTopDashedLinePath)
//
//        // MARK: - Assigning Selected Steel Section Depth of Section UIBezierPath Properties:
//
//        depthOfSectionAnnotationShapeLayer.path = depthOfSectionFullPath.cgPath
//
//        depthOfSectionAnnotationShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        depthOfSectionAnnotationShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//        // MARK: - Assinging Selected Steel Section Depth & Width of Section Dashed Dimensioning Annotation UIBezierPath Properties:
//
//        dimensioningAnnotationDashedLinesShapeLayer.path = dashedAnnotationLines.cgPath
//
//        dimensioningAnnotationDashedLinesShapeLayer.lineDashPattern =  [NSNumber(value: Float(widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)), NSNumber(value: Float((widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)/4))]
//
//        dimensioningAnnotationDashedLinesShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        dimensioningAnnotationDashedLinesShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//        // MARK: - Defining Selected Steel Section Web Thickness Dimensioning Annotation UIBezierPath:
//
//        let sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
//
//        let sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
//
//        let sectionWebThicknessRightSideHorizontalLinePath = UIBezierPath()
//
//        let sectionWebThicknessFullRightSidePath = UIBezierPath()
//
//        let sectionWebThicknessReflectedFullRightSidePath = UIBezierPath()
//
//        let sectionWebThicknessFullPath = UIBezierPath()
//
//        sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate = steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - (steelSectionShapeLayerPathLineWidth/2) - sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength - (userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied)
//
//        sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate = (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines
//
//        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.move(to: CGPoint(x: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (steelSectionShapeLayerPathLineWidth/2), y: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
//
//        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.addLine(to: CGPoint(x: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (steelSectionShapeLayerPathLineWidth/2) + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
//
//        // Below code lines are needed to reflect the bottom right hand side arrow head about the horizontal axis:
//
//        let sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
//
//        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation = CGAffineTransform(translationX: 0, y: ((steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines) * 2)
//
//        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation = sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis.concatenating(sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation)
//
//        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
//
//        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.apply(sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation)
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath)
//
//        //         Below lines of codes are needed to draw the right hand side horizontal line needed for the section web thickness annotation:
//
//        sectionWebThicknessRightSideHorizontalLinePath.move(to: CGPoint(x: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (steelSectionShapeLayerPathLineWidth/2), y: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
//
//        sectionWebThicknessRightSideHorizontalLinePath.addLine(to: CGPoint(x: steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (steelSectionShapeLayerPathLineWidth/2) + sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength, y: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveSteelSectionMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHorizontalLinePath)
//
//        // Below code lines are needed to reflect the full right hand side section web thickness annotation about the vertical axis:
//
//        let sectionWebThicknessFullRightHandSidePathReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
//
//        let sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation = CGAffineTransform(translationX: (steelIsectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x * 2) - (userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied), y: 0)
//
//        let sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation = sectionWebThicknessFullRightHandSidePathReflectionAxis.concatenating(sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation)
//
//        sectionWebThicknessReflectedFullRightSidePath.append(sectionWebThicknessFullRightSidePath)
//
//        sectionWebThicknessReflectedFullRightSidePath.apply(sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation)
//
//        sectionWebThicknessFullPath.append(sectionWebThicknessFullRightSidePath)
//
//        sectionWebThicknessFullPath.append(sectionWebThicknessReflectedFullRightSidePath)
//
//        // MARK: - Assinging Selected Steel Section Section Web Thickness Dimensioning Annotation UIBezierPath Properties:
//
//        sectionWebThicknessAnnotationShapeLayer.path = sectionWebThicknessFullPath.cgPath
//
//        sectionWebThicknessAnnotationShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        sectionWebThicknessAnnotationShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//        // MARK: - Defining Selected Steel Section Flange Thickness Dimensioning Annotation UIBezierPath:
//
//        let sectionFlangeThicknessBottomSideHalfArrowHeadPath = UIBezierPath()
//
//        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath = UIBezierPath()
//
//        let sectionFlangeThicknessBottomSideVerticalLinePath = UIBezierPath()
//
//        let sectionFlangeThicknessFullBottomSidePath = UIBezierPath()
//
//        let sectionFlangeThicknessReflectedFullBottomSidePath = UIBezierPath()
//
//        let sectionFlangeThicknessFullPath = UIBezierPath()
//
//        sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate = steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines
//
//        sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate = steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) - (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied) - (steelSectionShapeLayerPathLineWidth/2) - sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength
//
//        sectionFlangeThicknessBottomSideHalfArrowHeadPath.move(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + (steelSectionShapeLayerPathLineWidth/2)))
//
//        sectionFlangeThicknessBottomSideHalfArrowHeadPath.addLine(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + (steelSectionShapeLayerPathLineWidth/2) + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
//
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
//
//        //         Below code lines are needed to reflect the bottom half arrow head about the vertical axis:
//
//        let sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
//
//        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation = CGAffineTransform(translationX: (steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines) * 2, y: 0)
//
//        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation = sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis.concatenating(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation)
//
//        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
//
//        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.apply(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation)
//
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath)
//
//        // Below lines of codes are needed to draw the bottom hand side vertical line needed for the section flange thickness annotation:
//
//        sectionFlangeThicknessBottomSideVerticalLinePath.move(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + (steelSectionShapeLayerPathLineWidth/2)))
//
//        sectionFlangeThicknessBottomSideVerticalLinePath.addLine(to: CGPoint(x: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheSteelSectionMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + (steelSectionShapeLayerPathLineWidth/2) + sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength))
//
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideVerticalLinePath)
//
//        // Below code lines are needed to reflect the full bottom section flange thickness annotation about the horizontal axis:
//
//        let sectionFlangeThicknessFullBottomHandSidePathReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
//
//        let sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation = CGAffineTransform(translationX: 0, y: ((steelIsectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (userSelectedSteelSectionDepthReceivedFromPreviousViewController * scaleToBeApplied) + (steelSectionShapeLayerPathLineWidth/2)) * 2) - (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied) - (steelSectionShapeLayerPathLineWidth))
//
//        let sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation = sectionFlangeThicknessFullBottomHandSidePathReflectionAxis.concatenating(sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation)
//
//        sectionFlangeThicknessReflectedFullBottomSidePath.append(sectionFlangeThicknessFullBottomSidePath)
//
//        sectionFlangeThicknessReflectedFullBottomSidePath.apply(sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation)
//
//        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessFullBottomSidePath)
//
//        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessReflectedFullBottomSidePath)
//
//        // MARK: - Assinging Selected Steel Section Flange Thickness Dimensioning Annotation UIBezierPath Properties:
//
//        sectionFlangeThicknessAnnotationShapeLayer.path = sectionFlangeThicknessFullPath.cgPath
//
//        sectionFlangeThicknessAnnotationShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        sectionFlangeThicknessAnnotationShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//        // MARK: - Defining Universal Beam Section Root Radius Dimensioning Annotation Arrow UIBezierPath:
//
//        let rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol = UIBezierPath()
//
//        let rootRadiusVerticalHalfArrowHeadSymbol = UIBezierPath()
//
//        let fullRootRadiusDimensioningAnnotationPath = UIBezierPath()
//
//        let differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius = sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength - (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)
//
//        if differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius > 0 {
//
//            steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate = steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (cos(CGFloat.pi/4) * differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius)
//
//            steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate = steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (sin(CGFloat.pi/4) * differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius)
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.move(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate))
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2))
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2) + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2))), y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2))
//
//            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol)
//
//
//            rootRadiusVerticalHalfArrowHeadSymbol.move(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2))
//
//            rootRadiusVerticalHalfArrowHeadSymbol.addLine(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2 + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2)))))
//
//            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusVerticalHalfArrowHeadSymbol)
//
//
//        } else {
//
//            steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate = steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x
//
//            steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate = steelIsectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.move(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate))
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)) + steelSectionShapeLayerPathLineWidth/2, y: (steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)) + steelSectionShapeLayerPathLineWidth/2))
//
//            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2) + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2))), y: (steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2)))
//
//            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol)
//
//            rootRadiusVerticalHalfArrowHeadSymbol.move(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2))
//
//            rootRadiusVerticalHalfArrowHeadSymbol.addLine(to: CGPoint(x: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2, y: steelSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + steelSectionShapeLayerPathLineWidth/2 + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2)))))
//
//            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusVerticalHalfArrowHeadSymbol)
//
//        }
//
//        // MARK: - Assinging Universal Beam Section Root Radius Dimensioning Annotation UIBezierPath Properties:
//
//        rootRadiusDimensioningAnnotationLineShapeLayer.path = fullRootRadiusDimensioningAnnotationPath.cgPath
//
//        rootRadiusDimensioningAnnotationLineShapeLayer.strokeColor = sectionProfileDimensionalAnnotationLinesPathsStrokeColour
//
//        rootRadiusDimensioningAnnotationLineShapeLayer.fillColor = UIColor.clear.cgColor
//
//        rootRadiusDimensioningAnnotationLineShapeLayer.lineWidth = steelSectionProfileDimensionalAnnotationLinesPathsLineWidths
//
//    }
    
//    func drawSelectedParallelFlangeChannelSection() {
//
//    // Below are the points coordinates definitions used to draw the bottom half of the selected parallel flange channel by the user. Which will then be reflected to create the profile of the full section:
//
//        let channelStartingDrawingPointCoordinates: (x: CGFloat, y: CGFloat) = (x: self.view.frame.width/2 - (userSelectedSteelSectionWidthReceivedFromPreviousViewController * scaleToBeApplied), y: steelSectionDrawingView.frame.height/2)
//
//        let channelBottomLeftCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelStartingDrawingPointCoordinates.x, y: channelStartingDrawingPointCoordinates.y + ((userSelectedSteelSectionDepthReceivedFromPreviousViewController/2) * scaleToBeApplied))
//
//        let channelBottomRightCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelBottomLeftCornerPointCoordinates.x + (userSelectedSteelSectionWidthReceivedFromPreviousViewController * scaleToBeApplied), y: channelBottomLeftCornerPointCoordinates.y)
//
//        let channelTopBottomRightCornerPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelBottomRightCornerPointCoordinates.x, y: channelBottomRightCornerPointCoordinates.y - (userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController * scaleToBeApplied))
//
//        let channelBottomInnerCornerRootRadiusCentrePointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelBottomLeftCornerPointCoordinates.x + ((userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied) + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied)), y: channelTopBottomRightCornerPointCoordinates.y + (userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController * scaleToBeApplied))
//
//        let channelBottomHalfEndPointCoordinates: (x: CGFloat, y: CGFloat) = (x: channelStartingDrawingPointCoordinates.x + (userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController * scaleToBeApplied), y: channelStartingDrawingPointCoordinates.y)
//
//    }
    
    // MARK: - Function declaration to draw vertical separation lines inside scrollView:
    
//    func drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel() {
//
//        let verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView = UIBezierPath()
//
//        let scrollViewSectionDimensionalPropertiesTitleLabelCoordinatesInRelationToItsScrollView = scrollViewSectionDimensionalPropertiesTitleLabel.convert(scrollViewSectionDimensionalPropertiesTitleLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
//
//        let scrollViewRatioForWebLocalBucklingLanelCoordinatesInRelationToItsScrollView = scrollViewRatioForWebLocalBuckling.convert(scrollViewRatioForWebLocalBuckling.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
//
//        let scrollViewAxisLabelCoordinatesInRelationToItsScrollView = scrollViewAxisLabel.convert(scrollViewAxisLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
//
//        let scrollViewPlasticModulusLabelCoordinatesInRelationToItsScrollView = scrollViewPlasticModulusLabel.convert(scrollViewPlasticModulusLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
//
//        let scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView = scrollViewMajorAxisLabel.convert(scrollViewMajorAxisLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
//
//        // Drawing vertical separation line between section dimensional properties labels:
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2, y: scrollViewSectionDimensionalPropertiesTitleLabelCoordinatesInRelationToItsScrollView.y + scrollViewSectionDimensionalPropertiesTitleLabel.intrinsicContentSize.height))
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width/2, y: scrollViewRatioForWebLocalBucklingLanelCoordinatesInRelationToItsScrollView.y + scrollViewRatioForWebLocalBuckling.intrinsicContentSize.height))
//
//        // Drawing vertical separation line between section structural properties labels major and minor values:
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2 + ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4), y: scrollViewAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewAxisLabel.intrinsicContentSize.height))
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width/2 + ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4), y: scrollViewPlasticModulusLabelCoordinatesInRelationToItsScrollView.y + scrollViewPlasticModulusLabel.intrinsicContentSize.height))
//
//        // Drawing horizontal line underneath section structural properties major and minor axis labels:
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2, y: scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewMajorAxisLabel.intrinsicContentSize.height))
//
//        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView, y: scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewMajorAxisLabel.intrinsicContentSize.height))
//
//        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.path = verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.cgPath
//
//        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.strokeColor = UIColor(named: verticalAndHorizontalSeparationLinesColourInsideSectionDimensionalAndPropertiesScrollView)?.cgColor
//
//        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.lineWidth = verticalAndHorizontalSeparationLinesWidthsInsideSectionDimensionalAndPropertiesScrollView
//
//    }
        
    // MARK: - Declaring constraints:
    
    func setupConstraints() {
        
        navigationBar.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: self.view.safeAreaLayoutGuide.topAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: 0, rightAnchorConstant: 0, bottomAnchorConstant: 0, leftAnchorConstant: 0, heightAnchorAssigned: false, heightAnchorConstant: 0)
        
        steelSectionDrawingView.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: navigationBar.bottomAnchor, superViewRightAnchor: self.view.rightAnchor, superViewBottomAnchor: self.view.bottomAnchor, superViewLeftAnchor: self.view.leftAnchor, topAnchorConstant: 0, rightAnchorConstant: 0, bottomAnchorConstant: 0, leftAnchorConstant: 0, heightAnchorAssigned: true, heightAnchorConstant: self.view.frame.size.width)
        
        drawingAreaDepthOfSectionLabel.pin(fixedToSuperViewTopAnchor: true, fixedToSuperViewRightAnchor: true, fixedToSuperViewBottomAnchor: false, fixedToSuperViewLeftAnchor: true, superViewTopAnchor: steelSectionDrawingView.topAnchor, superViewRightAnchor: steelSectionDrawingView.rightAnchor, superViewBottomAnchor: steelSectionDrawingView.bottomAnchor, superViewLeftAnchor: steelSectionDrawingView.leftAnchor, topAnchorConstant: 0, rightAnchorConstant: 0, bottomAnchorConstant: 0, leftAnchorConstant: 0, heightAnchorAssigned: false, heightAnchorConstant: 0)
        
    }
    
//    func setupSubViewsConstraints() {
//
//        NSLayoutConstraint.activate([
//

//
//            // MARK: - UniversalBeamDrawingArea constraints:
//
//            steelSectionDrawingView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
//
//            steelSectionDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor),
//
//            steelSectionDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor),
//
//            steelSectionDrawingView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width),
//
//            // MARK: - UniversalBeamDrawingView elements constraints:
//
//            selectedSectionDimensionDepthLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate),
//
//            selectedSectionDimensionDepthLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: depthOfSectionDimensioningAnnotationLineXcoordinate - (selectedSectionDimensionDepthLabel.intrinsicContentSize.width/2) + (selectedSectionDimensionDepthLabel.intrinsicContentSize.height/2)),
//
//            selectedSectionDimensionWidthLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: widthOfSectionDimensioningAnnotationLineYcoordinate - (selectedSectionDimensionWidthLabel.intrinsicContentSize.height) - halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds),
//
//            selectedSectionDimensionWidthLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - (selectedSectionDimensionWidthLabel.intrinsicContentSize.width/2)),
//
//            selectedSectionDimensionThicknessOfWebLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate - (selectedSectionDimensionThicknessOfWebLabel.intrinsicContentSize.height/2)),
//
//            selectedSectionDimensionThicknessOfWebLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate - (selectedSectionDimensionThicknessOfWebLabel.intrinsicContentSize.width)),
//
//            selectedSectionDimensionThicknessOfFlangeLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate),
//
//            selectedSectionDimensionThicknessOfFlangeLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate - 1.2*(selectedSectionDimensionThicknessOfFlangeLabel.intrinsicContentSize.width)),
//
//            selectedSectionDimensionRootRadiusLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: rootRadiusAnnotationLabelTopYcoordinate + selectedSectionDimensionRootRadiusLabel.intrinsicContentSize.width/2),
//
//            selectedSectionDimensionRootRadiusLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: steelSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - selectedSectionDimensionRootRadiusLabel.intrinsicContentSize.width/2 + selectedSectionDimensionRootRadiusLabel.intrinsicContentSize.height/2),
//
//            steelSectionMinorAxisBottomAnnotationLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineBottomYcoordinate),
//
//            steelSectionMinorAxisBottomAnnotationLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - steelSectionMinorAxisBottomAnnotationLabel.intrinsicContentSize.width/2),
//
//            steelSectionMinorAxisTopAnnotationLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineTopYcoordinate - steelSectionMinorAxisTopAnnotationLabel.intrinsicContentSize.height),
//
//            steelSectionMinorAxisTopAnnotationLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - steelSectionMinorAxisTopAnnotationLabel.intrinsicContentSize.width/2),
//
//            steelSectionMajorAxisLeftAnnotationLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - steelSectionMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2),
//
//            steelSectionMajorAxisLeftAnnotationLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineLeftXcoordinate - steelSectionMajorAxisLeftAnnotationLabel.intrinsicContentSize.width),
//
//            steelSectionMajorAxisRightAnnotationLabel.topAnchor.constraint(equalTo: steelSectionDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - steelSectionMajorAxisRightAnnotationLabel.intrinsicContentSize.height/2),
//
//            steelSectionMajorAxisRightAnnotationLabel.leftAnchor.constraint(equalTo: steelSectionDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineRightXcoordinate),
//
//            // MARK: - scrollView constraints:
//
//            sectionDimensionsAndPropertiesScrollView.topAnchor.constraint(equalTo: steelSectionDrawingView.bottomAnchor),
//
//            sectionDimensionsAndPropertiesScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
//
//            sectionDimensionsAndPropertiesScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//
//            sectionDimensionsAndPropertiesScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//
//            // MARK: - scrollView elements constraints:
//
//            scrollViewSectionDimensionalPropertiesTitleLabel.topAnchor.constraint(equalTo: sectionDimensionsAndPropertiesScrollView.topAnchor, constant: scrollViewMainTitleTopMargin),
//
//            scrollViewSectionDimensionalPropertiesTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMainTitleRightMarginFromScreenEdge),
//
//            scrollViewSectionDimensionalPropertiesTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
//
//            scrollViewDepthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewSectionDimensionalPropertiesTitleLabel.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
//
//            scrollViewDepthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewDepthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWidthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.topAnchor, constant: 0),
//
//            scrollViewWidthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWidthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewFlangeThicknessLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewFlangeThicknessLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewFlangeThicknessLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWebThicknessLabel.topAnchor.constraint(equalTo: scrollViewFlangeThicknessLabel.topAnchor, constant: 0),
//
//            scrollViewWebThicknessLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWebThicknessLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionRootRadiusLabel.topAnchor.constraint(equalTo: scrollViewFlangeThicknessLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewSectionRootRadiusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionRootRadiusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewDepthOfSectionBetweenFilletsLabel.topAnchor.constraint(equalTo: scrollViewSectionRootRadiusLabel.topAnchor, constant: 0),
//
//            scrollViewDepthOfSectionBetweenFilletsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewDepthOfSectionBetweenFilletsLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewAreaOfSectionLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionBetweenFilletsLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewAreaOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewAreaOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSurfaceAreaPerMetre.topAnchor.constraint(equalTo: scrollViewAreaOfSectionLabel.topAnchor, constant: 0),
//
//            scrollViewSurfaceAreaPerMetre.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSurfaceAreaPerMetre.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSurfaceAreaPerTonne.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerMetre.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewSurfaceAreaPerTonne.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSurfaceAreaPerTonne.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionMassPerMetreLabel.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerTonne.topAnchor, constant: 0),
//
//            scrollViewSectionMassPerMetreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionMassPerMetreLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewRatioForWebLocalBuckling.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerTonne.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewRatioForWebLocalBuckling.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewRatioForWebLocalBuckling.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewRatioForFlangeLocalBuckling.topAnchor.constraint(equalTo: scrollViewRatioForWebLocalBuckling.topAnchor, constant: 0),
//
//            scrollViewRatioForFlangeLocalBuckling.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewRatioForFlangeLocalBuckling.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionDetailingDimensionsTitle.topAnchor.constraint(equalTo: scrollViewRatioForWebLocalBuckling.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
//
//            scrollViewSectionDetailingDimensionsTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewMainTitleRightMarginFromScreenEdge),
//
//            scrollViewSectionDetailingDimensionsTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
//
//            scrollViewUniversalBeamDetailingDimensionsImage.topAnchor.constraint(equalTo: scrollViewSectionDetailingDimensionsTitle.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
//
//            scrollViewUniversalBeamDetailingDimensionsImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
//
//            scrollViewUniversalBeamDetailingDimensionsImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
//
//            scrollViewEndClearanceDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewUniversalBeamDetailingDimensionsImage.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewEndClearanceDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewEndClearanceDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewNotchNdetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewEndClearanceDetailingDimensionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewNotchNdetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewNotchNdetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewNotchnDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewNotchNdetailingDimensionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewNotchnDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewNotchnDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewSectionStructuralPropertiesTitle.topAnchor.constraint(equalTo: scrollViewNotchnDetailingDimensionLabel.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
//
//            scrollViewSectionStructuralPropertiesTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMainTitleRightMarginFromScreenEdge),
//
//            scrollViewSectionStructuralPropertiesTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
//
//            scrollViewAxisLabel.topAnchor.constraint(equalTo: scrollViewSectionStructuralPropertiesTitle.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
//
//            scrollViewAxisLabel.centerXAnchor.constraint(greaterThanOrEqualTo: self.view.centerXAnchor, constant: ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4)),
//
//            scrollViewMajorAxisLabel.topAnchor.constraint(equalTo: scrollViewAxisLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewMajorAxisLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
//
//            scrollViewMajorAxisLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
//
//            scrollViewMinorAxisLabel.centerYAnchor.constraint(equalTo: scrollViewMajorAxisLabel.centerYAnchor),
//
//            scrollViewMinorAxisLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
//
//            scrollViewMinorAxisLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
//
//            scrollViewSecondMomentOfAreaLabel.topAnchor.constraint(equalTo: scrollViewMajorAxisLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewSecondMomentOfAreaLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//
//            scrollViewSecondMomentOfAreaLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewMajorSecondMomentOfAreaValue.centerYAnchor.constraint(equalTo: scrollViewSecondMomentOfAreaLabel.centerYAnchor, constant: 0),
//
//            scrollViewMajorSecondMomentOfAreaValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
//
//            scrollViewMajorSecondMomentOfAreaValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
//
//            scrollViewMinorSecondMomentOfAreaValue.centerYAnchor.constraint(equalTo: scrollViewMajorSecondMomentOfAreaValue.centerYAnchor),
//
//            scrollViewMinorSecondMomentOfAreaValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
//
//            scrollViewMinorSecondMomentOfAreaValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
//
//            scrollViewRadiusOfGyrationLabel.topAnchor.constraint(equalTo: scrollViewSecondMomentOfAreaLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewRadiusOfGyrationLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//
//            scrollViewRadiusOfGyrationLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewMajorRadiusOfGyrationValue.centerYAnchor.constraint(equalTo: scrollViewRadiusOfGyrationLabel.centerYAnchor, constant: 0),
//
//            scrollViewMajorRadiusOfGyrationValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
//
//            scrollViewMajorRadiusOfGyrationValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
//
//            scrollViewMinorRadiusOfGyrationValue.centerYAnchor.constraint(equalTo: scrollViewMajorRadiusOfGyrationValue.centerYAnchor),
//
//            scrollViewMinorRadiusOfGyrationValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
//
//            scrollViewMinorRadiusOfGyrationValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
//
//            scrollViewElasticModulusLabel.topAnchor.constraint(equalTo: scrollViewRadiusOfGyrationLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewElasticModulusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//
//            scrollViewElasticModulusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewMajorElasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewElasticModulusLabel.centerYAnchor, constant: 0),
//
//            scrollViewMajorElasticModulusValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
//
//            scrollViewMajorElasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
//
//            scrollViewMinorElasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewMajorElasticModulusValue.centerYAnchor),
//
//            scrollViewMinorElasticModulusValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
//
//            scrollViewMinorElasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
//
//            scrollViewPlasticModulusLabel.topAnchor.constraint(equalTo: scrollViewElasticModulusLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewPlasticModulusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//
//            scrollViewPlasticModulusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewMajorPlasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewPlasticModulusLabel.centerYAnchor, constant: 0),
//
//            scrollViewMajorPlasticModulusValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
//
//            scrollViewMajorPlasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
//
//            scrollViewMinorPlasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewMajorPlasticModulusValue.centerYAnchor),
//
//            scrollViewMinorPlasticModulusValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
//
//            scrollViewMinorPlasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
//
//            scrollViewBucklingParameter.topAnchor.constraint(equalTo: scrollViewPlasticModulusLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewBucklingParameter.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewBucklingParameter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewTorsionalIndex.topAnchor.constraint(equalTo: scrollViewBucklingParameter.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewTorsionalIndex.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewTorsionalIndex.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWarpingConstant.topAnchor.constraint(equalTo: scrollViewTorsionalIndex.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewWarpingConstant.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewWarpingConstant.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewTorsionalConstant.topAnchor.constraint(equalTo: scrollViewWarpingConstant.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
//
//            scrollViewTorsionalConstant.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
//
//            scrollViewTorsionalConstant.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView)
//
//        ])
//
//    }
    
}

// MARK: - UINavigationBarDelegate Extension:

extension SelectedSteelSectionSummaryPage: UINavigationBarDelegate {

    @objc func navigationBarLeftButtonPressed(sender : UIButton) {

        delegate?.dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: "SelectedSteelSectionSummaryPage", filteringSlidersCleared: false, userLastSelectedCollectionViewCellNumber: self.userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController, configuredArrayContainingSteelSectionsData: receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData, configuredArrayContainingSteelSectionsSerialNumbersOnly: receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsSerialNumbersOnly, configuredSortByVariable: self.sortBy, configuredFiltersAppliedVariable: self.filtersApplied, configuredIsSearchingVariable: self.isSearching, exchangedUserSelectedTableCellSectionNumber: receivedSelectedTableViewCellSectionNumberFromSteelSectionsTableViewController, exchangedUserSelectedTableCellRowNumber: receivedSelectedTableViewCellRowNumberFromSteelSectionsTableViewController)
        
        // In order not to instantiate a new instance of the first view controller once the user navigates back to the previous view controller, we should use present.viewController. Instead the second view controller should be dismissed. This is needed so that the user will be guided back to the previous view controller, specifically to the last location he was on inside the tableView (in terms of row and section):
        
        view.window!.layer.add(movingBackTransitionToPreviousVC, forKey: kCATransition)

        dismiss(animated: true) {}

    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {

        return UIBarPosition.topAttached

    }

}

