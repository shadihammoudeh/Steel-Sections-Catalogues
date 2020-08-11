//
//  CataloguesVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 24/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class CataloguesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationBarDelegate {
    
    var collectionViewCellsTitlesArray = ["BlueBook Catalogue","ArcelorMittal Europe Catalogue"]
    
    var collectionViewCellsImagesArray = ["blueBookCatalogue","arcelorMittalCatalogue"]
    
    var cataloguesCollectionViewHeight: CGFloat?
    
    lazy var cataloguesCollectionView = CustomCollectionView(startingHoriztonalCoordinateOfCollectionView: 0, startingVerticalCoordinateOfCollectionView: 0, widthOfCollectionView: self.view.frame.size.width, heightOfCollectionView: cataloguesCollectionViewHeight!, collectionViewLayoutTopEdgeInset: 20, collectionViewLayoutLeftEdgeInset: 20, collectionViewLayoutBottomEdgeInset: 20, collectionViewLayoutRightEdgeInset: 20, collectionViewLayoutCellsMinimumVerticalSpacings: 20, collectionViewLayoutCellsMinimumHorizontalSpacings: 20, numberOfCellsPerRow: 1, numberOfCellsPerColumn: 2, hostViewDataSource: self, hostViewDelegate: self)
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Steel Catalogues", navBarDelegate: self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        view.addSubview(navigationBar)
        
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
    }
    
    override func viewWillLayoutSubviews() {
                
    }
    
    override func viewDidLayoutSubviews() {
                
        let statusBarPlusNavigationBarHeight = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + navigationBar.frame.size.height
                        
        let totalViewControllerHeight = view.frame.size.height
        
        let viewControllerBottomSafeAreaHeight = view.safeAreaInsets.bottom
        
        let viewControllerSafeAreaHeight = totalViewControllerHeight - statusBarPlusNavigationBarHeight - viewControllerBottomSafeAreaHeight
        
        cataloguesCollectionViewHeight = viewControllerSafeAreaHeight
        
        view.addSubview(cataloguesCollectionView)
        
        NSLayoutConstraint.activate([
            
            cataloguesCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            cataloguesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            cataloguesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            cataloguesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            
            ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
                
    }
    
    override func viewWillDisappear(_ animated: Bool) {
                
    }
    
    override func viewDidDisappear(_ animated: Bool) {
                
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionViewCellsTitlesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.setupCustomCellElements(cellImageName: collectionViewCellsImagesArray[indexPath.row], cellTitleTextSize: 15, cellTitle: collectionViewCellsTitlesArray[indexPath.row])
    
        return cell
        
    }
    
    @objc func navigationBarLeftButtonPressed(sender: UIButton) {
                
        guard let nextViewControllerToGoTo = storyboard?.instantiateViewController(withIdentifier: "MainScreenVC") else {
            
            print("MainScreenVC could not be presented")
            
            return
            
        }
        
        present(nextViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            ])
        
    }
    
    // The below functions needed in order to get rid of the gap between the NavigationBar and the Status Bar:
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            guard let nextViewControllerToGoTo = storyboard?.instantiateViewController(withIdentifier: "OpenAndClosedSteelSectionsTabViewController") else {
                
                print("BlueBookTabController could not be presented")
                
                return
                
            }
            
            present(nextViewControllerToGoTo, animated: true, completion: nil)
            
        }
        
    }
    
}
