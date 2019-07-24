//
//  CataloguesVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 24/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class CataloguesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationBarDelegate {
    
    var collectionViewCellsTitlesArray = ["",""]
    
    var collectionViewCellsImagesArray = ["",""]
    
    var cataloguesCollectionViewHeight: CGFloat?
    
    lazy var cataloguesCollectionView = CustomCollectionView(startingHoriztonalCoordinateOfCollectionView: 0, startingVerticalCoordinateOfCollectionView: 0, widthOfCollectionView: self.view.frame.size.width, heightOfCollectionView: cataloguesCollectionViewHeight!, collectionViewLayoutTopEdgeInset: 20, collectionViewLayoutLeftEdgeInset: 20, collectionViewLayoutBottomEdgeInset: 20, collectionViewLayoutRightEdgeInset: 20, collectionViewLayoutCellsMinimumVerticalSpacings: 20, collectionViewLayoutCellsMinimumHorizontalSpacings: 20, numberOfCellsPerRow: 1, numberOfCellsPerColumn: 2, hostViewDataSource: self, hostViewDelegate: self, hexCodeColorForBackgroundColor: "0D0D0D")
    
    lazy var navigationBar = CustomUINavigationBar(normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Steel Catalogues", titleLabelFontHexColourCode: "#000000", labelTitleFontSize: 18, labelTitleFontType: "AppleSDGothicNeo-Medium", isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#FFFFFF", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#FF4F40")

    override func viewDidLoad() {
        
        super.viewDidLoad()

        print("CataloguesVC viewDidLoad()")
        
        view.addSubview(navigationBar)
        
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("CataloguesVC viewWillAppear()")

    }
    
    override func viewWillLayoutSubviews() {
        
        print("CataloguesVC viewWillLayoutSubviews()")

    }
    
    override func viewDidLayoutSubviews() {
        
        print("CataloguesVC viewDidLayoutSubviews()")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("CataloguesVC viewDidAppear()")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("CataloguesVC viewWillDisappear()")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("CataloguesVC viewDidDisappear()")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        
        return cell
        
    }
    
    @objc func navigationBarLeftButtonPressed(sender: UIButton) {
        
        print("CataloguesVC Navigation Bar Left Button Pressed")
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
        ])
        
    }
    
    // The below functionis needed in order to get rid of the gap between the NavigationBar and the Status Bar:
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }

}
