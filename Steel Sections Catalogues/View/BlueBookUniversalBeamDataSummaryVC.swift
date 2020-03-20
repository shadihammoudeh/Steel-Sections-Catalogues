//
//  BlueBookUniversalBeamDataSummaryVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamDataSummaryVC: UIViewController {
    
    // MARK: - Assigning protocol delegate:
    
    // Here we are setting a delegate inside this View Controller in order to be able to access all the methods inside the Protocol:
    
    var delegate: ProtocolToPassDataBackwardsWithTwoArrays?
    
    var sortBy: String = "None"

    var isSearching: Bool = false

    var filtersApplied: Bool = false
    
    var passedArrayFromPreviousViewControllerContainingAllDataRelatedToUbs = [IsectionsDimensionsParameters]()
    
    var passedArrayFromPreviousViewControllerContainingDataRelatedToSectionSerialNumbersOnly: [String] = []
    
    // MARK: - Univeral Beam properties passed from previous viewController, the below start at 0 and later on get their values from the previous View Controller:
    
    var selectedTableSectionNumberFromPreviousViewController: Int = 0
    
    var selectedTableRowNumberFromPreviousViewController: Int = 0
    
    var selectedUniversalBeamMassPerMetre: Double = 0
    
    var selectedUniversalBeamAreaOfSection: Double = 0
    
    var selectedUniversalBeamDepthOfSection: CGFloat = 0
    
    var selectedUniversalBeamWidthOfSection: CGFloat = 0
    
    var selectedUniversalBeamWebThickness: CGFloat = 0
    
    var selectedUniversalBeamFlangeThickness: CGFloat = 0
    
    var selectedUniversalBeamRootRadius: CGFloat = 0
    
    var selectedUniversalBeamDepthBetweenFillets: Double = 0
    
    var selectedUniversalBeamEndClearanceDetailingDimension = 0
    
    var selectedUniversalBeamNotchNdetailingDimension = 0
    
    var selectedUniversalBeamNotchnDetailingDimension = 0
    
    var selectedUniversalBeamSecondMomentOfAreaAboutMajorAxis: Double = 0
    
    var selectedUniversalBeamSecondMomentOfAreaAboutMinorAxis: Double = 0
    
    var selectedUniversalBeamRadiusOfGyrationAboutMajorAxis: Double = 0
    
    var selectedUniversalBeamRadiusOfGyrationAboutMinorAxis: Double = 0
    
    var selectedUniversalBeamElasticModulusAboutMajorAxis: Double = 0
    
    var selectedUniversalBeamElasticModulusAboutMinorAxis: Double = 0
    
    var selectedUniversalBeamPlasticModulusAboutMajorAxis: Double = 0
    
    var selectedUniversalBeamPlasticModulusAboutMinorAxis: Double = 0
    
    var selectedUniversalBeamBucklingParameter: Double = 0
    
    var selectedUniversalBeamTorsionalIndex: Double = 0
    
    var selectedUniversalBeamWarpingConstant: Double = 0
    
    var selectedUniversalBeamTorsionalConstant: Double = 0
    
    var selectedUniversalBeamSurfaceAreaPerMetre: Double = 0
    
    var selectedUniversalBeamSurfaceAreaPerTonne: Double = 0
    
    var selectedUniversalBeamRatioForWebLocalBuckling: Double = 0
    
    var selectedUniversalBeamRatioForFlangeLocalBuckling: Double = 0
    
    var selectedUniversalBeamSectionDesignation: String = ""
    
    // MARK: - navigationBar instance declaration:
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "UB \(selectedUniversalBeamSectionDesignation)", navBarDelegate: self)
    
    // MARK: - Font colour, type, size and strings attributes used for labels inside the Section Profile Drawing Area:
    
    let universalBeamProfileDimensionAnnotationLabelsFontSizeAndTypeInsideTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-Light", size: 11.5)
    
    let universalBeamProfileDimensionAnnotationLabelsFontColourInsideTheProfileDrawingArea = UIColor(named: "Text Font Colour for Sub Labels Inside the Section Dimensional & Structural Properties Scroll View")
    
    lazy var universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: universalBeamProfileDimensionAnnotationLabelsFontColourInsideTheProfileDrawingArea!,
        
        .font: universalBeamProfileDimensionAnnotationLabelsFontSizeAndTypeInsideTheProfileDrawingArea!,
        
    ]
    
    let universalBeamProfileDimensionLabelsAbbreviationLettersFontSizeAndTypeInsideDTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12.5)
    
    let universalBeamProfileDimensionLabelsAbbreviationLettersFontColourInsideDTheProfileDrawingArea = UIColor(named: "Text Font Colour for Sub Labels Abbreviation Letters Inside the Section Dimensional & Structural Properties Scroll View")
    
    lazy var universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: universalBeamProfileDimensionLabelsAbbreviationLettersFontColourInsideDTheProfileDrawingArea!,
        
        .font: universalBeamProfileDimensionLabelsAbbreviationLettersFontSizeAndTypeInsideDTheProfileDrawingArea!,
        
    ]
    
    lazy var universalBeamProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: -6,
        
    ]
    
    let universalBeamProfileMajorAndMinorAxisLabelFontSizeAndTypeInsideTheProfileDrawingArea = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 16)
    
    let universalBeamProfileMajorAndMinorAxisLabelFontColourInsideTheProfileDrawingArea = UIColor(named: "Text Font Colour for Table Title and Table Columns Titles Inside the Section Dimensional & Structural Properties Scroll View")
    
    lazy var universalBeamProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea: [NSAttributedString.Key: Any] = [
        
        .foregroundColor: universalBeamProfileMajorAndMinorAxisLabelFontColourInsideTheProfileDrawingArea!,
        
        .font: universalBeamProfileMajorAndMinorAxisLabelFontSizeAndTypeInsideTheProfileDrawingArea!,
        
    ]
    
    // MARK: - Declaration of universal beam drawing area:
    
    lazy var universalBeamDrawingView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "Background Colour for Section Profile Drawing Area")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    // MARK: - Declaration of UILabels to be displayed inside the universal beam drawing area:
    
    lazy var universalBeamDepthOfSectionDimensionLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

        let labelString: String = "h = \(self.selectedUniversalBeamDepthOfSection) mm"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamWidthOfSectionDimensionLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "b = \(self.selectedUniversalBeamWidthOfSection) mm"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamSectionWebThicknessDimensionLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "tw = \(self.selectedUniversalBeamWebThickness) mm"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 2))

        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 1, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamSectionFlangeThicknessDimensionLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "tf = \(self.selectedUniversalBeamFlangeThickness) mm"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 2))

        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsSubAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 1, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()
    
    lazy var universalBeamRootRadiusAnnotationLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

        let labelString: String = "r = \(self.selectedUniversalBeamRootRadius) mm"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(universalBeamProfileDimensionAnnotationLabelsStringsAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(universalBeamProfileDimensionLabelsAbbreviationLettersAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamMinorAxisBottomAnnotationLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "z"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
    labelAttributedString.addAttributes(universalBeamProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamMinorAxisTopAnnotationLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "z"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
    labelAttributedString.addAttributes(universalBeamProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamMajorAxisLeftAnnotationLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "y"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
    labelAttributedString.addAttributes(universalBeamProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    lazy var universalBeamMajorAxisRightAnnotationLabel: UILabel = {

        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.numberOfLines = 0

        let labelString: String = "y"

        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
    labelAttributedString.addAttributes(universalBeamProfileMajorAndMinorAxisLabelFontAttributesInsideTheProfileDrawingArea, range: NSRange(location: 0, length: 1))

        label.attributedText = labelAttributedString

        return label

    }()

    // MARK: - CoreAnimation layers used to draw paths inside the Section Profile Drawing Area:
    
    let universalBeamShapeLayer = CAShapeLayer()
    
    let depthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let widthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let sectionWebThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionFlangeThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionRootRadiusAnnotationShapeLayer = CAShapeLayer()
    
    let dimensioningAnnotationDashedLinesShapeLayer = CAShapeLayer()
    
    let universalBeamSectionMinorAndMajorAxisLinesShapeLayer = CAShapeLayer()
    
    let rootRadiusDimensioningAnnotationLineShapeLayer = CAShapeLayer()
        
    // MARK: - BezierPaths stroke colours and line widths inside the Section Profile Drawing Area:
    
    let universalBeamProfilePathStrokeColour: String = "Section Profile Stroke Colour"
    
    let universalBeamShapeLayerPathLineWidth: CGFloat = 1.50
    
    let universalBeamProfileDimensionalAnnotationLinesPathsStrokeColour: String = "Section Profile Dimensional Annotation Lines Paths Stroke Colour"
    
    let universalBeamProfileDimensionalAnnotationLinesPathsLineWidths: CGFloat = 1.0
    
    let universalBeamSectionMinorAndMajorAxisLinesStrokePathColour: String = "Text Font Colour for Table Title and Table Columns Titles Inside the Section Dimensional & Structural Properties Scroll View"
    
    let universalBeamSectionMinorAndMajorAxisLinesStrokePathLineWidth: CGFloat = 0.80
        
    // MARK: - depthOfSection Vertical Annotation Line X & Mid Y Coordinates, the below gets their values later on from the draw universal beam profile function:
    
    var depthOfSectionDimensioningAnnotationLineXcoordinate: CGFloat = 0
    
    var depthOfSectionAnnotationLineMidYcoordinate: CGFloat = 0
    
    // MARK: - widthOfSection Horizontal Annotation Line  Y & Mid X Coordinates Coordinate, the below gets their values later on from the draw universal beam profile function:
    
    var widthOfSectionAnnotationLineMidXcoordinate: CGFloat = 0
    
    var widthOfSectionDimensioningAnnotationLineYcoordinate: CGFloat = 0
    
    // MARK: - sectionWebThickness Left hand side Horizontal Annotation Line starting X & Y coordinate Declaration, the below gets their values later on from the draw universal beam profile function:
    
    var sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate: CGFloat = 0
    
    var sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate: CGFloat = 0
    
    // MARK: - sectionFlangeThickness Top Vertical Annotation Line Starting X & Y Coordinates Declaration, the below gets their values later on from the draw universal beam profile function:
    
    var sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate: CGFloat = 0
    
    var sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate: CGFloat = 0
    
    // MARK: - sectionMinor Vertical Annotation Top and Bottom Y Coordinates Declaration, the below gets their values later on from the draw universal beam profile function:
    
    var sectionMinorAnnotationVerticalLineTopYcoordinate: CGFloat = 0
    
    var sectionMinorAnnotationVerticalLineBottomYcoordinate: CGFloat = 0
    
    // MARK: - sectionMajor Horizontal Annotation Line Left and Right X Coordinates Declaration, the below gets their values later on from the draw universal beam profile function:
    
    var sectionMajorAnnotationHorizontalLineLeftXcoordinate: CGFloat = 0
    
    var sectionMajorAnnotationHorizontalLineRightXcoordinate: CGFloat = 0
    
    // MARK: - section dimensions labels and annotations distances, the below gets their values later on from the draw universal beam profile function:
    
    let distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    let distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    // MARK: - Section root radius inclined dimensioning annotation line starting point, the below gets their values later on from the draw universal beam profile function:
    
    var universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate: CGFloat = 0
    
    var universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate: CGFloat = 0
    
    var halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds: CGFloat = 0
    
    var rootRadiusAnnotationLabelTopYcoordinate: CGFloat = 0
            
    // MARK: - Font colour, type, size and strings attributes used for labels inside the Section Dimensions and Structural Properties Scroll View:
    
    let mainTitlesTextFontColourInsideSectionDimensionalAndStructuralPropertiesScrollView = UIColor(named: "Text Font Colour for Main Titles Inside the Section Dimensional & Structural Properties Scroll View")
    
    let mainTitlesTextFontTypeAndSizeInsideSectionDimensionalAndStructuralPropertiesScrollView = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
    
    lazy var mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: mainTitlesTextFontTypeAndSizeInsideSectionDimensionalAndStructuralPropertiesScrollView!,
        
        .foregroundColor: mainTitlesTextFontColourInsideSectionDimensionalAndStructuralPropertiesScrollView!,
        
        .underlineStyle: NSUnderlineStyle.single.rawValue
        
    ]
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontColour = UIColor(named: "Text Font Colour for Sub Labels Inside the Section Dimensional & Structural Properties Scroll View")
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
    
    lazy var subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize!,
        
        .foregroundColor: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontColour!,
        
    ]
    
    let subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewAbbreviationLettersFontColour = UIColor(named: "Text Font Colour for Sub Labels Abbreviation Letters Inside the Section Dimensional & Structural Properties Scroll View")
    
    let subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
    
    lazy var subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .font: subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewFontTypeAndSize!,
        
        .foregroundColor: subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewAbbreviationLettersFontColour!,
        
    ]
    
    lazy var subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: -7,
        
    ]
    
    let subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize = UIFont(name: "AppleSDGothicNeo-Light", size: 11)
    
    lazy var subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes: [NSAttributedString.Key: Any] = [
        
        .baselineOffset: 7,
        
        .font: subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewTextFontTypeAndSize!
        
    ]
    
    let tableTitleAndTableColumnsTitlesFontColourUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView = UIColor(named: "Text Font Colour for Table Title and Table Columns Titles Inside the Section Dimensional & Structural Properties Scroll View")
    
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
       
       let verticalAndHorizontalSeparationLinesColourInsideSectionDimensionalAndPropertiesScrollView: String = "Vertical and Horizontal Separation Lines inside the Section Dimensional & Structural Properties Scroll View"
       
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
        
        scrollView.backgroundColor = UIColor(named: "Background Colour for Section Dimensional & Structural Properties Scroll View")
        
        return scrollView
        
    }()
    
    // MARK: - ScrollView section dimensions and geometric properties labels:
    
    lazy var scrollViewSectionDimensionalPropertiesTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Dimensional Properties:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
        
        label.attributedText = attributedStringInsideUILabel
        
        return label
        
    }()
    
    lazy var scrollViewDepthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString: String = "Depth, h [mm] = \(self.selectedUniversalBeamDepthOfSection)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewWidthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString: String = "Width, b [mm] = \(self.selectedUniversalBeamWidthOfSection)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewFlangeThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Flange thickness, tf [mm] = \(self.selectedUniversalBeamFlangeThickness)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 19, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewWebThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Web thickness, tw [mm] = \(self.selectedUniversalBeamWebThickness)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 15, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 16, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSectionRootRadiusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Root radius, r [mm] = \(self.selectedUniversalBeamRootRadius)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 13, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewDepthOfSectionBetweenFilletsLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Depth between fillets, d [mm] = \(self.selectedUniversalBeamDepthBetweenFillets)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 23, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewAreaOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Area of section, A [cm2] = \(self.selectedUniversalBeamAreaOfSection)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 22, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSurfaceAreaPerMetre: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Surface area per metre [m2] = \(self.selectedUniversalBeamSurfaceAreaPerMetre)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 25, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSurfaceAreaPerTonne: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Surface area per tonne [m2] = \(self.selectedUniversalBeamSurfaceAreaPerTonne)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 25, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSectionMassPerMetreLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Mass per metre [kg/m] = \(self.selectedUniversalBeamMassPerMetre)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewRatioForWebLocalBuckling: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Ratio for web local buckling, cw/tw = \(self.selectedUniversalBeamRatioForWebLocalBuckling)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 30, length: 5))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 31, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 34, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewRatioForFlangeLocalBuckling: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Ratio for flange local buckling, cf/tf = \(self.selectedUniversalBeamRatioForFlangeLocalBuckling)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 33, length: 5))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 34, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 37, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSectionDetailingDimensionsTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Detailing Dimensions:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
        
        label.attributedText = attributedStringInsideUILabel
        
        return label
        
    }()
    
    lazy var scrollViewUniversalBeamDetailingDimensionsImage: UIImageView = {
        
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "UniversalBeamDetailingDimensionsImage")
        
        image.contentMode = .scaleAspectFit
        
        image.clipsToBounds = true
        
        image.layer.borderColor = UIColor.blue.cgColor
        
        return image
        
    }()
    
    lazy var scrollViewEndClearanceDetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "End clearance, C [mm] = \(self.selectedUniversalBeamEndClearanceDetailingDimension)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 15, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewNotchNdetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Notch, N [mm] = \(self.selectedUniversalBeamNotchNdetailingDimension)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewNotchnDetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Notch, n [mm] = \(self.selectedUniversalBeamNotchnDetailingDimension)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 7, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSectionStructuralPropertiesTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let attributedStringInsideUILabel = NSMutableAttributedString(string: "Section Structural Properties:", attributes: mainTitlesLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes)
        
        label.attributedText = attributedStringInsideUILabel
        
        return label
        
    }()
    
    lazy var scrollViewAxisLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Axis"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMajorAxisLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = "Major \n(y-y)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(tableColumnsSubTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 7, length: 5))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMinorAxisLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = "Minor \n(z-z)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(tableTitleAndTableColumnsTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(tableColumnsSubTitlesStringAttributesUnderneathSectionStructuralPropertiesMainTitleInsideSectionDimensionsAndStructuralPropertiesScrollView, range: NSRange(location: 7, length: 5))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSecondMomentOfAreaLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Second moment of area, I [cm4]:"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 23, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 28, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMajorSecondMomentOfAreaValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamSecondMomentOfAreaAboutMajorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMinorSecondMomentOfAreaValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamSecondMomentOfAreaAboutMinorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewRadiusOfGyrationLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Radius of gyration, i [cm]:"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMajorRadiusOfGyrationValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamRadiusOfGyrationAboutMajorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMinorRadiusOfGyrationValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamRadiusOfGyrationAboutMinorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewElasticModulusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Elastic modulus, Wel [cm3]:"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 3))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMajorElasticModulusValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamElasticModulusAboutMajorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMinorElasticModulusValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamElasticModulusAboutMinorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewPlasticModulusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Plastic modulus, Wpl [cm3]:"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 3))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMajorPlasticModulusValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamPlasticModulusAboutMajorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewMinorPlasticModulusValue: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textAlignment = NSTextAlignment.center
        
        let labelString = String(self.selectedUniversalBeamPlasticModulusAboutMinorAxis)
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewBucklingParameter: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Buckling parameter, U = \(self.selectedUniversalBeamBucklingParameter)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewTorsionalIndex: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Torsional index, X = \(self.selectedUniversalBeamTorsionalIndex)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 17, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewWarpingConstant: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Warping constant, Iw [dm6] = \(self.selectedUniversalBeamWarpingConstant)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 18, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 19, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 24, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewTorsionalConstant: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        let labelString = "Torsional constant, IT [cm4] = \(self.selectedUniversalBeamTorsionalConstant)"
        
        let labelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        labelAttributedString.addAttributes(subLabelsInsideSectionDimensionalAndStructuralPropertiesScrollViewTextStringAttributes, range: NSRange(location: 0, length: labelString.count))
        labelAttributedString.addAttributes(subLabelsAbbrivationLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 20, length: 2))
        
        labelAttributedString.addAttributes(subLabelsSubscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 21, length: 1))
        
        labelAttributedString.addAttributes(subLabelsSuperscriptLettersInsideSectionDimensionalAndStructuralPropertiesScrollViewStringAttributes, range: NSRange(location: 26, length: 1))
        
        label.attributedText = labelAttributedString
        
        return label
        
    }()
    
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                                
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(navigationBarLeftButtonPressed(sender:)))
                
        rightGestureRecognizer.direction = .right
                
        self.view.addGestureRecognizer(rightGestureRecognizer)
                
        // MARK: - Adding SubViews to the main View Controller:
        
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamDrawingView)
        
        view.addSubview(sectionDimensionsAndPropertiesScrollView)
        
        // MARK: - Adding SubViews to universalBeamDrawingView:
        
        universalBeamDrawingView.layer.addSublayer(universalBeamShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(depthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(widthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(dimensioningAnnotationDashedLinesShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionWebThicknessAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionFlangeThicknessAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionRootRadiusAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(universalBeamSectionMinorAndMajorAxisLinesShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(rootRadiusDimensioningAnnotationLineShapeLayer)
        
        universalBeamDrawingView.addSubview(universalBeamDepthOfSectionDimensionLabel)

        universalBeamDrawingView.addSubview(universalBeamWidthOfSectionDimensionLabel)

        universalBeamDrawingView.addSubview(universalBeamSectionWebThicknessDimensionLabel)

        universalBeamDrawingView.addSubview(universalBeamSectionFlangeThicknessDimensionLabel)

        universalBeamDrawingView.addSubview(universalBeamRootRadiusAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisBottomAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisTopAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMajorAxisLeftAnnotationLabel)

        universalBeamDrawingView.addSubview(universalBeamMajorAxisRightAnnotationLabel)

        // MARK: - Adding scrollView subViews:
    sectionDimensionsAndPropertiesScrollView.layer.addSublayer(verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDimensionalPropertiesTitleLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWidthOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewFlangeThicknessLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWebThicknessLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionRootRadiusLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionBetweenFilletsLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewAreaOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSurfaceAreaPerMetre)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSurfaceAreaPerTonne)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionMassPerMetreLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRatioForWebLocalBuckling)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRatioForFlangeLocalBuckling)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDetailingDimensionsTitle)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewEndClearanceDetailingDimensionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchNdetailingDimensionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchnDetailingDimensionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewUniversalBeamDetailingDimensionsImage)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionStructuralPropertiesTitle)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSecondMomentOfAreaLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewAxisLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorAxisLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorAxisLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorSecondMomentOfAreaValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorSecondMomentOfAreaValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewRadiusOfGyrationLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorRadiusOfGyrationValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorRadiusOfGyrationValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewElasticModulusLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorElasticModulusValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorElasticModulusValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewPlasticModulusLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMajorPlasticModulusValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewMinorPlasticModulusValue)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewBucklingParameter)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewTorsionalIndex)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWarpingConstant)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewTorsionalConstant)
        
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
        
        // In order for the beam profile as well as its annotation to red-draw themselves when the system theme changes from light to dark or visa versa, we need to place the draw function inside viewWillLayoutSubviews:
        
        drawUniversalBeamPathAndItsAnnotations()
        
        // MARK: - Assigning needed constraints:
        
        setupSubViewsConstraints()
        
        drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel()
        
        let scrollViewTorsionalConstantLabelCoordinatesOriginInRelationToItsScrollView = scrollViewTorsionalConstant.convert(scrollViewTorsionalConstant.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        // MARK: - Defining sectionDimensionsAndPropertiesScrollView contentSize:
        
        sectionDimensionsAndPropertiesScrollView.contentSize = CGSize(width: view.frame.size.width, height: scrollViewTorsionalConstantLabelCoordinatesOriginInRelationToItsScrollView.y + scrollViewMainTitleTopMargin + scrollViewTorsionalConstant.intrinsicContentSize.height)
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.sectionDimensionsAndPropertiesScrollView.flashScrollIndicators()
        
    }
    
    // MARK: - Function declaration for drawing universal beam section as well as its dimensioning and annotations lines:
    
    func drawUniversalBeamPathAndItsAnnotations() {
        
        // MARK: - Set of common distances:
        
        let minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges: CGFloat = 10
        
        let sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength: CGFloat = 20
                                
        let distanceFromMajorOrMinorUniversalBeamAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine: CGFloat = 5
        
        let distanceBetweenEndOfWidthOfSectionVerticalDashedDimensioningAnnotationLineAndDrawingViewTopOrBottomBorder: CGFloat = 5
        
        let distanceBetweenEndOfDepthOfSectionHorizontalDashedDimensioningAnnotationLinesndDrawingViewLeftOrRightBorder: CGFloat = 5
        
        let widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths: CGFloat = (minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges + universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.height + distanceFromMajorOrMinorUniversalBeamAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine) * 2

        let depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths: CGFloat = (minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges + universalBeamMajorAxisRightAnnotationLabel.intrinsicContentSize.width + distanceFromMajorOrMinorUniversalBeamAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine) * 2
                
        let drawingViewTopAndBottomMargin: CGFloat = widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths + distanceBetweenEndOfWidthOfSectionVerticalDashedDimensioningAnnotationLineAndDrawingViewTopOrBottomBorder
        
        let drawingViewLeftAndRightMargin: CGFloat = depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths + distanceBetweenEndOfDepthOfSectionHorizontalDashedDimensioningAnnotationLinesndDrawingViewLeftOrRightBorder
        
        // MARK: - Calculating universal beam section drawing scale and setting triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol:
        
        let widthScale: CGFloat = (self.view.frame.size.width - (drawingViewLeftAndRightMargin * 2)) / selectedUniversalBeamWidthOfSection
        
        let depthScale: CGFloat = (self.view.frame.size.width - (drawingViewTopAndBottomMargin * 2)) / selectedUniversalBeamDepthOfSection
        
        let scaleToBeApplied = min(widthScale, depthScale)
        
         let distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines: CGFloat = ((selectedUniversalBeamWebThickness/2) + (selectedUniversalBeamRootRadius*2)) * scaleToBeApplied
        
        let distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines: CGFloat = -1 * (universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2 + 2 * (selectedUniversalBeamWebThickness * scaleToBeApplied))
        
        let triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol: CGFloat = (selectedUniversalBeamFlangeThickness * scaleToBeApplied)/2
        
        halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds = triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol * sin(CGFloat.pi/4)
        
        // MARK: - Set of points that define the quarter of the universal beam profile section contained in the +ve x and +ve y quadrant:
        
        let universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: self.view.frame.width/2 , y: drawingViewTopAndBottomMargin)
        
        let universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
        
        let universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: (universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (selectedUniversalBeamFlangeThickness * scaleToBeApplied))
        
        rootRadiusAnnotationLabelTopYcoordinate = universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y
                
        let universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((selectedUniversalBeamWebThickness * scaleToBeApplied)/2) + (selectedUniversalBeamRootRadius * scaleToBeApplied), y: (universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (selectedUniversalBeamRootRadius * scaleToBeApplied))
        
        let universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) - (selectedUniversalBeamRootRadius * scaleToBeApplied), y: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied))
        
        let topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2) + (depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths/2),y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
        
        let leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied),y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - universalBeamShapeLayerPathLineWidth/2 - (widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/2))
        
        // MARK: - Declaring the various paths stroke colours:
        
        let universalBeamPathStrokeColour = UIColor(named: universalBeamProfilePathStrokeColour)!.cgColor
        
        let universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour = UIColor(named: universalBeamProfileDimensionalAnnotationLinesPathsStrokeColour)!.cgColor
        
        let universalBeamSectionMajorAndMinorAnnotationAxisPathStrokeColour = UIColor(named: universalBeamSectionMinorAndMajorAxisLinesStrokePathColour)!.cgColor
        
        // MARK: - Defining Universal Beam Section Outline UIBezierPath:
        
        let path = UIBezierPath()
        
        let mirroredPathOne = UIBezierPath()
        
        let mirroredPathTwo = UIBezierPath()
        
        let halfTheSectionPath = UIBezierPath()
        
        let fullSectionPath = UIBezierPath()
        
        path.move(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        path.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        path.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.x , y: universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        path.addLine(to: CGPoint(x: universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: (universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - (selectedUniversalBeamRootRadius * scaleToBeApplied)))
        
        path.addArc(withCenter: CGPoint(x: universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y), radius: -1 * (selectedUniversalBeamRootRadius * scaleToBeApplied), startAngle: (CGFloat.pi)/2, endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        // Here we are carrying out the first reflection and translation process about the X-Axis in order to obtain half of the final path:
        
        let reflectionLineAboutXaxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let translationInYaxisAfterReflectionIsDone = CGAffineTransform(translationX: 0, y: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) * 2)
        
        let requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess = reflectionLineAboutXaxis.concatenating(translationInYaxisAfterReflectionIsDone)
        
        mirroredPathOne.append(path)
        mirroredPathOne.apply(requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess)
        
        halfTheSectionPath.append(path)
        
        halfTheSectionPath.append(mirroredPathOne)
        
        // Here we are carrying out the second reflection and translation process about the Y-Axis in order to obtain the full section path:
        
        let reflectionLineAboutYaxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let translationInXaxisAfterReflectionIsDone = CGAffineTransform(translationX: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) * 2, y: 0)
        
        let requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess = reflectionLineAboutYaxis.concatenating(translationInXaxisAfterReflectionIsDone)
        
        mirroredPathTwo.append(halfTheSectionPath)
        
        mirroredPathTwo.apply(requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess)
        
        fullSectionPath.append(halfTheSectionPath)
        
        fullSectionPath.append(mirroredPathTwo)
        
        // MARK: - Assigning Universal Beam Section UIBezierPath Properties:
        
        universalBeamShapeLayer.path = fullSectionPath.cgPath
        
        universalBeamShapeLayer.fillColor = UIColor.clear.cgColor
        
        universalBeamShapeLayer.strokeColor = universalBeamPathStrokeColour
        
        universalBeamShapeLayer.lineWidth = universalBeamShapeLayerPathLineWidth
        
        // MARK: - Defining Universal Beam Width of Section Dimensioning Annotation UIBezierPath:
        
        let widthOfSectionHalfOfTheLeftSideArrowHeadPath = UIBezierPath()
        
        let widthOfSectionReflectedLeftArrowHeadHalfPath = UIBezierPath()
        
        let widthOfSectionHalfOfHorizontalLinePath = UIBezierPath()
        
        let widthOfSectionLeftSideDashedLinePath = UIBezierPath()
        
        let widthOfSectionRightSideDashedLinePath = UIBezierPath()
        
        let widthOfSectionFullLeftSideHalfPath = UIBezierPath()
        
        let widthOfSectionReflectedFullLeftSideHalfPath = UIBezierPath()
        
        let widthOfSectionFullPath = UIBezierPath()
        
        let dashedAnnotationLines = UIBezierPath()
        
        widthOfSectionAnnotationLineMidXcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x
        
        widthOfSectionDimensioningAnnotationLineYcoordinate = leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.addLine(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        // Below code lines are needed to reflect the left hand side half of the arrow head about the horizontal x-axis:
        
        let widthOfSectionLeftHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let widthOfSectionReflectedLeftHandArrowHeadTranslation = CGAffineTransform(translationX: 0, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y * 2)
        
        let widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation = widthOfSectionLeftHandSideArrowHeadReflectionAxis.concatenating(widthOfSectionReflectedLeftHandArrowHeadTranslation)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.apply(widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation)
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionReflectedLeftArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the left hand side horizontal line half needed for the width of section annotation:
        
        widthOfSectionHalfOfHorizontalLinePath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
        
        widthOfSectionHalfOfHorizontalLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.y))
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfHorizontalLinePath)
        
        // Below code lines are needed in order to reflect the left hand side half of the Width Of Section Annotation elements about the vertical y-axis:
        
        let widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath = CGAffineTransform(scaleX: -1, y: 1)
        
        let widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath = CGAffineTransform(translationX: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x * 2, y: 0)
        
        let requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath = widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath.concatenating(widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath)
        
        widthOfSectionReflectedFullLeftSideHalfPath.append(widthOfSectionFullLeftSideHalfPath)
        
        widthOfSectionReflectedFullLeftSideHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath)
        
        widthOfSectionFullPath.append(widthOfSectionFullLeftSideHalfPath)
        
        widthOfSectionFullPath.append(widthOfSectionReflectedFullLeftSideHalfPath)
        
        // MARK: - Defining Universal Beam Width of Section Dashed Dimensioning Annotation UIBezierPath:
        
        widthOfSectionLeftSideDashedLinePath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (universalBeamShapeLayerPathLineWidth/2)))
        
        widthOfSectionLeftSideDashedLinePath.addLine(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (universalBeamShapeLayerPathLineWidth/2) - widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths))
        
        widthOfSectionRightSideDashedLinePath.move(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (universalBeamShapeLayerPathLineWidth/2)))
        
        widthOfSectionRightSideDashedLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - (universalBeamShapeLayerPathLineWidth/2) - widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths))
        
        dashedAnnotationLines.append(widthOfSectionLeftSideDashedLinePath)
        
        dashedAnnotationLines.append(widthOfSectionRightSideDashedLinePath)
        
        // MARK: - Assigning Universal Beam Width of Section UIBezierPath Properties:
        
        widthOfSectionAnnotationShapeLayer.path = widthOfSectionFullPath.cgPath
        
        widthOfSectionAnnotationShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        widthOfSectionAnnotationShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
        // MARK: - Defining Universal Beam Section Major & Minor Axis Annotation UIBezierPath:
        
        let universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath = UIBezierPath()
        
        sectionMinorAnnotationVerticalLineTopYcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMinorAnnotationVerticalLineBottomYcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMajorAnnotationHorizontalLineLeftXcoordinate = leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMajorAnnotationHorizontalLineRightXcoordinate = universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath.move(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
        
        universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
        
        // MARK: - Assigning Universal Beam Section Major & Minor Axis Annotation UIBezierPath Properties:
        
        universalBeamSectionMinorAndMajorAxisLinesShapeLayer.path = universalBeamMinorAndMajorAxisAnnotationLinesBEzierPath.cgPath
        
        universalBeamSectionMinorAndMajorAxisLinesShapeLayer.lineWidth = universalBeamSectionMinorAndMajorAxisLinesStrokePathLineWidth
        
        universalBeamSectionMinorAndMajorAxisLinesShapeLayer.strokeColor = universalBeamSectionMajorAndMinorAnnotationAxisPathStrokeColour
        universalBeamSectionMinorAndMajorAxisLinesShapeLayer.lineDashPattern = [10, 2]
        
        // MARK: - Defining Universal Beam Depth of Section Dimensioning Annotation UIBezierPath:
        
        let depthOfSectionHalfOfBottomArrowHeadPath = UIBezierPath()
        
        let depthOfSectionReflectedBottomArrowHeadHalfPath = UIBezierPath()
        
        let depthOfSectionHalfOfVerticalLinePath = UIBezierPath()
        
        let depthOfSectionBottomDashedLinePath = UIBezierPath()
        
        let depthOfSectionTopDashedLinePath = UIBezierPath()
        
        let depthOfSectionFullBottomHalfPath = UIBezierPath()
        
        let depthOfSectionReflectedFullBottomHalfPath = UIBezierPath()
        
        let depthOfSectionFullPath = UIBezierPath()
        
        depthOfSectionDimensioningAnnotationLineXcoordinate = topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x
        
        depthOfSectionAnnotationLineMidYcoordinate = universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y
        
        depthOfSectionHalfOfBottomArrowHeadPath.move(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y))
        
        depthOfSectionHalfOfBottomArrowHeadPath.addLine(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x - triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom half of the arrow head about the vertical y-axis:
        
        let depthOfSectionBottomArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let depthOfSectionReflectedBottomArrowHeadTranslation = CGAffineTransform(translationX: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x * 2, y: 0)
        
        let depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation = depthOfSectionBottomArrowHeadReflectionAxis.concatenating(depthOfSectionReflectedBottomArrowHeadTranslation)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.apply(depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation)
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionReflectedBottomArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the bottom vertical line half needed for the depth of section annotation:
        
        depthOfSectionHalfOfVerticalLinePath.move(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y))
        
        depthOfSectionHalfOfVerticalLinePath.addLine(to: CGPoint(x: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.x, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfVerticalLinePath)
        
        // Below code lines are needed in order to reflect the bottom half of the Depth Of Section Annotation elements about the horziontal x-axis:
        
        let depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath = CGAffineTransform(scaleX: 1, y: -1)
        
        let depthOfSectionTranslationForTheReflectedFullBottomHalfPath = CGAffineTransform(translationX: 0, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y * 2)
        
        let requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath = depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath.concatenating(depthOfSectionTranslationForTheReflectedFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.append(depthOfSectionFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionReflectedFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionFullBottomHalfPath)
        
        // MARK: - Defining Universal Beam Depth of Section Dashed Dimensioning Annotation UIBezierPath:
        
        depthOfSectionBottomDashedLinePath.move(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        depthOfSectionBottomDashedLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + universalBeamShapeLayerPathLineWidth/2 + depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths, y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        depthOfSectionTopDashedLinePath.move(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + universalBeamShapeLayerPathLineWidth/2, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied)))
        
        depthOfSectionTopDashedLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + universalBeamShapeLayerPathLineWidth/2 + depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths, y: topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied)))
        
        dashedAnnotationLines.append(depthOfSectionBottomDashedLinePath)
        
        dashedAnnotationLines.append(depthOfSectionTopDashedLinePath)
        
        // MARK: - Assigning Universal Beam Depth of Section UIBezierPath Properties:
        
        depthOfSectionAnnotationShapeLayer.path = depthOfSectionFullPath.cgPath
        
        depthOfSectionAnnotationShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        depthOfSectionAnnotationShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
        // MARK: - Assinging Universal Beam Depth & Width of Section Dashed Dimensioning Annotation UIBezierPath Properties:
        
        dimensioningAnnotationDashedLinesShapeLayer.path = dashedAnnotationLines.cgPath
        
        dimensioningAnnotationDashedLinesShapeLayer.lineDashPattern =  [NSNumber(value: Float(widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)), NSNumber(value: Float((widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)/4))]
        
        dimensioningAnnotationDashedLinesShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        dimensioningAnnotationDashedLinesShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
        // MARK: - Defining Universal Beam Section Web Thickness Dimensioning Annotation UIBezierPath:
        
        let sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessRightSideHorizontalLinePath = UIBezierPath()
        
        let sectionWebThicknessFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessReflectedFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessFullPath = UIBezierPath()
        
        sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate = universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - (universalBeamShapeLayerPathLineWidth/2) - sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength - (selectedUniversalBeamWebThickness * scaleToBeApplied)
        
        sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate = (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.move(to: CGPoint(x: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2), y: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.addLine(to: CGPoint(x: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2) + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom right hand side arrow head about the horizontal axis:
        
        let sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation = CGAffineTransform(translationX: 0, y: ((universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines) * 2)
        
        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation = sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis.concatenating(sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation)
        
        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.apply(sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation)
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath)
        
        //         Below lines of codes are needed to draw the right hand side horizontal line needed for the section web thickness annotation:
        
        sectionWebThicknessRightSideHorizontalLinePath.move(to: CGPoint(x: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2), y: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
        
        sectionWebThicknessRightSideHorizontalLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2) + sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength, y: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) - distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines))
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHorizontalLinePath)
        
        // Below code lines are needed to reflect the full right hand side section web thickness annotation about the vertical axis:
        
        let sectionWebThicknessFullRightHandSidePathReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation = CGAffineTransform(translationX: (universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x * 2) - (selectedUniversalBeamWebThickness * scaleToBeApplied), y: 0)
        
        let sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation = sectionWebThicknessFullRightHandSidePathReflectionAxis.concatenating(sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation)
        
        sectionWebThicknessReflectedFullRightSidePath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessReflectedFullRightSidePath.apply(sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessReflectedFullRightSidePath)
        
        // MARK: - Assinging Universal Beam Section Web Thickness Dimensioning Annotation UIBezierPath Properties:
        
        sectionWebThicknessAnnotationShapeLayer.path = sectionWebThicknessFullPath.cgPath
        
        sectionWebThicknessAnnotationShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        sectionWebThicknessAnnotationShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
        // MARK: - Defining Universal Beam Section Flange Thickness Dimensioning Annotation UIBezierPath:
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadPath = UIBezierPath()
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath = UIBezierPath()
        
        let sectionFlangeThicknessBottomSideVerticalLinePath = UIBezierPath()
        
        let sectionFlangeThicknessFullBottomSidePath = UIBezierPath()
        
        let sectionFlangeThicknessReflectedFullBottomSidePath = UIBezierPath()
        
        let sectionFlangeThicknessFullPath = UIBezierPath()
        
        sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines
        
        sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied) - (universalBeamShapeLayerPathLineWidth/2) - sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength
        
        sectionFlangeThicknessBottomSideHalfArrowHeadPath.move(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)))
        
        sectionFlangeThicknessBottomSideHalfArrowHeadPath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2) + triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol))
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
        
        //         Below code lines are needed to reflect the bottom half arrow head about the vertical axis:
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation = CGAffineTransform(translationX: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines) * 2, y: 0)
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation = sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis.concatenating(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation)
        
        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
        
        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.apply(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation)
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath)
        
        // Below lines of codes are needed to draw the bottom hand side vertical line needed for the section flange thickness annotation:
        
        sectionFlangeThicknessBottomSideVerticalLinePath.move(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)))
        
        sectionFlangeThicknessBottomSideVerticalLinePath.addLine(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2) + sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength))
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideVerticalLinePath)
        
        // Below code lines are needed to reflect the full bottom section flange thickness annotation about the horizontal axis:
        
        let sectionFlangeThicknessFullBottomHandSidePathReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation = CGAffineTransform(translationX: 0, y: ((universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)) * 2) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied) - (universalBeamShapeLayerPathLineWidth))
        
        let sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation = sectionFlangeThicknessFullBottomHandSidePathReflectionAxis.concatenating(sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation)
        
        sectionFlangeThicknessReflectedFullBottomSidePath.append(sectionFlangeThicknessFullBottomSidePath)
        
        sectionFlangeThicknessReflectedFullBottomSidePath.apply(sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation)
        
        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessFullBottomSidePath)
        
        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessReflectedFullBottomSidePath)
        
        // MARK: - Assinging Universal Beam Section Flange Thickness Dimensioning Annotation UIBezierPath Properties:
        
        sectionFlangeThicknessAnnotationShapeLayer.path = sectionFlangeThicknessFullPath.cgPath
        
        sectionFlangeThicknessAnnotationShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        sectionFlangeThicknessAnnotationShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
        // MARK: - Defining Universal Beam Section Root Radius Dimensioning Annotation Arrow UIBezierPath:
        
        let rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol = UIBezierPath()
        
        let rootRadiusVerticalHalfArrowHeadSymbol = UIBezierPath()
        
        let fullRootRadiusDimensioningAnnotationPath = UIBezierPath()
                
        let differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius = sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength - (selectedUniversalBeamRootRadius * scaleToBeApplied)
        
        if differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius > 0 {
            
            universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate = universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (cos(CGFloat.pi/4) * differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius)
            
            universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate = universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (sin(CGFloat.pi/4) * differenceBetweenSectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLengthAndSelectedUniversalBeamRootRadius)
            
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.move(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate))
            
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2))
            
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2) + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2))), y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2))
            
            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol)
            
            
            rootRadiusVerticalHalfArrowHeadSymbol.move(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2))
            
            rootRadiusVerticalHalfArrowHeadSymbol.addLine(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2 + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2)))))
            
            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusVerticalHalfArrowHeadSymbol)
            
            
        } else {
            
            universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate = universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x
            
            universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate = universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y
                        
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.move(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate))
            
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * selectedUniversalBeamRootRadius * scaleToBeApplied)) + universalBeamShapeLayerPathLineWidth/2, y: (universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * selectedUniversalBeamRootRadius * scaleToBeApplied)) + universalBeamShapeLayerPathLineWidth/2))
            
            rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol.addLine(to: CGPoint(x: (universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2) + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2))), y: (universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2)))
            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusDimensioningInclinedLinePathAndHorizontalHalfArrowSymbol)
            
            rootRadiusVerticalHalfArrowHeadSymbol.move(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2))
            
            rootRadiusVerticalHalfArrowHeadSymbol.addLine(to: CGPoint(x: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - (cos(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2, y: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate - (sin(CGFloat.pi/4) * sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength) + universalBeamShapeLayerPathLineWidth/2 + (sqrt(pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2) + pow(triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol, 2)))))
            
            fullRootRadiusDimensioningAnnotationPath.append(rootRadiusVerticalHalfArrowHeadSymbol)
            
        }
        
        // MARK: - Assinging Universal Beam Section Root Radius Dimensioning Annotation UIBezierPath Properties:
        
        rootRadiusDimensioningAnnotationLineShapeLayer.path = fullRootRadiusDimensioningAnnotationPath.cgPath
        
        rootRadiusDimensioningAnnotationLineShapeLayer.strokeColor = universalBeamSectionDimensionalAnnotationLinesPathsStrokeColour
        
        rootRadiusDimensioningAnnotationLineShapeLayer.fillColor = UIColor.clear.cgColor
        
        rootRadiusDimensioningAnnotationLineShapeLayer.lineWidth = universalBeamProfileDimensionalAnnotationLinesPathsLineWidths
        
    }
    
    // MARK: - Function declaration to draw vertical separation lines inside scrollView:
    
    func drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel() {
        
        let verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView = UIBezierPath()
        
        let scrollViewSectionDimensionalPropertiesTitleLabelCoordinatesInRelationToItsScrollView = scrollViewSectionDimensionalPropertiesTitleLabel.convert(scrollViewSectionDimensionalPropertiesTitleLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        let scrollViewRatioForWebLocalBucklingLanelCoordinatesInRelationToItsScrollView = scrollViewRatioForWebLocalBuckling.convert(scrollViewRatioForWebLocalBuckling.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        let scrollViewAxisLabelCoordinatesInRelationToItsScrollView = scrollViewAxisLabel.convert(scrollViewAxisLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        let scrollViewPlasticModulusLabelCoordinatesInRelationToItsScrollView = scrollViewPlasticModulusLabel.convert(scrollViewPlasticModulusLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        let scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView = scrollViewMajorAxisLabel.convert(scrollViewMajorAxisLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        // Drawing vertical separation line between section dimensional properties labels:
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2, y: scrollViewSectionDimensionalPropertiesTitleLabelCoordinatesInRelationToItsScrollView.y + scrollViewSectionDimensionalPropertiesTitleLabel.intrinsicContentSize.height))
        
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width/2, y: scrollViewRatioForWebLocalBucklingLanelCoordinatesInRelationToItsScrollView.y + scrollViewRatioForWebLocalBuckling.intrinsicContentSize.height))
        
        // Drawing vertical separation line between section structural properties labels major and minor values:
        
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2 + ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4), y: scrollViewAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewAxisLabel.intrinsicContentSize.height))
        
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width/2 + ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4), y: scrollViewPlasticModulusLabelCoordinatesInRelationToItsScrollView.y + scrollViewPlasticModulusLabel.intrinsicContentSize.height))
        
        // Drawing horizontal line underneath section structural properties major and minor axis labels:
        
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.move(to: CGPoint(x: self.view.frame.width/2, y: scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewMajorAxisLabel.intrinsicContentSize.height))
        verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.addLine(to: CGPoint(x: self.view.frame.width - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView, y: scrollViewMajorAxisLabelCoordinatesInRelationToItsScrollView.y + scrollViewMajorAxisLabel.intrinsicContentSize.height))
        
        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.path = verticalAndHorizontalSeparatorLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollView.cgPath
        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.strokeColor = UIColor(named: verticalAndHorizontalSeparationLinesColourInsideSectionDimensionalAndPropertiesScrollView)?.cgColor
        verticalAndHorizontalSeparationLinesNeededBetweenLabelsContainedInSectionDimensionsAndPropertiesScrollViewCoreAnimationShapeLayer.lineWidth = verticalAndHorizontalSeparationLinesWidthsInsideSectionDimensionalAndPropertiesScrollView
        
    }
    
    // MARK: - Declaring constraints:
    
    func setupSubViewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            // MARK: - NavigationBar constraints:
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            // MARK: - UniversalBeamDrawingArea constraints:
            
            universalBeamDrawingView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            universalBeamDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            universalBeamDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor),
                        
            universalBeamDrawingView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width),
            
            // MARK: - UniversalBeamDrawingView elements constraints:
            
            universalBeamDepthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate),
            
            universalBeamDepthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: depthOfSectionDimensioningAnnotationLineXcoordinate - (universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.width/2) + (universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.height/2)),

            universalBeamWidthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: widthOfSectionDimensioningAnnotationLineYcoordinate - (universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.height) - halfOfTheAnnotationArrowHeightAtDimensioningLinesEnds),

            universalBeamWidthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - (universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.width/2)),
            universalBeamSectionWebThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate - (universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.height/2)),

            universalBeamSectionWebThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate - (universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.width)),

            universalBeamSectionFlangeThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate),
            universalBeamSectionFlangeThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate - 1.2*(universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.width)),
            
            universalBeamRootRadiusAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: rootRadiusAnnotationLabelTopYcoordinate + universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamRootRadiusAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.width/2 + universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMinorAxisBottomAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineBottomYcoordinate),
            
            universalBeamMinorAxisBottomAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisBottomAnnotationLabel.intrinsicContentSize.width/2),

            universalBeamMinorAxisTopAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineTopYcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.height),

            universalBeamMinorAxisTopAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineLeftXcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.width),

            universalBeamMajorAxisRightAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisRightAnnotationLabel.intrinsicContentSize.height/2),

            universalBeamMajorAxisRightAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineRightXcoordinate),

            // MARK: - scrollView constraints:
            
            sectionDimensionsAndPropertiesScrollView.topAnchor.constraint(equalTo: universalBeamDrawingView.bottomAnchor),
            
            sectionDimensionsAndPropertiesScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            
            sectionDimensionsAndPropertiesScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            sectionDimensionsAndPropertiesScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
            // MARK: - scrollView elements constraints:
            
            scrollViewSectionDimensionalPropertiesTitleLabel.topAnchor.constraint(equalTo: sectionDimensionsAndPropertiesScrollView.topAnchor, constant: scrollViewMainTitleTopMargin),
            
            scrollViewSectionDimensionalPropertiesTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMainTitleRightMarginFromScreenEdge),
            
            scrollViewSectionDimensionalPropertiesTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
            
            scrollViewDepthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewSectionDimensionalPropertiesTitleLabel.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
            
            scrollViewDepthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewDepthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWidthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.topAnchor, constant: 0),

            scrollViewWidthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWidthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewFlangeThicknessLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewFlangeThicknessLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewFlangeThicknessLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWebThicknessLabel.topAnchor.constraint(equalTo: scrollViewFlangeThicknessLabel.topAnchor, constant: 0),

            scrollViewWebThicknessLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWebThicknessLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionRootRadiusLabel.topAnchor.constraint(equalTo: scrollViewFlangeThicknessLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewSectionRootRadiusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionRootRadiusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.topAnchor.constraint(equalTo: scrollViewSectionRootRadiusLabel.topAnchor, constant: 0),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewAreaOfSectionLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionBetweenFilletsLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewAreaOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewAreaOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSurfaceAreaPerMetre.topAnchor.constraint(equalTo: scrollViewAreaOfSectionLabel.topAnchor, constant: 0),
            
            scrollViewSurfaceAreaPerMetre.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSurfaceAreaPerMetre.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSurfaceAreaPerTonne.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerMetre.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewSurfaceAreaPerTonne.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSurfaceAreaPerTonne.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionMassPerMetreLabel.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerTonne.topAnchor, constant: 0),
            
            scrollViewSectionMassPerMetreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionMassPerMetreLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewRatioForWebLocalBuckling.topAnchor.constraint(equalTo: scrollViewSurfaceAreaPerTonne.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewRatioForWebLocalBuckling.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewRatioForWebLocalBuckling.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewRatioForFlangeLocalBuckling.topAnchor.constraint(equalTo: scrollViewRatioForWebLocalBuckling.topAnchor, constant: 0),
            
            scrollViewRatioForFlangeLocalBuckling.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewRatioForFlangeLocalBuckling.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionDetailingDimensionsTitle.topAnchor.constraint(equalTo: scrollViewRatioForWebLocalBuckling.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
            
            scrollViewSectionDetailingDimensionsTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewMainTitleRightMarginFromScreenEdge),
            
            scrollViewSectionDetailingDimensionsTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
            
            scrollViewUniversalBeamDetailingDimensionsImage.topAnchor.constraint(equalTo: scrollViewSectionDetailingDimensionsTitle.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
            
            scrollViewUniversalBeamDetailingDimensionsImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            
            scrollViewUniversalBeamDetailingDimensionsImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            
            scrollViewEndClearanceDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewUniversalBeamDetailingDimensionsImage.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewEndClearanceDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewEndClearanceDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewNotchNdetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewEndClearanceDetailingDimensionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewNotchNdetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewNotchNdetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewNotchnDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewNotchNdetailingDimensionLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewNotchnDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewNotchnDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewSectionStructuralPropertiesTitle.topAnchor.constraint(equalTo: scrollViewNotchnDetailingDimensionLabel.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
            
            scrollViewSectionStructuralPropertiesTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMainTitleRightMarginFromScreenEdge),
            
            scrollViewSectionStructuralPropertiesTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewMainTitleLeftMarginFromScreenEdge),
            
            scrollViewAxisLabel.topAnchor.constraint(equalTo: scrollViewSectionStructuralPropertiesTitle.bottomAnchor, constant: scrollViewVerticalSpacingForLabelUnderneathMainTitles),
            
            scrollViewAxisLabel.centerXAnchor.constraint(greaterThanOrEqualTo: self.view.centerXAnchor, constant: ((self.view.frame.width - scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView - scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView)/4)),
            
            scrollViewMajorAxisLabel.topAnchor.constraint(equalTo: scrollViewAxisLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewMajorAxisLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
            
            scrollViewMajorAxisLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
            
            scrollViewMinorAxisLabel.centerYAnchor.constraint(equalTo: scrollViewMajorAxisLabel.centerYAnchor),
            
            scrollViewMinorAxisLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
            
            scrollViewMinorAxisLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
            
            scrollViewSecondMomentOfAreaLabel.topAnchor.constraint(equalTo: scrollViewMajorAxisLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewSecondMomentOfAreaLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            scrollViewSecondMomentOfAreaLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewMajorSecondMomentOfAreaValue.centerYAnchor.constraint(equalTo: scrollViewSecondMomentOfAreaLabel.centerYAnchor, constant: 0),
            
            scrollViewMajorSecondMomentOfAreaValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
            
            scrollViewMajorSecondMomentOfAreaValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
            
            scrollViewMinorSecondMomentOfAreaValue.centerYAnchor.constraint(equalTo: scrollViewMajorSecondMomentOfAreaValue.centerYAnchor),
            
            scrollViewMinorSecondMomentOfAreaValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
            
            scrollViewMinorSecondMomentOfAreaValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
            
            scrollViewRadiusOfGyrationLabel.topAnchor.constraint(equalTo: scrollViewSecondMomentOfAreaLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewRadiusOfGyrationLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            scrollViewRadiusOfGyrationLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewMajorRadiusOfGyrationValue.centerYAnchor.constraint(equalTo: scrollViewRadiusOfGyrationLabel.centerYAnchor, constant: 0),
            
            scrollViewMajorRadiusOfGyrationValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
            
            scrollViewMajorRadiusOfGyrationValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
            
            scrollViewMinorRadiusOfGyrationValue.centerYAnchor.constraint(equalTo: scrollViewMajorRadiusOfGyrationValue.centerYAnchor),
            
            scrollViewMinorRadiusOfGyrationValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
            
            scrollViewMinorRadiusOfGyrationValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
            
            scrollViewElasticModulusLabel.topAnchor.constraint(equalTo: scrollViewRadiusOfGyrationLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewElasticModulusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            scrollViewElasticModulusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewMajorElasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewElasticModulusLabel.centerYAnchor, constant: 0),
            
            scrollViewMajorElasticModulusValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
            
            scrollViewMajorElasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
            
            scrollViewMinorElasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewMajorElasticModulusValue.centerYAnchor),
            
            scrollViewMinorElasticModulusValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
            
            scrollViewMinorElasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
           
            scrollViewPlasticModulusLabel.topAnchor.constraint(equalTo: scrollViewElasticModulusLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewPlasticModulusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            scrollViewPlasticModulusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewMajorPlasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewPlasticModulusLabel.centerYAnchor, constant: 0),
            
            scrollViewMajorPlasticModulusValue.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMajorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewCenterX),
            
            scrollViewMajorPlasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewSectionStructuralPropertiesLabelsContainingValuesLeftMargin),
            
            scrollViewMinorPlasticModulusValue.centerYAnchor.constraint(equalTo: scrollViewMajorPlasticModulusValue.centerYAnchor),
            
            scrollViewMinorPlasticModulusValue.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesRightMarginFromMainViewRightAnchor),
            
            scrollViewMinorPlasticModulusValue.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: scrollViewMinorSectionStructuralPropertiesLabelsValuesLeftMarginFromMainViewCenterX),
            
            scrollViewBucklingParameter.topAnchor.constraint(equalTo: scrollViewPlasticModulusLabel.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewBucklingParameter.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewBucklingParameter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewTorsionalIndex.topAnchor.constraint(equalTo: scrollViewBucklingParameter.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewTorsionalIndex.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewTorsionalIndex.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWarpingConstant.topAnchor.constraint(equalTo: scrollViewTorsionalIndex.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewWarpingConstant.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewWarpingConstant.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewTorsionalConstant.topAnchor.constraint(equalTo: scrollViewWarpingConstant.bottomAnchor, constant: scrollViewSubLabelsVerticalSpacings),
            
            scrollViewTorsionalConstant.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * scrollViewSubLabelRightMarginFromScreenEdgeOrCenterOfView),
            
            scrollViewTorsionalConstant.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: scrollViewSubLabelLeftMarginFromScreenEdgeOrCenterOfView)
            
        ])
        
    }
    
}

// MARK: - UINavigationBarDelegate Extension:

extension BlueBookUniversalBeamDataSummaryVC: UINavigationBarDelegate {
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "BlueBookUniversalBeamsVC")
        
        if delegate != nil {
        
            delegate?.dataToBePassedUsingProtocol(modifiedArrayContainingAllUBsDataToBePassed: passedArrayFromPreviousViewControllerContainingAllDataRelatedToUbs, modifiedArrayContainingSectionSerialNumbersDataToBePassed: passedArrayFromPreviousViewControllerContainingDataRelatedToSectionSerialNumbersOnly, sortBy: self.sortBy, filtersApplied: self.filtersApplied, isSearching: self.isSearching)
            
        }
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

