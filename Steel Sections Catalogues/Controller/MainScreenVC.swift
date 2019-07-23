//
//  MainScreenVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 20/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class MainScreenVC: UIViewController, UINavigationBarDelegate {
    
    let buttonTitleFontName: String = "AppleSDGothicNeo-Medium"
    
    let buttonTitleFontSize: CGFloat = 18
    
    var verticalSpacingsBetweenButtons: CGFloat = 0
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    lazy var sectionsCataloguesButton: UIButton = CustomUIButton(normalStateButtonTitleHexColourCode: "#FCE9CC", highlightedStateButtonTitleHexColourCode: "#FF625E", buttonTitleFontName: buttonTitleFontName, buttonTitleFontSize: buttonTitleFontSize, normalStateButtonTitleText: "Steel Profiles Catalogues", buttonBackgroundColourHexCode: "#123638", buttonBackgroundColourAlphaValue: 0.5, buttonCornerRadius: 2, buttonBorderWidth: 1, buttonBorderHexColourCode: "#FFCDAC", highlightButtonWhenTapped: true, buttonContentHorizontalAlignment: .left, buttonContentVerticalAlignment: .center, buttonTagValue: 1, buttonTarget: self, buttonSelector: #selector(buttonPressed(_:)), normalStateButtonImage: "catalogueButton")
    
    lazy var contactUsButton: UIButton = CustomUIButton(normalStateButtonTitleHexColourCode: "#FCE9CC", highlightedStateButtonTitleHexColourCode: "#FF625E", buttonTitleFontName: buttonTitleFontName, buttonTitleFontSize: buttonTitleFontSize, normalStateButtonTitleText: "Contact Us", buttonBackgroundColourHexCode: "#123638", buttonBackgroundColourAlphaValue: 0.5, buttonCornerRadius: 2, buttonBorderWidth: 1, buttonBorderHexColourCode: "#FFCDAC", highlightButtonWhenTapped: true, buttonContentHorizontalAlignment: .left, buttonContentVerticalAlignment: .center, buttonTagValue: 1, buttonTarget: self, buttonSelector: #selector(buttonPressed(_:)), normalStateButtonImage: "contactUsButton")
    
    lazy var navigationBar = CustomUINavigationBar(labelTitleText: "Steel Sections Catalogues", titleLabelFontHexColourCode: "#FFFFFF", labelTitleFontSize: 18, labelTitleFontType: "AppleSDGothicNeo-Medium", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#000000", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#FF4F40")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("MainScreenVC viewDidLoad()")
        
        self.view.backgroundColor = UIColor(hexString: "#000000")
        
        view.addSubview(sectionsCataloguesButton)
        
        view.addSubview(contactUsButton)
        
        view.addSubview(navigationBar)
        
        setupConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("MainScreenVC viewWillAppear")
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        print("MainScreenVC viewWillLayoutSubviews()")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("MainScreenVC viewDidLayoutSubviews()")
        
        let statusBarPlusNavigationBarHeight = UIApplication.shared.statusBarFrame.size.height + navigationBar.frame.size.height
        
        let totalViewControllerHeight = view.frame.size.height
        
        let viewControllerBottomSafeAreaHeight = view.safeAreaInsets.bottom
        
        let viewControllerSafeAreaHeight = totalViewControllerHeight - statusBarPlusNavigationBarHeight - viewControllerBottomSafeAreaHeight
        
        print("View Controller safe area height \(viewControllerSafeAreaHeight)")
        
        verticalSpacingsBetweenButtons = (viewControllerSafeAreaHeight - sectionsCataloguesButton.frame.size.height - contactUsButton.frame.size.height)/3
        
        NSLayoutConstraint.activate([
        
            sectionsCataloguesButton.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: (verticalSpacingsBetweenButtons)),
            
            contactUsButton.topAnchor.constraint(equalTo: sectionsCataloguesButton.bottomAnchor, constant: (verticalSpacingsBetweenButtons))
            
        ])
        
        print("Catalogue Button height \(sectionsCataloguesButton.frame.size.height)")
        
        print("Contact Us Button Height is equal to \(contactUsButton.frame.size.height)")
        
        print("Vertical Spacings between buttons is equal to \(verticalSpacingsBetweenButtons)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("MainScreenVC viewDidAppear()")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("MainScreenVC viewWillDisappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("MainScreenVC viewDidDisappear()")
        
    }
    
    @objc func buttonPressed(_ :UIButton) {
        
        
        
    }
    
    func setupConstraints() {
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            sectionsCataloguesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contactUsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
    }
    
    // The below functionis needed in order to get rid of the gap between the NavigationBar and the Status Bar:
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}
