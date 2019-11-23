//
//  BlueBookUniversalBeamDataSummaryVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamDataSummaryVC: UIViewController {
    
    // MARK: - univeralBeam properties passed from previous viewController:
    
    var selectedUniversalBeamMassPerMetre: Double = 0
    
    var selectedUniversalBeamDepthOfSection: CGFloat = 0
    
    var selectedUniversalBeamWidthOfSection: CGFloat = 0
    
    var selectedUniversalBeamWebThickness: CGFloat = 0
    
    var selectedUniversalBeamFlangeThickness: CGFloat = 0
    
    var selectedUniversalBeamRootRadius: CGFloat = 0
    
    let selectedUniversalBeamDepthBetweenFillets: Double = 0
    
    let selectedUniversalBeamSecondMomentOfAreaAboutMajorAxis: Double = 0
    
    let selectedUniversalBeamSecondMomentOfAreaAboutMinorAxis: Double = 0
    
    let selectedUniversalBeamRadiusOfGyrationAboutMajorAxis: Double = 0
    
    let selectedUniversalBeamRadiusOfGyrationAboutMinorAxis: Double = 0
    
    let selectedUniversalBeamElasticModulusAboutMajorAxis: Double = 0
    
    let selectedUniversalBeamElasticModulusAboutMinorAxis: Double = 0
    
    // MARK: - navigationBar instance declaration:
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Universal Beam Data", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048")
    
    // MARK: - CoreAnimation Layers Declaration:
    
    let universalBeamShapeLayer = CAShapeLayer()
    
    let depthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let widthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let sectionWebThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionFlangeThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionRootRadiusAnnotationShapeLayer = CAShapeLayer()
    
    let dimensioningAnnotationDashedLinesShapeLayer = CAShapeLayer()
    
    let majorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    let minorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    // MARK: - depthOfSection Vertical Annotation Line X & Mid Y Coordinates:
    
    var depthOfSectionDimensioningAnnotationLineXcoordinate: CGFloat = 0
        
    var depthOfSectionAnnotationLineMidYcoordinate: CGFloat = 0
        
    // MARK: - widthOfSection Horizontal Annotation Line  Y & Mid X Coordinates Coordinate:
    
    var widthOfSectionAnnotationLineMidXcoordinate: CGFloat = 0
    
    var widthOfSectionDimensioningAnnotationLineYcoordinate: CGFloat = 0
    
    // MARK: - sectionWebThickness Left hand side Horizontal Annotation Line starting X & Y coordinate Declaration:
    
    var sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate: CGFloat = 0
    
    var sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate: CGFloat = 0
        
    // MARK: - sectionFlangeThickness Top Vertical Annotation Line Starting X & Y Coordinates Declaration:
    
    var sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate: CGFloat = 0
        
    var sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate: CGFloat = 0
    
    // MARK: - sectionMinor Vertical Annotation Line X & Y Coordinates Declaration:
    
    var sectionMinorAnnotationVerticalLineTopYcoordinate: CGFloat = 0
    
    var sectionMinorAnnotationVerticalLineBottomYcoordinate: CGFloat = 0
            
    // MARK: - sectionMajor Horizontal Annotation Line X & Y Coordinates Declaration:
    
    var sectionMajorAnnotationHorizontalLineLeftXcoordinate: CGFloat = 0
    
    var sectionMajorAnnotationHorizontalLineRightXcoordinate: CGFloat = 0
        
    // MARK: - section dimensions labels and annotations distances:
    
    let distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    let distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    // MARK: - Font Size & Type for Dimensions Annotations Labels:
    
    let dimensionsAnnotationsLabelsFontSize: CGFloat = 13
    
    let dimensionsAnnotationsLabelsFontType: String = "American Typewriter"
            
    // MARK: - Universal Beam Section Stroke Path Colour and Line Width Declaration:
    
    let sectionPathStrokeAndDimensioningLabelsColour: String = "sectionStrokePathAndDimensioningLabelsColour"
    
    let universalBeamShapeLayerPathLineWidth: CGFloat = 1.5
    
    // MARK: - Section Dimensioning Annotations Lines Stroke Path Colour and Line Width Declaration:
    
    let sectionDimensioningAnnotationsLinesPathStrokeColour: String = "sectionDimensioningAnnotationsLinesStrokePathColour"
    
    let sectionDimensioningAnnotationsLinesPathLineWidth: CGFloat = 1.0
    
    // MARK: - Section minor & major annoation axis UIBezier path Stroke Colour and Line Width:
    
    let minorSectionAnnotationLineStrokePathColour: String = "sectionMinorAndMajorAxisStrokePathColour"
    
    let majorSectionAnnotationLineStrokePathColour: String = "sectionMinorAndMajorAxisStrokePathColour"
    
    let majorAndMinorSectionAnnotationLinesPathLineWidth: CGFloat = 0.75
    
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
        
        label.textColor = UIColor(named: sectionPathStrokeAndDimensioningLabelsColour)
        
        return label
        
    }()
    
    lazy var universalBeamWidthOfSectionDimensionLabel: UILabel = {
        
        var label = UILabel()
                        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "b = \(self.selectedUniversalBeamWidthOfSection) mm"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: sectionPathStrokeAndDimensioningLabelsColour)
        
        return label
        
    }()
    
    lazy var universalBeamSectionWebThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
                        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionWebThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tw = \(self.selectedUniversalBeamWebThickness) mm")
        
        universalBeamSectionWebThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionWebThicknessAttributtedString
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: sectionPathStrokeAndDimensioningLabelsColour)

        return label
        
    }()
    
    lazy var universalBeamSectionFlangeThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
                        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionFlangeThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tf = \(self.selectedUniversalBeamFlangeThickness) mm")
        
        universalBeamSectionFlangeThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionFlangeThicknessAttributtedString
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        label.textColor = UIColor(named: sectionPathStrokeAndDimensioningLabelsColour)
        
        return label
        
    }()
    
    lazy var universalBeamMinorAxisBottomAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "y"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        return label
        
    }()
    
    lazy var universalBeamMinorAxisTopAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "y"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        return label
        
    }()
    
    lazy var universalBeamMajorAxisLeftAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "x"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        return label
        
    }()
    
    lazy var universalBeamMajorAxisRightAnnotationLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.baselineAdjustment = .alignCenters
        
        label.text = "x"
        
        label.font = UIFont(name: dimensionsAnnotationsLabelsFontType, size: dimensionsAnnotationsLabelsFontSize)
        
        return label
        
    }()
    
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
        
        universalBeamDrawingView.addSubview(universalBeamDepthOfSectionDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamWidthOfSectionDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamSectionWebThicknessDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamSectionFlangeThicknessDimensionLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisTopAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMinorAxisBottomAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMajorAxisRightAnnotationLabel)
        
        universalBeamDrawingView.addSubview(universalBeamMajorAxisLeftAnnotationLabel)
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // MARK: - Assigning needed constraints:
        
        setupSubViewsConstraints()
        
    }
    
    func drawUniversalBeamPathAndItsAnnotations() {
        
        // MARK: - Set of common distances:
        
        let minorAndMajorUniversalBeamDashedAnnotationLinesExtensionLengthFromProfileOutlineEdges: CGFloat = 15
        
        let distanceFromMajorOrMinorUniversalBeamAnnotationLabelsToDepthOrWidthOfSectionDimensioningAnnotationLine: CGFloat = 10
        
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
                
        let universalBeamPathStrokeColour = UIColor(named: sectionPathStrokeAndDimensioningLabelsColour)!.cgColor
        
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
//        let sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate: CGFloat = (self.view.frame.size.width/2) + ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)
//
//        let sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate: CGFloat = drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection/4) * scaleToBeApplied)
//
//        sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate = (self.view.frame.size.width/2) - ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) - (universalBeamShapeLayerPathLineWidth/2) - (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
//
//        sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate = sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate
//        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.move(to: CGPoint(x: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate, y: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate))
//
//        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.addLine(to: CGPoint(x: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom right hand side arrow head about the horizontal axis:
        
//        let sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
//
//        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation = CGAffineTransform(translationX: 0, y: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate * 2)
//
//        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation = sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis.concatenating(sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation)
//
//        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
//
//        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.apply(sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation)
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below lines of codes are needed to draw the right hand side horizontal line needed for the section web thickness annotation:
        
//        sectionWebThicknessRightSideHorizontalLinePath.move(to: CGPoint(x: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate, y: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate))
//
//        sectionWebThicknessRightSideHorizontalLinePath.addLine(to: CGPoint(x: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate + (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied), y: sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadStartingCentreYCoordinate))
//
//        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHorizontalLinePath)
        
        // Below code lines are needed to reflect the full right hand side section web thickness annotation about the vertical axis:
        
//        let sectionWebThicknessFullRightHandSidePathReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
//
//        let sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation = CGAffineTransform(translationX: (sectionWebThicknessRightSideDimensioningAnnotationBottomArrowHeadCentreStartingXCoordinate * 2) - (selectedUniversalBeamWebThickness * scaleToBeApplied) - universalBeamShapeLayerPathLineWidth, y: 0)
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
        
        // MARK: - Assinging Universal Beam Section Web Thickness Dimensioning Annotation UIBezierPath Properties:

//        sectionWebThicknessAnnotationShapeLayer.path = sectionWebThicknessFullPath.cgPath
//
//        sectionWebThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
//
//        sectionWebThicknessAnnotationShapeLayer.lineWidth = sectionDimensioningAnnotationsLinesPathLineWidth
        
        // MARK: - Defining Universal Beam Section Flange Thickness Dimensioning Annotation UIBezierPath:

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
//        let sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate: CGFloat = ((self.view.frame.size.width/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied)) + (selectedUniversalBeamFlangeThickness * scaleToBeApplied)
//
//        let sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate: CGFloat = drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + universalBeamShapeLayerPathLineWidth/2
//
//        sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate = sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate
//
//        sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate = drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied) - universalBeamShapeLayerPathLineWidth/2 - (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
//
//        sectionFlangeThicknessBottomSideHalfArrowHeadPath.move(to: CGPoint(x: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate, y: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate))
//
//        sectionFlangeThicknessBottomSideHalfArrowHeadPath.addLine(to: CGPoint(x: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
//
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom half arrow head about the vertical axis:
//
//        let sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
//
//        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation = CGAffineTransform(translationX: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate * 2, y: 0)
//
//        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation = sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis.concatenating(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation)
//
//        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
//
//        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.apply(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation)
//
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath)
//
        // Below lines of codes are needed to draw the bottom hand side vertical line needed for the section flange thickness annotation:
        
