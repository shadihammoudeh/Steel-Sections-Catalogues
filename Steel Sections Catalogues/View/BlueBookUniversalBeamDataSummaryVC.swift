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
    
    let shapeLayer = CAShapeLayer()
    
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
        
        drawUniversalBeamPath()
                    
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamDrawingView)
        
        universalBeamDrawingView.layer.addSublayer(shapeLayer)

    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
        setupSubViewsConstraints()
                
    }
    
    func drawUniversalBeamPath() {
        
        // Below are the drawingView margins definition:
        
        let drawingViewTopMargin: CGFloat = 10
        
        let drawingViewRightMargin: CGFloat = 10
        
        let drawingViewBottomMargin: CGFloat = 10
        
        let drawingViewLeftMargin: CGFloat = 10
        
        let lineWidth: CGFloat = 2
        
        // Below is the calculations needed to be crried out to obtain the appropriate scale to be applied to each universal beam section:
        
        let widthScale: CGFloat = (self.view.frame.size.width - drawingViewLeftMargin - drawingViewRightMargin) / selectedUniversalBeamWidthOfSection
        
        let depthScale: CGFloat = (self.view.frame.size.width - drawingViewTopMargin - drawingViewBottomMargin) / selectedUniversalBeamDepthOfSection
        
        let scaleToBeApplied = min(widthScale, depthScale)
        
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
                
        shapeLayer.path = fullSectionPath.cgPath

        shapeLayer.strokeColor = UIColor.blue.cgColor
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.lineWidth = lineWidth
        
    }
    
    func drawAnnotationsSymbols() {
        
        let horizontalDistanceBetweenDepthOfSectionBottomArrowHeadFirstPointAndBottomRightCornerOfSection: CGFloat = 10
        
        let depthOfSectionBottomArrowAnnotationSymbol = UIBezierPath()
        
        let bottomArrowHeadStartingXCoordinate: CGFloat = (universalBeamDrawingView.frame.size.width/2) + ((selectedUniversalBeamWidthOfSection/2) * scaleToBeApplied) + horizontalDistanceBetweenDepthOfSectionBottomArrowHeadFirstPointAndBottomRightCornerOfSection
        
        let bottomArrowHeadStartingYCoordinate: CGFloat = (drawingViewTopMargin + (selectedUniversalBeamDepthOfSection * scaleToBeApplied)) - (selectedUniversalBeamFlangeThickness * scaleToBeApplied)
                
        depthOfSectionBottomArrowAnnotationSymbol.move(to: CGPoint(x: bottomArrowHeadStartingXCoordinate, y: bottomArrowHeadStartingYCoordinate))
        
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
