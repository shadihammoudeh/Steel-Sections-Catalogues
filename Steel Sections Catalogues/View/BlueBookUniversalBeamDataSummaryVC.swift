//
//  BlueBookUniversalBeamDataSummaryVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamDataSummaryVC: UIViewController {
    
    // MARK: - Univeral Beam properties passed from previous viewController, the below start at 0 and later on get their values from the previous View Controller:
    
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
    
    // MARK: - navigationBar instance declaration:
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Universal Beam Data", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048")
    
    // MARK: - CoreAnimation Layers Declaration that are needed to draw the universal beam section, as well as its annotations:
    
    let universalBeamShapeLayer = CAShapeLayer()
    
    let depthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let widthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let sectionWebThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionFlangeThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionRootRadiusAnnotationShapeLayer = CAShapeLayer()
    
    let dimensioningAnnotationDashedLinesShapeLayer = CAShapeLayer()
    
    let majorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    let minorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    let rootRadiusDimensioningAnnotationLineShapeLayer = CAShapeLayer()
    
    // MARK: - CoreAnimation Layers Declaration that are needed to draw the separation lines needed inside the UIScrollView:
    
    let verticalLineSeparatorBetweenSectionDimensionsLabels = CAShapeLayer()
    
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
    
    // MARK: - Font Size & Type for Dimensions Annotations Labels:
    
    let dimensionsAnnotationsLabelsFontSize: CGFloat = 11
    
    let dimensionsAnnotationsLabelsFontType: String = "American Typewriter"
    
    // MARK: - Universal Beam Section Stroke Path Colour and Line Width Declaration:
    
    let universalBeamProfilePathStrokeColour: String = "universalBeamProfilePathStrokeColour"
    
    let universalBeamShapeLayerPathLineWidth: CGFloat = 1.5
    
    // MARK: - Section Dimensioning Annotations Lines Stroke Path Colour and Line Width Declaration:
    
    let sectionDimensioningAnnotationsLinesPathStrokeColour: String = "sectionDimensioningAnnotationsLinesStrokePathColour"
    
    let sectionDimensioningAnnotationsLinesPathLineWidth: CGFloat = 1.0
    
    // MARK: - Section minor & major annoation axis UIBezier path Stroke Colour and Line Width:
    
    let minorSectionAnnotationLineStrokePathColour: String = "sectionMinorAndMajorAxisStrokePathColour"
    
    let majorSectionAnnotationLineStrokePathColour: String = "sectionMinorAndMajorAxisStrokePathColour"
    
    let majorAndMinorSectionAnnotationLinesPathLineWidth: CGFloat = 0.75
    
    // MARK: - Declaring section dimensions and properties inside UIScrollView margins and spacings:
    
    let sectionDimensionsAndPropertiesTitlesMarginFromScreenLeftEdge: CGFloat = 10
    
    let sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge: CGFloat = 20
    
    let sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide: CGFloat = 5
    
    let marginFromTopOfScrollView: CGFloat = 10
    
    let marginFromScreenRightEdge: CGFloat = 10
    
    let verticalSpacingBetweenLabels: CGFloat = 10
    
    // MARK: - Section drawing view and annotations labels declarations:
    
    lazy var universalBeamDrawingView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "sectionDrawingAreaBackgroundColour")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    lazy var universalBeamDepthOfSectionDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        label.text = "h = \(self.selectedUniversalBeamDepthOfSection) mm"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamWidthOfSectionDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "b = \(self.selectedUniversalBeamWidthOfSection) mm"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamSectionWebThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionWebThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tw = \(self.selectedUniversalBeamWebThickness) mm")
        
        universalBeamSectionWebThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionWebThicknessAttributtedString
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamSectionFlangeThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionFlangeThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tf = \(self.selectedUniversalBeamFlangeThickness) mm")
        
        universalBeamSectionFlangeThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionFlangeThicknessAttributtedString
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamMinorAxisBottomAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "y"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "majorAndMinorAxisLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamMinorAxisTopAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "y"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "majorAndMinorAxisLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamMajorAxisLeftAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "x"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "majorAndMinorAxisLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamMajorAxisRightAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "x"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: "majorAndMinorAxisLabelsFontColour")
        
        return label
        
    }()
    
    lazy var universalBeamRootRadiusAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.text = "r = \(self.selectedUniversalBeamRootRadius) mm"
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        return label
        
    }()
    
    // MARK: - Declaring section dimensions and properties UIScrollView:
    
    lazy var sectionDimensionsAndPropertiesScrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = UIColor(named: "sectionDimensionsAndPropertiesScrollViewBackgroundColour")
        
        return scrollView
        
    }()
    
    // MARK: - Section dimensions and geometric properties labels:
    
    lazy var scrollViewSectionDimensionsTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.text = "Section Dimensions:"
        
        return label
        
    }()
    
    lazy var scrollViewDepthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Depth, h [mm] = \(self.selectedUniversalBeamDepthOfSection)"
        
        return label
        
    }()
    
    lazy var scrollViewWidthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Width, b [mm] = \(self.selectedUniversalBeamWidthOfSection)"
        
        return label
        
    }()
    
    lazy var scrollViewFlangeThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        let universalBeamFlangeThicknessAttributedString:NSMutableAttributedString = NSMutableAttributedString(string: "Flange Thickness, tf [mm] = \(self.selectedUniversalBeamFlangeThickness)")
        
        universalBeamFlangeThicknessAttributedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 19, length: 1))
        
        label.attributedText = universalBeamFlangeThicknessAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewWebThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        let universalBeamWebThicknessAttributedString:NSMutableAttributedString = NSMutableAttributedString(string: "Web Thickness, tw [mm] = \(self.selectedUniversalBeamWebThickness)")
        
        universalBeamWebThicknessAttributedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 16, length: 1))
        
        label.attributedText = universalBeamWebThicknessAttributedString
        
        return label
        
    }()
    
    lazy var scrollViewSectionRootRadiusLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Root Radius, r [mm] = \(self.selectedUniversalBeamRootRadius)"
        
        return label
        
    }()
    
    lazy var scrollViewDepthOfSectionBetweenFilletsLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Depth between fillets, d [mm] = \(self.selectedUniversalBeamDepthBetweenFillets)"
        
        return label
        
    }()
    
    lazy var scrollViewAreaOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        let attributedAreaOfSectionString: NSMutableAttributedString = NSMutableAttributedString(string: "Area of Section, A [cm2] = \(self.selectedUniversalBeamAreaOfSection)")
        
        attributedAreaOfSectionString.setAttributes([.baselineOffset: 5.5], range: NSRange(location: 22, length: 1))
        
        label.attributedText = attributedAreaOfSectionString
        
        return label
        
    }()
    
    lazy var scrollViewSerctionMassPerMetreLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Mass per metre [kg/m] = \(self.selectedUniversalBeamMassPerMetre)"
        
        return label
        
    }()
    
    lazy var scrollViewSectionDetailingDimensionsTitle: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.text = "Section Detailing Dimensions:"
        
        return label
        
    }()
    
    lazy var scrollViewEndClearanceDetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.text = "End clearance, C [mm] = \(self.selectedUniversalBeamEndClearanceDetailingDimension)"
        
        return label
        
    }()
    
    lazy var scrollViewNotchNdetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Notch, N [mm] = \(self.selectedUniversalBeamNotchNdetailingDimension)"
        
        return label
        
    }()
    
    lazy var scrollViewNotchnDetailingDimensionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(named: "sectionDimensionAnnotationLabelsFontColour")
        
        label.numberOfLines = 0
        
        label.text = "Notch, n [mm] = \(self.selectedUniversalBeamNotchnDetailingDimension)"
        
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
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        drawUniversalBeamPathAndItsAnnotations()
        
        // MARK: - Adding SubViews to the main View Controller:
        
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamDrawingView)
        
        // MARK: - Adding SubViews to universalBeamDrawingView:
        
        universalBeamDrawingView.layer.addSublayer(universalBeamShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(depthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(widthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(dimensioningAnnotationDashedLinesShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionWebThicknessAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionFlangeThicknessAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionRootRadiusAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(majorAxisDashedAnnotationLineShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(minorAxisDashedAnnotationLineShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(rootRadiusDimensioningAnnotationLineShapeLayer)
        
        universalBeamDrawingView.addSubview(universalBeamDepthOfSectionDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamWidthOfSectionDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamSectionWebThicknessDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamSectionFlangeThicknessDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisTopAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisBottomAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMajorAxisRightAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMajorAxisLeftAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamRootRadiusAnnotationLabel)
        
        view.addSubview(sectionDimensionsAndPropertiesScrollView)
        
        sectionDimensionsAndPropertiesScrollView.layer.addSublayer(verticalLineSeparatorBetweenSectionDimensionsLabels)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDimensionsTitle)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWidthOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewFlangeThicknessLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewWebThicknessLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionRootRadiusLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewDepthOfSectionBetweenFilletsLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewAreaOfSectionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSerctionMassPerMetreLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewSectionDetailingDimensionsTitle)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewEndClearanceDetailingDimensionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewUniversalBeamDetailingDimensionsImage)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchNdetailingDimensionLabel)
        
        sectionDimensionsAndPropertiesScrollView.addSubview(scrollViewNotchnDetailingDimensionLabel)
        
    }
    
    // MARK: - viewWillLayoutSubviews():
    
    override func viewWillLayoutSubviews() {
        
        // MARK: - Assigning needed constraints:
        
        setupSubViewsConstraints()
        
        drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel()
        
        // MARK: - Defining sectionDimensionsAndPropertiesScrollView contentSize:
        
        sectionDimensionsAndPropertiesScrollView.contentSize = CGSize(width: view.frame.size.width, height: 1500)
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - Function declaration for drawing universal beam section as well as its dimensioning and annotations lines:
    
    func drawUniversalBeamPathAndItsAnnotations() {
        
        // MARK: - Set of common distances:
        
        let minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges: CGFloat = 10
        
        let sectionFlangeOrWebThicknessOrRootRadiusDimensioningAnnotationVerticalOrHorizontalOrInclinedLineLength: CGFloat = 20
        
        let distanceAboveUniversalBeamMajorAxisAnnotationDashedLineToSectionWebThicknessHorizontalDimensioningAnnotationLines: CGFloat = -35
        
        let distanceToTheLeftHandSideOfTheUniversalBeamMinorAxisAnnotationDashedLineToSectionFlangeThicknessVerticalDimensioningAnnotationLines: CGFloat = 30
        
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
        
        let triangleSidesLengthsOfDimensioningArrowHeadAnnotationSymbol: CGFloat = (selectedUniversalBeamFlangeThickness * scaleToBeApplied)/2
        
        // MARK: - Set of points that define the quarter of the universal beam profile section contained in the +ve x and +ve y quadrant:
        
        let universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: self.view.frame.width/2 , y: drawingViewTopAndBottomMargin)
        
        let universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
        
        let universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: (universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (selectedUniversalBeamFlangeThickness * scaleToBeApplied))
        
        let universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) + ((selectedUniversalBeamWebThickness * scaleToBeApplied)/2) + (selectedUniversalBeamRootRadius * scaleToBeApplied), y: (universalBeamSectionOutlineTopEdgeMinusFlangeThicknessPointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + (selectedUniversalBeamRootRadius * scaleToBeApplied))
        
        let universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant: (x: CGFloat, y: CGFloat) = (x: (universalBeamSectionOutlineRootRadiusCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x) - (selectedUniversalBeamRootRadius * scaleToBeApplied), y: (universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y) + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied))
        
        let topOfDepthOfSectionVerticalDimensioningAnnotationLinePointCoordinates: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + (universalBeamShapeLayerPathLineWidth/2) + (depthOfSectionHorizontalDashedDimensioningAnnotationLinesLengths/2),y: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.y)
        
        let leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes: (x: CGFloat, y: CGFloat) = (x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied),y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - universalBeamShapeLayerPathLineWidth/2 - (widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/2))
        
        // MARK: - Declaring the various paths stroke colours:
        
        let universalBeamPathStrokeColour = UIColor(named: universalBeamProfilePathStrokeColour)!.cgColor
        
        let dimensioningAnnotationLinesPathStrokeColour = UIColor(named: sectionDimensioningAnnotationsLinesPathStrokeColour)!.cgColor
        
        let sectionMinorAxisAnnotationDashedLinePathStrokeColour = UIColor(named: minorSectionAnnotationLineStrokePathColour)!.cgColor
        
        let sectionMajorAxisAnnotationDashedLinePathStrokeColour = UIColor(named: majorSectionAnnotationLineStrokePathColour)!.cgColor
        
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
        
        widthOfSectionAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        widthOfSectionAnnotationShapeLayer.lineWidth = sectionDimensioningAnnotationsLinesPathLineWidth
        
        // MARK: - Defining Universal Beam Section Major & Minor Axis Annotation UIBezierPath:
        
        let minorSectionAxisDashedLine = UIBezierPath()
        
        let majorSectionAxisDashedLine = UIBezierPath()
        
        sectionMinorAnnotationVerticalLineTopYcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMinorAnnotationVerticalLineBottomYcoordinate = universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMajorAnnotationHorizontalLineLeftXcoordinate = leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        sectionMajorAnnotationHorizontalLineRightXcoordinate = universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges
        
        majorSectionAxisDashedLine.move(to: CGPoint(x: leftOfWidthOfSectionHorizontalDimensioningAnnotationLinePointCoordiantes.x - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        majorSectionAxisDashedLine.addLine(to: CGPoint(x: universalBeamSectionOutlineTopEdgePointCoordinatesInsideThePositiveXandPositiveYquadrant.x + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges, y: universalBeamSectionOutlineDepthCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y))
        
        minorSectionAxisDashedLine.move(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y - minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
        
        minorSectionAxisDashedLine.addLine(to: CGPoint(x: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.x, y: universalBeamSectionOutlineTopCentrePointCoordinatesInsideThePositiveXandPositiveYquadrant.y + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges))
        
        // MARK: - Assigning Universal Beam Section Major & Minor Axis Annotation UIBezierPath Properties:
        
        majorAxisDashedAnnotationLineShapeLayer.path = majorSectionAxisDashedLine.cgPath
        
        majorAxisDashedAnnotationLineShapeLayer.lineWidth = majorAndMinorSectionAnnotationLinesPathLineWidth
        
        majorAxisDashedAnnotationLineShapeLayer.strokeColor = sectionMajorAxisAnnotationDashedLinePathStrokeColour
        
        majorAxisDashedAnnotationLineShapeLayer.lineDashPattern = [10, 2]
        
        minorAxisDashedAnnotationLineShapeLayer.path = minorSectionAxisDashedLine.cgPath
        
        minorAxisDashedAnnotationLineShapeLayer.lineWidth = majorAndMinorSectionAnnotationLinesPathLineWidth
        
        minorAxisDashedAnnotationLineShapeLayer.strokeColor = sectionMinorAxisAnnotationDashedLinePathStrokeColour
        
        minorAxisDashedAnnotationLineShapeLayer.lineDashPattern = [10, 2]
        
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
        
        depthOfSectionAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        depthOfSectionAnnotationShapeLayer.lineWidth = sectionDimensioningAnnotationsLinesPathLineWidth
        
        // MARK: - Assinging Universal Beam Depth & Width of Section Dashed Dimensioning Annotation UIBezierPath Properties:
        
        dimensioningAnnotationDashedLinesShapeLayer.path = dashedAnnotationLines.cgPath
        
        dimensioningAnnotationDashedLinesShapeLayer.lineDashPattern =  [NSNumber(value: Float(widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)), NSNumber(value: Float((widthOfSectionVerticalDashedDimensioningAnnotationLinesLengths/6)/4))]
        
        dimensioningAnnotationDashedLinesShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        dimensioningAnnotationDashedLinesShapeLayer.lineWidth = universalBeamShapeLayerPathLineWidth
        
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
        
        sectionWebThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        sectionWebThicknessAnnotationShapeLayer.lineWidth = sectionDimensioningAnnotationsLinesPathLineWidth
        
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
        
        sectionFlangeThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        sectionFlangeThicknessAnnotationShapeLayer.lineWidth = universalBeamShapeLayerPathLineWidth
        
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
        
        rootRadiusDimensioningAnnotationLineShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        rootRadiusDimensioningAnnotationLineShapeLayer.fillColor = UIColor.clear.cgColor
        
        rootRadiusDimensioningAnnotationLineShapeLayer.lineWidth = sectionDimensioningAnnotationsLinesPathLineWidth
        
    }
    
    // MARK: - Function declaration to draw vertical separation lines inside scrollView:
    
    func drawingVerticalAndHorizontalSeparatorsLinesForSectionDimensionsAndPropertiesLabel() {
        
        let verticalSeparatorLinePathBetweenSectionDimensionsLabels = UIBezierPath()
        
        let scrollViewAreaOfSectionLabelCoordinatesInRelationToItsScrollView = scrollViewAreaOfSectionLabel.convert(scrollViewAreaOfSectionLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        let scrollViewEndClearanceDetailingDimensionLabelCoordinatesInRelationToItsScrollView = scrollViewEndClearanceDetailingDimensionLabel.convert(scrollViewEndClearanceDetailingDimensionLabel.bounds.origin, to: sectionDimensionsAndPropertiesScrollView)
        
        verticalSeparatorLinePathBetweenSectionDimensionsLabels.move(to: CGPoint(x: self.view.frame.width/2, y: marginFromTopOfScrollView + scrollViewSectionDimensionsTitle.intrinsicContentSize.height))
        
        
        verticalSeparatorLinePathBetweenSectionDimensionsLabels.addLine(to: CGPoint(x: self.view.frame.width/2, y: scrollViewAreaOfSectionLabelCoordinatesInRelationToItsScrollView.y + max(scrollViewAreaOfSectionLabel.intrinsicContentSize.height, scrollViewSerctionMassPerMetreLabel.intrinsicContentSize.height)))
        
        verticalSeparatorLinePathBetweenSectionDimensionsLabels.move(to: CGPoint(x: self.view.frame.width/2, y: scrollViewEndClearanceDetailingDimensionLabelCoordinatesInRelationToItsScrollView.y))
        
        verticalSeparatorLinePathBetweenSectionDimensionsLabels.addLine(to: CGPoint(x: self.view.frame.width/2, y: 500))
        
        verticalLineSeparatorBetweenSectionDimensionsLabels.path = verticalSeparatorLinePathBetweenSectionDimensionsLabels.cgPath
        
        verticalLineSeparatorBetweenSectionDimensionsLabels.strokeColor = UIColor.black.cgColor
        
        verticalLineSeparatorBetweenSectionDimensionsLabels.lineWidth = 2
        
    }
    
    // MARK: - Declaring constraints:
    
    func setupSubViewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            universalBeamDrawingView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            universalBeamDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            universalBeamDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            universalBeamDrawingView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width),
            
            universalBeamDepthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate),
            
            universalBeamDepthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: depthOfSectionDimensioningAnnotationLineXcoordinate - (universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.width/2) + (universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.height/2)),
            
            universalBeamWidthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: widthOfSectionDimensioningAnnotationLineYcoordinate - (universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.height)),
            
            universalBeamWidthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - (universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.width/2)),
            
            universalBeamSectionWebThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate - universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.height),
            
            universalBeamSectionWebThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate - (universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.width)),
            
            universalBeamSectionFlangeThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.height),
            
            universalBeamSectionFlangeThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.width),
            
            universalBeamMinorAxisTopAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineTopYcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.height),
            
            universalBeamMinorAxisTopAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMinorAxisBottomAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineBottomYcoordinate),
            
            universalBeamMinorAxisBottomAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisBottomAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineLeftXcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.width),
            
            universalBeamMajorAxisRightAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisRightAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisRightAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineRightXcoordinate),
            
            universalBeamRootRadiusAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: universalBeamSectionRootRadiusInclinedDimensioningLineStartingXCoordinate - universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.width/2 + universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamRootRadiusAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: universalBeamSectionRootRadiusInclinedDimensioningLineStartingYCoordinate + universalBeamRootRadiusAnnotationLabel.intrinsicContentSize.width/2),
            
            sectionDimensionsAndPropertiesScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            
            sectionDimensionsAndPropertiesScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
            sectionDimensionsAndPropertiesScrollView.topAnchor.constraint(equalTo: universalBeamDrawingView.bottomAnchor),
            
            sectionDimensionsAndPropertiesScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            scrollViewSectionDimensionsTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesTitlesMarginFromScreenLeftEdge),
            
            scrollViewSectionDimensionsTitle.topAnchor.constraint(equalTo: sectionDimensionsAndPropertiesScrollView.topAnchor, constant: marginFromTopOfScrollView),
            
            scrollViewDepthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            scrollViewDepthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewDepthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewSectionDimensionsTitle.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewWidthOfSectionLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            
            
            scrollViewWidthOfSectionLabel.topAnchor.constraint(equalTo: scrollViewSectionDimensionsTitle.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewWidthOfSectionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewFlangeThicknessLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            scrollViewFlangeThicknessLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewFlangeThicknessLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewWebThicknessLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewWebThicknessLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewWebThicknessLabel.topAnchor.constraint(equalTo: scrollViewDepthOfSectionLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewSectionRootRadiusLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            scrollViewSectionRootRadiusLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewSectionRootRadiusLabel.topAnchor.constraint(equalTo: scrollViewFlangeThicknessLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewDepthOfSectionBetweenFilletsLabel.topAnchor.constraint(greaterThanOrEqualTo: scrollViewFlangeThicknessLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewAreaOfSectionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            scrollViewAreaOfSectionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewAreaOfSectionLabel.topAnchor.constraint(equalTo: scrollViewSectionRootRadiusLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewSerctionMassPerMetreLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewSerctionMassPerMetreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewSerctionMassPerMetreLabel.topAnchor.constraint(equalTo: scrollViewSectionRootRadiusLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewSectionDetailingDimensionsTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesTitlesMarginFromScreenLeftEdge),
            
            scrollViewSectionDetailingDimensionsTitle.topAnchor.constraint(equalTo: scrollViewAreaOfSectionLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewEndClearanceDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            scrollViewEndClearanceDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewEndClearanceDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewSectionDetailingDimensionsTitle.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewNotchNdetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewEndClearanceDetailingDimensionLabel.topAnchor, constant: 0),
            
            scrollViewNotchNdetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            
            scrollViewNotchNdetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewNotchnDetailingDimensionLabel.topAnchor.constraint(equalTo: scrollViewEndClearanceDetailingDimensionLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewNotchnDetailingDimensionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
            
            scrollViewNotchnDetailingDimensionLabel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -1 * sectionDimensionsLabelsMarginsFromVerticalSeparatorLineLeftAndRightSide),
            
            scrollViewUniversalBeamDetailingDimensionsImage.topAnchor.constraint(equalTo: scrollViewNotchnDetailingDimensionLabel.bottomAnchor, constant: verticalSpacingBetweenLabels),
            
            scrollViewUniversalBeamDetailingDimensionsImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1 * marginFromScreenRightEdge),
            
            scrollViewUniversalBeamDetailingDimensionsImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: sectionDimensionsAndPropertiesLabelsMarginFromScreenLeftEdge),
            
        ])
        
    }
    
}

// MARK: - UINavigationBarDelegate Extension:

extension BlueBookUniversalBeamDataSummaryVC: UINavigationBarDelegate {
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "BlueBookUniversalBeamsVC")
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}