//        sectionFlangeThicknessBottomSideVerticalLinePath.move(to: CGPoint(x: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate, y: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate))
//
//        sectionFlangeThicknessBottomSideVerticalLinePath.addLine(to: CGPoint(x: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingXCoordinate, y: sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate + (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
//        ))
        
//        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideVerticalLinePath)
//
        // Below code lines are needed to reflect the full bottom section flange thickness annotation about the horizontal axis:
        
//        let sectionFlangeThicknessFullBottomHandSidePathReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
//
//        let sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation = CGAffineTransform(translationX: 0, y: (sectionFlangeThicknessDimensioningAnnotationBottomSideHalfArrowHeadCentreStartingYCoordinate * 2) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied) - universalBeamShapeLayerPathLineWidth)
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
        
        // MARK: - Assinging Universal Beam Section Flange Thickness Dimensioning Annotation UIBezierPath Properties:

//        sectionFlangeThicknessAnnotationShapeLayer.path = sectionFlangeThicknessFullPath.cgPath
//
//        sectionFlangeThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
//
//        sectionFlangeThicknessAnnotationShapeLayer.lineWidth = universalBeamShapeLayerPathLineWidth
    
    }
    
    func setupSubViewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            universalBeamDrawingView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            universalBeamDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            universalBeamDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            universalBeamDrawingView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width),
            
            universalBeamDepthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.height/2),
            
            universalBeamDepthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: depthOfSectionDimensioningAnnotationLineXcoordinate +  distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel - universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.width/2 + universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.height/2),
            
            universalBeamWidthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: widthOfSectionDimensioningAnnotationLineYcoordinate - distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel - universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.height),
            
            universalBeamWidthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.width/2),
            
            universalBeamSectionWebThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionWebThicknessDimensioningAnnotationHorizontalLineYcoordinate - universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.height/2),
            
            universalBeamSectionWebThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate - universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.width),
            
            universalBeamSectionFlangeThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.height),
            
            universalBeamSectionFlangeThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionFlangeThicknessDimensioningAnnotationLabelVerticalLineXcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.width),
            
            universalBeamMinorAxisTopAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineTopYcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.height),
            
            universalBeamMinorAxisTopAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMinorAxisBottomAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineBottomYcoordinate),
            
            universalBeamMinorAxisBottomAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamMinorAxisBottomAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineLeftXcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.width),
            
            universalBeamMajorAxisRightAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: depthOfSectionAnnotationLineMidYcoordinate - universalBeamMajorAxisRightAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisRightAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineRightXcoordinate)
            
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
