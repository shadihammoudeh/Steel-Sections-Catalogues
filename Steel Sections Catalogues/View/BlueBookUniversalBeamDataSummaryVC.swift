//
//  BlueBookUniversalBeamDataSummaryVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamDataSummaryVC: UIViewController {
    
    // MARK: - Instance scope variables and constants declarations:
    
    // Below is the declaration of the CoreAnimationLayer that will be used later on to draw the universal beam section using UIBezier method inside a specific view:
    
    let universalBeamShapeLayer = CAShapeLayer()
    
    // Below is the declaration of the CoreAnimationLayer that will be used later on to draw the annotations on the drawn universal beam using UIBezier method inside a specific view:
    
    let depthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let widthOfSectionAnnotationShapeLayer = CAShapeLayer()
    
    let sectionWebThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let annotationDashedLinesShapeLayer = CAShapeLayer()
    
    // The below variables will get their values from BlueBookUniversalBeamsVC depending on the tableView cell the user has tapped on:
    
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
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Universal Beam Data", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048")
    
    // Below is the declaration of the view that we will draw the universal beam section inside:
    
    lazy var universalBeamDrawingView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .red
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("Universal Beam Flange Thickness is equal to \(selectedUniversalBeamFlangeThickness)")
        
        drawUniversalBeamPathAndItsAnnotations()
        
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamDrawingView)
        
        universalBeamDrawingView.layer.addSublayer(universalBeamShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(depthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(widthOfSectionAnnotationShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(annotationDashedLinesShapeLayer)
        
        universalBeamDrawingView.layer.addSublayer(sectionWebThicknessAnnotationShapeLayer)
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        setupSubViewsConstraints()
        
    }
    
    func drawUniversalBeamPathAndItsAnnotations() {
        
        // MARK: - Drawing the Universal Beam path:
        
        // Below are the drawingView margins definition:
        
        let drawingViewTopMargin: CGFloat = 55
        
        let drawingViewRightMargin: CGFloat = 10
        
        let drawingViewBottomMargin: CGFloat = 55
        
        let drawingViewLeftMargin: CGFloat = 10
        
        let universalBeamPathLineWidth: CGFloat = 2
        
        let universalBeamPathStrokeColour = UIColor.blue.cgColor
        
        let universalBeamPathFillColour = UIColor.clear.cgColor
        
        let horizontalDistanceBetweenDepthOfSectionBottomArrowHeadFirstPointAndBottomRightCornerOfSection: CGFloat = 15
        
        let verticalDistanceBetweenWidthOfSectionLeftSideArrowHeadFirstPointAndTopLeftCornerOfSection: CGFloat = 15
        
        let depthOfSectionAnnotationsPathsStrokeColour = UIColor.green.cgColor
        
        let depthOfSectionAnnotationsPathsFillColour = UIColor.clear.cgColor
        
        let depthOfSectionAnnotationsPathsLineWidth: CGFloat = 2
        
        // Below is the calculations needed to be crried out to obtain the appropriate scale to be applied to each universal beam section:
        
        let widthScale: CGFloat = (self.view.frame.size.width - drawingViewLeftMargin - drawingViewRightMargin) / selectedUniversalBeamWidthOfSection
        
        let depthScale: CGFloat = (self.view.frame.size.width - drawingViewTopMargin - drawingViewBottomMargin) / selectedUniversalBeamDepthOfSection
        
        let scaleToBeApplied = min(widthScale, depthScale)
        
        let dashedAnnotationLinesLengths: CGFloat = (horizontalDistanceBetweenDepthOfSectionBottomArrowHeadFirstPointAndBottomRightCornerOfSection + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) * 2
        
        // Below are the three UIBezierPath that we will be creating:
        
        let path = UIBezierPath()
        
        let mirroredPathOne = UIBezierPath()
        
        let mirroredPathTwo = UIBezierPath()
        
        let halfTheSectionPath = UIBezierPath()
        
        let fullSectionPath = UIBezierPath()
        
        let pathStartingXCoordinateFromOrigin: CGFloat = ((self.view.frame.size.width - drawingViewLeftMargin - drawingViewRightMargin) / 2) + drawingViewLeftMargin
        
        let pathStartingYCoordinateFromOrigin: CGFloat = drawingViewTopMargin
        
        path.move(to: CGPoint(x: pathStartingXCoordinateFromOrigin, y: pathStartingYCoordinateFromOrigin))
        
        path.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin), y: pathStartingYCoordinateFromOrigin))
        
        path.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin), y: ((selectedUniversalBeamFlangeThickness * scaleToBeApplied) + pathStartingYCoordinateFromOrigin)))
        
        path.addLine(to: CGPoint(x: ((((selectedUniversalBeamWebThickness/2) + selectedUniversalBeamRootRadius) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin), y: ((selectedUniversalBeamFlangeThickness * scaleToBeApplied) + pathStartingYCoordinateFromOrigin)))
        
        path.addArc(withCenter: CGPoint(x: ((((selectedUniversalBeamWebThickness/2) + (selectedUniversalBeamRootRadius)) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin), y: (((selectedUniversalBeamFlangeThickness + selectedUniversalBeamRootRadius) * scaleToBeApplied) + pathStartingYCoordinateFromOrigin)), radius: -1 * (selectedUniversalBeamRootRadius * scaleToBeApplied), startAngle: (CGFloat.pi)/2, endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: (((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin), y: (((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied) + pathStartingYCoordinateFromOrigin)))
        
        // Here we are carrying out the first reflection and translation process about the X-Axis in order to obtain half of the final path:
        
        let reflectionLineAboutXaxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let translationInYaxisAfterReflectionIsDone = CGAffineTransform(translationX: 0, y: (((selectedUniversalBeamDepthOfSection) * scaleToBeApplied) + (pathStartingYCoordinateFromOrigin * 2)))
        
        let requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess = reflectionLineAboutXaxis.concatenating(translationInYaxisAfterReflectionIsDone)
        
        mirroredPathOne.append(path)
        
        mirroredPathOne.apply(requiredCombinedReflectionAndTranslationForTheFirstMirroringProcess)
        
        halfTheSectionPath.append(path)
        
        halfTheSectionPath.append(mirroredPathOne)
        
        // Here we are carrying out the second reflection and translation process about the Y-Axis in order to obtain the full section path:
        
        let reflectionLineAboutYaxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let translationInXaxisAfterReflectionIsDone = CGAffineTransform(translationX: (pathStartingXCoordinateFromOrigin * 2), y: 0)
        
        let requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess = reflectionLineAboutYaxis.concatenating(translationInXaxisAfterReflectionIsDone)
        
        mirroredPathTwo.append(halfTheSectionPath)
        
        mirroredPathTwo.apply(requiredCombinedReflectionAndTranslationForTheSecondMirroringProcess)
        
        fullSectionPath.append(halfTheSectionPath)
        
        fullSectionPath.append(mirroredPathTwo)
        
        // Below we are drawing the fullSectionPath inside our view:
        
        universalBeamShapeLayer.path = fullSectionPath.cgPath
        
        universalBeamShapeLayer.strokeColor = universalBeamPathStrokeColour
        
        universalBeamShapeLayer.fillColor = universalBeamPathFillColour
        
        universalBeamShapeLayer.lineWidth = universalBeamPathLineWidth
        
        // MARK: - Drawing the annotation line for the depth of Section:
        
        let depthOfSectionHalfOfBottomArrowHeadPath = UIBezierPath()
        
        let depthOfSectionReflectedBottomArrowHeadHalfPath = UIBezierPath()
        
        let depthOfSectionHalfOfVerticalLinePath = UIBezierPath()
        
        let depthOfSectionBottomDashedLinePath = UIBezierPath()
        
        let depthOfSectionTopDashedLinePath = UIBezierPath()
        
        let dashedAnnotationLines = UIBezierPath()
        
        let depthOfSectionFullBottomHalfPath = UIBezierPath()
        
        let depthOfSectionReflectedFullBottomHalfPath = UIBezierPath()
        
        let depthOfSectionFullPath = UIBezierPath()
        
        let depthOfSectionBottomArrowHeadStartingXCoordinate: CGFloat = (self.view.frame.size.width/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + horizontalDistanceBetweenDepthOfSectionBottomArrowHeadFirstPointAndBottomRightCornerOfSection
        
        let depthOfSectionBottomArrowHeadStartingYCoordinate: CGFloat = drawingViewTopMargin + ((selectedUniversalBeamDepthOfSection - (selectedUniversalBeamFlangeThickness/2)) * scaleToBeApplied)
        
        depthOfSectionHalfOfBottomArrowHeadPath.move(to: CGPoint(x: depthOfSectionBottomArrowHeadStartingXCoordinate, y: depthOfSectionBottomArrowHeadStartingYCoordinate))
        
        depthOfSectionHalfOfBottomArrowHeadPath.addLine(to: CGPoint(x: depthOfSectionBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: depthOfSectionBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom half of the arrow head about the vertical y-axis:
        
        let depthOfSectionBottomArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let depthOfSectionReflectedBottomArrowHeadTranslation = CGAffineTransform(translationX: (depthOfSectionBottomArrowHeadStartingXCoordinate * 2) + (selectedUniversalBeamFlangeThickness * scaleToBeApplied), y: 0)
        
        let depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation = depthOfSectionBottomArrowHeadReflectionAxis.concatenating(depthOfSectionReflectedBottomArrowHeadTranslation)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.apply(depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation)
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionReflectedBottomArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the bottom vertical line half needed for the depth of section annotation:
        
        depthOfSectionHalfOfVerticalLinePath.move(to: CGPoint(x: depthOfSectionBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: depthOfSectionBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        depthOfSectionHalfOfVerticalLinePath.addLine(to: CGPoint(x: depthOfSectionBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: drawingViewTopMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfVerticalLinePath)
        
        // Below lines of codes are needed to draw the horziontal bottom and top dashed lines for the depth of section annotation:
        
        depthOfSectionBottomDashedLinePath.move(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + (universalBeamPathLineWidth/2), y: (drawingViewTopMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied))))
        
        depthOfSectionBottomDashedLinePath.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + dashedAnnotationLinesLengths, y: (drawingViewTopMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied))))
        
        depthOfSectionTopDashedLinePath.move(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + (universalBeamPathLineWidth/2), y: drawingViewTopMargin))
        
        depthOfSectionTopDashedLinePath.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + dashedAnnotationLinesLengths, y: drawingViewTopMargin))
        
        dashedAnnotationLines.append(depthOfSectionBottomDashedLinePath)
        
        dashedAnnotationLines.append(depthOfSectionTopDashedLinePath)
        
        // Below code lines are needed in order to reflect the bottom half of the Depth Of Section Annotation elements about the horziontal x-axis:
        
        let depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath = CGAffineTransform(scaleX: 1, y: -1)
        
        let depthOfSectionTranslationForTheReflectedFullBottomHalfPath = CGAffineTransform(translationX: 0, y: (drawingViewTopMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)) * 2)
        
        let requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath = depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath.concatenating(depthOfSectionTranslationForTheReflectedFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.append(depthOfSectionFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionReflectedFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionFullBottomHalfPath)
        
        depthOfSectionAnnotationShapeLayer.path = depthOfSectionFullPath.cgPath
        
        depthOfSectionAnnotationShapeLayer.strokeColor = depthOfSectionAnnotationsPathsStrokeColour
        
        depthOfSectionAnnotationShapeLayer.fillColor = depthOfSectionAnnotationsPathsFillColour
        
        depthOfSectionAnnotationShapeLayer.lineWidth = depthOfSectionAnnotationsPathsLineWidth
        
        // MARK: - Drawing the annotation line for the width of section:
        
        let widthOfSectionHalfOfTheLeftSideArrowHeadPath = UIBezierPath()
        
        let widthOfSectionReflectedLeftArrowHeadHalfPath = UIBezierPath()
        
        let widthOfSectionHalfOfHorizontalLinePath = UIBezierPath()
        
        let widthOfSectionLeftSideDashedLinePath = UIBezierPath()
        
        let widthOfSectionRightSideDashedLinePath = UIBezierPath()
        
        let widthOfSectionFullLeftSideHalfPath = UIBezierPath()
        
        let widthOfSectionReflectedFullLeftSideHalfPath = UIBezierPath()
        
        let widthOfSectionFullPath = UIBezierPath()
        
        let widthOfSectionLeftSideArrowHeadStartingXCoordinate: CGFloat = ((self.view.frame.size.width/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied)) + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)
        
        let widthOfSectionLeftSideArrowHeadStartingYCoordinate: CGFloat = drawingViewTopMargin - verticalDistanceBetweenWidthOfSectionLeftSideArrowHeadFirstPointAndTopLeftCornerOfSection
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.move(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate, y: widthOfSectionLeftSideArrowHeadStartingYCoordinate))
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.addLine(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        // Below code lines are needed to reflect the left hand side half of the arrow head about the horizontal x-axis:
        
        let widthOfSectionLeftHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let widthOfSectionReflectedLeftHandArrowHeadTranslation = CGAffineTransform(translationX: 0, y: (widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) * 2)
        
        let widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation = widthOfSectionLeftHandSideArrowHeadReflectionAxis.concatenating(widthOfSectionReflectedLeftHandArrowHeadTranslation)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.apply(widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation)
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionReflectedLeftArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the left hand side horizontal line half needed for the width of section annotation:
        
        widthOfSectionHalfOfHorizontalLinePath.move(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        widthOfSectionHalfOfHorizontalLinePath.addLine(to: CGPoint(x: (widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfHorizontalLinePath)
        
        // Below code lines are needed in order to reflect the left hand side half of the Width Of Section Annotation elements about the vertical y-axis:
        
        let widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath = CGAffineTransform(scaleX: -1, y: 1)
        
        let widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath = CGAffineTransform(translationX: ((widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied)) * 2, y: 0)
        
        let requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath = widthOfSectionVerticalReflectionLineForTheFullLeftHandSideHalfPath.concatenating(widthOfSectionTranslationForTheReflectedFullLeftHandSideHalfPath)
        
        widthOfSectionReflectedFullLeftSideHalfPath.append(widthOfSectionFullLeftSideHalfPath)
        
        widthOfSectionReflectedFullLeftSideHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullLeftHandSideHalfPath)
        
        widthOfSectionFullPath.append(widthOfSectionFullLeftSideHalfPath)
        
        widthOfSectionFullPath.append(widthOfSectionReflectedFullLeftSideHalfPath)
        
        // Below lines of codes are needed to draw the vertical left and right dashed lines for the width of section annotation:
        
        widthOfSectionLeftSideDashedLinePath.move(to: CGPoint(x: ((self.view.frame.size.width)/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: drawingViewTopMargin - (universalBeamPathLineWidth/2)))
        
        widthOfSectionLeftSideDashedLinePath.addLine(to: CGPoint(x: ((self.view.frame.size.width)/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: (drawingViewTopMargin - (universalBeamPathLineWidth/2)) - dashedAnnotationLinesLengths))
        
        widthOfSectionRightSideDashedLinePath.move(to: CGPoint(x: ((self.view.frame.size.width)/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: drawingViewTopMargin - (universalBeamPathLineWidth/2)))
        
        widthOfSectionRightSideDashedLinePath.addLine(to: CGPoint(x: ((self.view.frame.size.width)/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: (drawingViewTopMargin - (universalBeamPathLineWidth/2)) - dashedAnnotationLinesLengths))
        
        dashedAnnotationLines.append(widthOfSectionLeftSideDashedLinePath)
        
        dashedAnnotationLines.append(widthOfSectionRightSideDashedLinePath)
        
        // MARK: - Drawing the annotation line for the section web thickness:
        
        let sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessRightSideHorizontalLinePath = UIBezierPath()
        
        let sectionWebThicknessFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessReflectedFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessFullPath = UIBezierPath()
        
        let sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate: CGFloat = (self.view.frame.size.width/2) + ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + (universalBeamPathLineWidth/2)
        
        let sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate: CGFloat = drawingViewTopMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.move(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate, y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate))
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.addLine(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom right hand side arrow head about the horizontal axis:
        
        let sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation = CGAffineTransform(translationX: 0, y: (drawingViewTopMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)) * 2)
        
        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation = sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis.concatenating(sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation)
        
        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath.apply(sectionWebThicknessReflectedBottomRightHandSideArrowHeadCombinedReflectionAndTranslation)
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below lines of codes are needed to draw the right hand side horizontal line needed for the section web thickness annotation:
        
        sectionWebThicknessRightSideHorizontalLinePath.move(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate, y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate))
        
        sectionWebThicknessRightSideHorizontalLinePath.addLine(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate + (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied), y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate
        ))
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHorizontalLinePath)
        
        // Below code lines are needed to reflect the full right hand side section web thickness annotation about the vertical axis:
        
        let sectionWebThicknessFullRightHandSidePathReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation = CGAffineTransform(translationX: (((self.view.frame.size.width/2) + ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + (universalBeamPathLineWidth/2)) * 2) - (((universalBeamPathLineWidth * 2) + selectedUniversalBeamWebThickness * scaleToBeApplied)), y: 0)
        
        let sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation = sectionWebThicknessFullRightHandSidePathReflectionAxis.concatenating(sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation)
        
        sectionWebThicknessReflectedFullRightSidePath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessReflectedFullRightSidePath.apply(sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessReflectedFullRightSidePath)
        
        // Below we are drawing the fullSectionPath inside our view:
        
        widthOfSectionAnnotationShapeLayer.strokeColor = depthOfSectionAnnotationsPathsStrokeColour
        
        widthOfSectionAnnotationShapeLayer.fillColor = depthOfSectionAnnotationsPathsFillColour
        
        widthOfSectionAnnotationShapeLayer.lineWidth = depthOfSectionAnnotationsPathsLineWidth
        
        widthOfSectionAnnotationShapeLayer.path = widthOfSectionFullPath.cgPath
        
        annotationDashedLinesShapeLayer.path = dashedAnnotationLines.cgPath
        
        annotationDashedLinesShapeLayer.lineDashPattern =  [NSNumber(value: Float(dashedAnnotationLinesLengths/6)), NSNumber(value: Float((dashedAnnotationLinesLengths/6)/4))]
        
        annotationDashedLinesShapeLayer.strokeColor = depthOfSectionAnnotationsPathsStrokeColour
        
        annotationDashedLinesShapeLayer.fillColor = depthOfSectionAnnotationsPathsFillColour
        
        annotationDashedLinesShapeLayer.lineWidth = depthOfSectionAnnotationsPathsLineWidth
        
        sectionWebThicknessAnnotationShapeLayer.strokeColor = depthOfSectionAnnotationsPathsStrokeColour
        
        sectionWebThicknessAnnotationShapeLayer.fillColor = depthOfSectionAnnotationsPathsFillColour
        
        sectionWebThicknessAnnotationShapeLayer.lineWidth = depthOfSectionAnnotationsPathsLineWidth
        
        sectionWebThicknessAnnotationShapeLayer.path = sectionWebThicknessFullPath.cgPath
        
    }
    
    func setupSubViewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            universalBeamDrawingView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            universalBeamDrawingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            universalBeamDrawingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            universalBeamDrawingView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width)
            
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
