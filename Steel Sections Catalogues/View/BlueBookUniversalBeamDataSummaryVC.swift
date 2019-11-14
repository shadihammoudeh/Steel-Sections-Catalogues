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
    
    let sectionFlangeThicknessAnnotationShapeLayer = CAShapeLayer()
    
    let sectionRootRadiusAnnotationShapeLayer = CAShapeLayer()
    
    let dimensioningAnnotationDashedLinesShapeLayer = CAShapeLayer()
    
    let majorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    let minorAxisDashedAnnotationLineShapeLayer = CAShapeLayer()
    
    var depthOfSectionAnnotationLineXcoordinate: CGFloat = 0
    
    var depthOfSectionAnnotationLineMidYcoordinate: CGFloat = 0
    
    var widthOfSectionAnnotationLineMidXcoordinate: CGFloat = 0
    
    var widthOfSectionAnnotationLineYcoordinate: CGFloat = 0
    
    var sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate: CGFloat = 0
            
    var sectionWebThicknessAnnotationLineYcoordinate: CGFloat = 0
    
    var sectionFlangeThicknessTopVerticalAnnotationLineStartingXcoordinate: CGFloat = 0
            
    var sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate: CGFloat = 0
    
    var sectionMinorAnnotationVerticalLineTopYcoordinate: CGFloat = 0
    
    var sectionMinorAnnotationVerticalLineBottomYcoordinate: CGFloat = 0

    var sectionMinorAnnotationVerticalLineXcoordinate: CGFloat = 0
    
    var sectionMajorAnnotationHorizontalLineLeftXcoordinate: CGFloat = 0
    
    var sectionMajorAnnotationHorizontalLineRightXcoordinate: CGFloat = 0

    var sectionMajorAnnotationHorizontalLineYcoordinate: CGFloat = 0
    
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
    
    let distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    let distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel: CGFloat = 0
    
    let distanceBetweenSectionWebThicknessDimensionAnnotationLineAndItsLabel: CGFloat = 0

    lazy var universalBeamDrawingView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .red
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    lazy var universalBeamDepthOfSectionDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        label.text = "h = \(self.selectedUniversalBeamDepthOfSection) mm"
        
        return label
        
    }()
    
    lazy var universalBeamWidthOfSectionDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "b = \(self.selectedUniversalBeamWidthOfSection) mm"
                
        return label
        
    }()
    
    lazy var universalBeamSectionWebThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionWebThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tw = \(self.selectedUniversalBeamWebThickness) mm")
        
        universalBeamSectionWebThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionWebThicknessAttributtedString
                
        return label
        
    }()
    
    lazy var universalBeamSectionFlangeThicknessDimensionLabel: UILabel = {
        
        var label = UILabel()
        
        label.layer.borderWidth = 1.0
        
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let universalBeamSectionFlangeThicknessAttributtedString:NSMutableAttributedString = NSMutableAttributedString(string: "tf = \(self.selectedUniversalBeamFlangeThickness) mm")
        
        universalBeamSectionFlangeThicknessAttributtedString.setAttributes([.baselineOffset: -3], range: NSRange(location: 1, length: 1))
        
        label.attributedText = universalBeamSectionFlangeThicknessAttributtedString
                
        return label
        
    }()
    
    lazy var universalBeamMinorAxisBottomAnnotationLabel: UILabel = {
         
         var label = UILabel()
         
         label.layer.borderWidth = 1.0
         
         label.layer.borderColor = UIColor.black.cgColor
         
         label.translatesAutoresizingMaskIntoConstraints = false
                           
         label.text = "y"
                 
         return label
         
     }()
    
    lazy var universalBeamMinorAxisTopAnnotationLabel: UILabel = {
         
         var label = UILabel()
         
         label.layer.borderWidth = 1.0
         
         label.layer.borderColor = UIColor.black.cgColor
         
         label.translatesAutoresizingMaskIntoConstraints = false
                           
         label.text = "y"
                 
         return label
         
     }()
    
    lazy var universalBeamMajorAxisLeftAnnotationLabel: UILabel = {
         
         var label = UILabel()
         
         label.layer.borderWidth = 1.0
         
         label.layer.borderColor = UIColor.black.cgColor
         
         label.translatesAutoresizingMaskIntoConstraints = false
                           
         label.text = "x"
                 
         return label
         
     }()
    
    lazy var universalBeamMajorAxisRightAnnotationLabel: UILabel = {
         
         var label = UILabel()
         
         label.layer.borderWidth = 1.0
         
         label.layer.borderColor = UIColor.black.cgColor
         
         label.translatesAutoresizingMaskIntoConstraints = false
                           
         label.text = "x"
                 
         return label
         
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
        
        setupSubViewsConstraints()
        
    }
    
    func drawUniversalBeamPathAndItsAnnotations() {
        
        // MARK: - Drawing the Universal Beam path:
        
        // Below are the drawingView margins definition:
        
        let drawingViewTopAndBottomMargin: CGFloat = 55
        
        let drawingViewRightAndLeftMargin: CGFloat = 10
        
        let edgeDistanceBetweenDimensioningArrowsAndSection: CGFloat = 15
                
        let universalBeamShapeLayerPathLineWidth: CGFloat = 2
        
        let dimensioningAnnotationLinesPathLineWidth: CGFloat = 2
        
        let universalBeamPathStrokeColour = UIColor.blue.cgColor
        
        let dimensioningAnnotationLinesPathStrokeColour = UIColor.green.cgColor
                            
        // Below is the calculations needed to be crried out to obtain the appropriate scale to be applied to each universal beam section:
        
        let widthScale: CGFloat = (self.view.frame.size.width - (drawingViewRightAndLeftMargin * 2)) / selectedUniversalBeamWidthOfSection
        
        let depthScale: CGFloat = (self.view.frame.size.width - (drawingViewTopAndBottomMargin * 2)) / selectedUniversalBeamDepthOfSection
        
        let scaleToBeApplied = min(widthScale, depthScale)
        
        let dashedAnnotationLinesLengths: CGFloat = (edgeDistanceBetweenDimensioningArrowsAndSection + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) * 2
        
        // Below are the three UIBezierPath that we will be creating:
        
        let path = UIBezierPath()
        
        let mirroredPathOne = UIBezierPath()
        
        let mirroredPathTwo = UIBezierPath()
        
        let halfTheSectionPath = UIBezierPath()
        
        let fullSectionPath = UIBezierPath()
        
        let pathStartingXCoordinateFromOrigin: CGFloat = ((self.view.frame.size.width - (drawingViewRightAndLeftMargin * 2)) / 2) + drawingViewRightAndLeftMargin
        
        let pathStartingYCoordinateFromOrigin: CGFloat = drawingViewTopAndBottomMargin
        
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
        
        universalBeamShapeLayer.fillColor = UIColor.clear.cgColor
        
        universalBeamShapeLayer.strokeColor = universalBeamPathStrokeColour
                
        universalBeamShapeLayer.lineWidth = universalBeamShapeLayerPathLineWidth
        
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
        
        let depthOfSectionBottomArrowHeadStartingXCoordinate: CGFloat = (self.view.frame.size.width/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + edgeDistanceBetweenDimensioningArrowsAndSection
        
        let depthOfSectionBottomArrowHeadStartingYCoordinate: CGFloat = drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection - (selectedUniversalBeamFlangeThickness/2)) * scaleToBeApplied)
        
        depthOfSectionAnnotationLineXcoordinate = depthOfSectionBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)
        
        depthOfSectionAnnotationLineMidYcoordinate = drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)
        
        depthOfSectionHalfOfBottomArrowHeadPath.move(to: CGPoint(x: depthOfSectionBottomArrowHeadStartingXCoordinate, y: depthOfSectionBottomArrowHeadStartingYCoordinate))
        
        depthOfSectionHalfOfBottomArrowHeadPath.addLine(to: CGPoint(x: depthOfSectionAnnotationLineXcoordinate, y: depthOfSectionBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom half of the arrow head about the vertical y-axis:
        
        let depthOfSectionBottomArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let depthOfSectionReflectedBottomArrowHeadTranslation = CGAffineTransform(translationX: depthOfSectionAnnotationLineXcoordinate * 2, y: 0)
        
        let depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation = depthOfSectionBottomArrowHeadReflectionAxis.concatenating(depthOfSectionReflectedBottomArrowHeadTranslation)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.append(depthOfSectionHalfOfBottomArrowHeadPath)
        
        depthOfSectionReflectedBottomArrowHeadHalfPath.apply(depthOfSectionReflectedBottomArrowHeadCombinedReflectionAndTranslation)
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionReflectedBottomArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the bottom vertical line half needed for the depth of section annotation:
        
        depthOfSectionHalfOfVerticalLinePath.move(to: CGPoint(x: depthOfSectionAnnotationLineXcoordinate, y: depthOfSectionBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        depthOfSectionHalfOfVerticalLinePath.addLine(to: CGPoint(x: depthOfSectionAnnotationLineXcoordinate, y: depthOfSectionAnnotationLineMidYcoordinate))
        
        depthOfSectionFullBottomHalfPath.append(depthOfSectionHalfOfVerticalLinePath)
        
        // Below lines of codes are needed to draw the horziontal bottom and top dashed lines for the depth of section annotation:
        
        depthOfSectionBottomDashedLinePath.move(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + (universalBeamShapeLayerPathLineWidth/2), y: (drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied))))
        
        depthOfSectionBottomDashedLinePath.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + dashedAnnotationLinesLengths, y: (drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied))))
        
        depthOfSectionTopDashedLinePath.move(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + (universalBeamShapeLayerPathLineWidth/2), y: drawingViewTopAndBottomMargin))
        
        depthOfSectionTopDashedLinePath.addLine(to: CGPoint(x: (((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + pathStartingXCoordinateFromOrigin) + dashedAnnotationLinesLengths, y: drawingViewTopAndBottomMargin))
        
        dashedAnnotationLines.append(depthOfSectionBottomDashedLinePath)
        
        dashedAnnotationLines.append(depthOfSectionTopDashedLinePath)
        
        // Below code lines are needed in order to reflect the bottom half of the Depth Of Section Annotation elements about the horziontal x-axis:
        
        let depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath = CGAffineTransform(scaleX: 1, y: -1)
        
        let depthOfSectionTranslationForTheReflectedFullBottomHalfPath = CGAffineTransform(translationX: 0, y: (drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)) * 2)
        
        let requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath = depthOfSectionHorizontalReflectionLineForTheFullBottomHalfPath.concatenating(depthOfSectionTranslationForTheReflectedFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.append(depthOfSectionFullBottomHalfPath)
        
        depthOfSectionReflectedFullBottomHalfPath.apply(requiredCombinedReflectionAndTranslationForTheFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionReflectedFullBottomHalfPath)
        
        depthOfSectionFullPath.append(depthOfSectionFullBottomHalfPath)
        
        depthOfSectionAnnotationShapeLayer.path = depthOfSectionFullPath.cgPath
        
        depthOfSectionAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
                
        depthOfSectionAnnotationShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
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
        
        let widthOfSectionLeftSideArrowHeadStartingYCoordinate: CGFloat = drawingViewTopAndBottomMargin - edgeDistanceBetweenDimensioningArrowsAndSection
        
        widthOfSectionAnnotationLineMidXcoordinate = self.view.frame.size.width/2
        
        widthOfSectionAnnotationLineYcoordinate = widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.move(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate, y: widthOfSectionLeftSideArrowHeadStartingYCoordinate))
        
        widthOfSectionHalfOfTheLeftSideArrowHeadPath.addLine(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: widthOfSectionAnnotationLineYcoordinate))
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        // Below code lines are needed to reflect the left hand side half of the arrow head about the horizontal x-axis:
        
        let widthOfSectionLeftHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let widthOfSectionReflectedLeftHandArrowHeadTranslation = CGAffineTransform(translationX: 0, y: (widthOfSectionLeftSideArrowHeadStartingYCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) * 2)
        
        let widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation = widthOfSectionLeftHandSideArrowHeadReflectionAxis.concatenating(widthOfSectionReflectedLeftHandArrowHeadTranslation)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.append(widthOfSectionHalfOfTheLeftSideArrowHeadPath)
        
        widthOfSectionReflectedLeftArrowHeadHalfPath.apply(widthOfSectionReflectedLeftSideArrowHeadCombinedReflectionAndTranslation)
        
        widthOfSectionFullLeftSideHalfPath.append(widthOfSectionReflectedLeftArrowHeadHalfPath)
        
        // Below lines of codes are needed to draw the left hand side horizontal line half needed for the width of section annotation:
        
        widthOfSectionHalfOfHorizontalLinePath.move(to: CGPoint(x: widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: widthOfSectionAnnotationLineYcoordinate))
        
        widthOfSectionHalfOfHorizontalLinePath.addLine(to: CGPoint(x: (widthOfSectionLeftSideArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: widthOfSectionAnnotationLineYcoordinate))
        
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
        
        widthOfSectionLeftSideDashedLinePath.move(to: CGPoint(x: ((self.view.frame.size.width)/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: drawingViewTopAndBottomMargin - (universalBeamShapeLayerPathLineWidth/2)))
        
        widthOfSectionLeftSideDashedLinePath.addLine(to: CGPoint(x: ((self.view.frame.size.width)/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: (drawingViewTopAndBottomMargin - (universalBeamShapeLayerPathLineWidth/2)) - dashedAnnotationLinesLengths))
        
        widthOfSectionRightSideDashedLinePath.move(to: CGPoint(x: ((self.view.frame.size.width)/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: drawingViewTopAndBottomMargin - (universalBeamShapeLayerPathLineWidth/2)))
        
        widthOfSectionRightSideDashedLinePath.addLine(to: CGPoint(x: ((self.view.frame.size.width)/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied), y: (drawingViewTopAndBottomMargin - (universalBeamShapeLayerPathLineWidth/2)) - dashedAnnotationLinesLengths))
        
        dashedAnnotationLines.append(widthOfSectionLeftSideDashedLinePath)
        
        dashedAnnotationLines.append(widthOfSectionRightSideDashedLinePath)
        
        // MARK: - Drawing the annotation line for the section web thickness:
        
        let sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessReflectedRightSideHalfOfTheBottomArrowHeadPath = UIBezierPath()
        
        let sectionWebThicknessRightSideHorizontalLinePath = UIBezierPath()
        
        let sectionWebThicknessFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessReflectedFullRightSidePath = UIBezierPath()
        
        let sectionWebThicknessFullPath = UIBezierPath()
        
        let sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate: CGFloat = (self.view.frame.size.width/2) + ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)
        
        let sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate: CGFloat = drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied) - (selectedUniversalBeamRootRadius * scaleToBeApplied * 2)
        
        sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate = (self.view.frame.size.width/2) - ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) - (universalBeamShapeLayerPathLineWidth/2) - (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
        
        sectionWebThicknessAnnotationLineYcoordinate = sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.move(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate, y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate))
        
        sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath.addLine(to: CGPoint(x: sectionWebThicknessRightSideBottomArrowHeadStartingXCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        sectionWebThicknessFullRightSidePath.append(sectionWebThicknessRightSideHalfOfTheBottomArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom right hand side arrow head about the horizontal axis:
        
        let sectionWebThicknessBottomRightHandSideArrowHeadReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let sectionWebThicknessReflectedBottomRightHandSideArrowHeadTranslation = CGAffineTransform(translationX: 0, y: sectionWebThicknessRightSideBottomArrowHeadStartingYCoordinate * 2)
        
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
        
        let sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation = CGAffineTransform(translationX: (((self.view.frame.size.width/2) + ((selectedUniversalBeamWebThickness/2) * scaleToBeApplied) + (universalBeamShapeLayerPathLineWidth/2)) * 2) - (((universalBeamShapeLayerPathLineWidth) + selectedUniversalBeamWebThickness * scaleToBeApplied)), y: 0)
        
        let sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation = sectionWebThicknessFullRightHandSidePathReflectionAxis.concatenating(sectionWebThicknessReflectedBottomFullRightHandSidePathTranslation)
        
        sectionWebThicknessReflectedFullRightSidePath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessReflectedFullRightSidePath.apply(sectionWebThicknessReflectedFullRightHandSidePathCombinedReflectionAndTranslation)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessFullRightSidePath)
        
        sectionWebThicknessFullPath.append(sectionWebThicknessReflectedFullRightSidePath)
        
        // MARK: - Drawing the annotation line for the section flange thickness annotation lines:
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadPath = UIBezierPath()
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath = UIBezierPath()
        
        let sectionFlangeThicknessBottomSideVerticalLinePath = UIBezierPath()
        
        let sectionFlangeThicknessFullBottomSidePath = UIBezierPath()
        
        let sectionFlangeThicknessReflectedFullBottomSidePath = UIBezierPath()
        
        let sectionFlangeThicknessFullPath = UIBezierPath()
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate: CGFloat = ((self.view.frame.size.width/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied)) + (selectedUniversalBeamFlangeThickness * scaleToBeApplied)
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadStartingYCoordinate: CGFloat = drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + universalBeamShapeLayerPathLineWidth/2
        
        sectionFlangeThicknessTopVerticalAnnotationLineStartingXcoordinate = sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate
        
        sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate = drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied) - universalBeamShapeLayerPathLineWidth/2 - (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
        
        sectionFlangeThicknessBottomSideHalfArrowHeadPath.move(to: CGPoint(x: sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate, y: sectionFlangeThicknessBottomSideHalfArrowHeadStartingYCoordinate))
        
        sectionFlangeThicknessBottomSideHalfArrowHeadPath.addLine(to: CGPoint(x: sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate - ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied), y: sectionFlangeThicknessBottomSideHalfArrowHeadStartingYCoordinate + ((selectedUniversalBeamFlangeThickness/2) * scaleToBeApplied)))
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
        
        // Below code lines are needed to reflect the bottom half arrow head about the vertical axis:
        
        let sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis = CGAffineTransform(scaleX: -1, y: 1)
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation = CGAffineTransform(translationX: sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate * 2, y: 0)
        
        let sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation = sectionFlangeThicknessBottomSideHalfArrowHeadReflectionAxis.concatenating(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadTranslation)
        
        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.append(sectionFlangeThicknessBottomSideHalfArrowHeadPath)
        
        sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath.apply(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadCombinedReflectionAndTranslation)
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessReflectedBottomSideHalfArrowHeadPath)
        
        // Below lines of codes are needed to draw the bottom hand side vertical line needed for the section flange thickness annotation:
        
        sectionFlangeThicknessBottomSideVerticalLinePath.move(to: CGPoint(x: sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate, y: sectionFlangeThicknessBottomSideHalfArrowHeadStartingYCoordinate))
        
        sectionFlangeThicknessBottomSideVerticalLinePath.addLine(to: CGPoint(x: sectionFlangeThicknessBottomSideHalfArrowHeadStartingXCoordinate, y: sectionFlangeThicknessBottomSideHalfArrowHeadStartingYCoordinate + (selectedUniversalBeamRootRadius * 2 * scaleToBeApplied)
        ))
        
        sectionFlangeThicknessFullBottomSidePath.append(sectionFlangeThicknessBottomSideVerticalLinePath)
        
        // Below code lines are needed to reflect the full bottom hand side section flange thickness annotation about the horizontal axis:
        
        let sectionFlangeThicknessFullBottomHandSidePathReflectionAxis = CGAffineTransform(scaleX: 1, y: -1)
        
        let sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation = CGAffineTransform(translationX: 0, y: ((drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied)) * 2) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied))
        
        let sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation = sectionFlangeThicknessFullBottomHandSidePathReflectionAxis.concatenating(sectionFlangeThicknessReflectedFullBottomHandSidePathTranslation)
        
        sectionFlangeThicknessReflectedFullBottomSidePath.append(sectionFlangeThicknessFullBottomSidePath)
        
        sectionFlangeThicknessReflectedFullBottomSidePath.apply(sectionFlangeThicknessReflectedFullBottomHandSidePathCombinedReflectionAndTranslation)
        
        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessFullBottomSidePath)
        
        sectionFlangeThicknessFullPath.append(sectionFlangeThicknessReflectedFullBottomSidePath)
        
        // MARK: - Drawing the dashed Major and Minor Axis:
        
        let minorSectionAxisDashedLine = UIBezierPath()
        
        let majorSectionAxisDashedLine = UIBezierPath()
        
        let minorSectionAxisYcoordinate: CGFloat = drawingViewTopAndBottomMargin + ((selectedUniversalBeamDepthOfSection/2) * scaleToBeApplied)
        
        let majorSectionAxisXcoordinate: CGFloat = self.view.frame.size.width/2
        
        let minorAndMajorAxisEdgeExtensionLength: CGFloat = 10
        
        sectionMinorAnnotationVerticalLineTopYcoordinate = drawingViewTopAndBottomMargin - minorAndMajorAxisEdgeExtensionLength
        
        sectionMinorAnnotationVerticalLineBottomYcoordinate = drawingViewTopAndBottomMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied) + minorAndMajorAxisEdgeExtensionLength
        
        sectionMinorAnnotationVerticalLineXcoordinate = majorSectionAxisXcoordinate
        
        sectionMajorAnnotationHorizontalLineLeftXcoordinate = (self.view.frame.size.width/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) - minorAndMajorAxisEdgeExtensionLength
        
        sectionMajorAnnotationHorizontalLineRightXcoordinate = ((self.view.frame.size.width/2) - ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied)) + (selectedUniversalBeamWidthOfSection * scaleToBeApplied) + minorAndMajorAxisEdgeExtensionLength
        
        sectionMajorAnnotationHorizontalLineYcoordinate = minorSectionAxisYcoordinate
        
        majorSectionAxisDashedLine.move(to: CGPoint(x: sectionMajorAnnotationHorizontalLineLeftXcoordinate, y: minorSectionAxisYcoordinate))
        
        majorSectionAxisDashedLine.addLine(to: CGPoint(x: sectionMajorAnnotationHorizontalLineRightXcoordinate, y: minorSectionAxisYcoordinate))
        
        minorSectionAxisDashedLine.move(to: CGPoint(x: majorSectionAxisXcoordinate, y: sectionMinorAnnotationVerticalLineTopYcoordinate))
        
        minorSectionAxisDashedLine.addLine(to: CGPoint(x: majorSectionAxisXcoordinate, y: sectionMinorAnnotationVerticalLineBottomYcoordinate))
        
        // Below we are drawing the fullSectionPath inside our view:
        
        widthOfSectionAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
                
        widthOfSectionAnnotationShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        widthOfSectionAnnotationShapeLayer.path = widthOfSectionFullPath.cgPath
        
        dimensioningAnnotationDashedLinesShapeLayer.path = dashedAnnotationLines.cgPath
        
        dimensioningAnnotationDashedLinesShapeLayer.lineDashPattern =  [NSNumber(value: Float(dashedAnnotationLinesLengths/6)), NSNumber(value: Float((dashedAnnotationLinesLengths/6)/4))]
        
        dimensioningAnnotationDashedLinesShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
                
        dimensioningAnnotationDashedLinesShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        sectionWebThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
                
        sectionWebThicknessAnnotationShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        sectionWebThicknessAnnotationShapeLayer.path = sectionWebThicknessFullPath.cgPath
        
        sectionFlangeThicknessAnnotationShapeLayer.path = sectionFlangeThicknessFullPath.cgPath
        
        sectionFlangeThicknessAnnotationShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        sectionFlangeThicknessAnnotationShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        minorAxisDashedAnnotationLineShapeLayer.path = minorSectionAxisDashedLine.cgPath
        
        minorAxisDashedAnnotationLineShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        minorAxisDashedAnnotationLineShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
        majorAxisDashedAnnotationLineShapeLayer.path = majorSectionAxisDashedLine.cgPath
        
        majorAxisDashedAnnotationLineShapeLayer.lineWidth = dimensioningAnnotationLinesPathLineWidth
        
        majorAxisDashedAnnotationLineShapeLayer.strokeColor = dimensioningAnnotationLinesPathStrokeColour
        
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
            
            universalBeamDepthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: depthOfSectionAnnotationLineXcoordinate -  distanceBetweenDepthOfSectionDimensionAnnotationLineAndItsLabel - universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.width/2 + universalBeamDepthOfSectionDimensionLabel.intrinsicContentSize.height/2),
            
            universalBeamWidthOfSectionDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: widthOfSectionAnnotationLineYcoordinate - distanceBetweenWidthOfSectionDimensionAnnotationLineAndItsLabel - universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.height),
            
            universalBeamWidthOfSectionDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: widthOfSectionAnnotationLineMidXcoordinate - universalBeamWidthOfSectionDimensionLabel.intrinsicContentSize.width/2),
            
            universalBeamSectionWebThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionWebThicknessAnnotationLineYcoordinate - universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.height/2),
            
            universalBeamSectionWebThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionWebThicknessLeftHorizontalAnnotationLineStartingXcoordinate - universalBeamSectionWebThicknessDimensionLabel.intrinsicContentSize.width),
            
            universalBeamSectionFlangeThicknessDimensionLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingYcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.height),
                       
            universalBeamSectionFlangeThicknessDimensionLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionFlangeThicknessTopVerticalAnnotationLineStartingXcoordinate - universalBeamSectionFlangeThicknessDimensionLabel.intrinsicContentSize.width/2),
            
            universalBeamMinorAxisTopAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineTopYcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.height),
            
            universalBeamMinorAxisTopAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMinorAnnotationVerticalLineXcoordinate - universalBeamMinorAxisTopAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMinorAxisBottomAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMinorAnnotationVerticalLineBottomYcoordinate),
            
            universalBeamMinorAxisBottomAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMinorAnnotationVerticalLineXcoordinate - universalBeamMinorAxisBottomAnnotationLabel.intrinsicContentSize.width/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMajorAnnotationHorizontalLineYcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.height/2),
            
            universalBeamMajorAxisLeftAnnotationLabel.leftAnchor.constraint(equalTo: universalBeamDrawingView.leftAnchor, constant: sectionMajorAnnotationHorizontalLineLeftXcoordinate - universalBeamMajorAxisLeftAnnotationLabel.intrinsicContentSize.width),
            
            universalBeamMajorAxisRightAnnotationLabel.topAnchor.constraint(equalTo: universalBeamDrawingView.topAnchor, constant: sectionMajorAnnotationHorizontalLineYcoordinate - universalBeamMajorAxisRightAnnotationLabel.intrinsicContentSize.height/2),
            
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
