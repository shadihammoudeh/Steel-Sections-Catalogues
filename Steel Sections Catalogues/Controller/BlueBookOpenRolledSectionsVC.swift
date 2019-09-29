//
//  BlueBookOpenRolledSectionsVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookOpenRolledSectionsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // The below Variables obtain their values from the BlueBookTabController Class when viewDidLayoutSubviews cycle gets initiated:
    
    var blueBookControllerStatusBarHeight: CGFloat = 0
    
    var blueBookControllerNavigationBarHeight: CGFloat = 0
    
    var blueBookControllerTabBarHeight: CGFloat = 0
    
    var blueBookControllerBottomSafeAreaHeight: CGFloat = 0
    
    // The below Array represents the titles of the cells to be displayed for the CollectionView cells:
    
    let cellTitleArray = ["Universal beams (UB)", "Universal columns (UC)", "Universal bearing piles (UBP)", "Parallel flange channels (PFC)", "Equal leg angles (L)", "Unequal leg angles (L)", "Tees (T) split from UB", "Tees (T) split from UC"]
    
    // The below Array represents the images for the cells to be displayed inside the CollectionView:
    
    let cellImageArray = ["3D Universal Beam","3D Universal Column","3D Universal Bearing Pile","3D Parallel Flange Channels","3D Equal Leg Angle","3D Unequal Leg Angle","3D Tees (T) Split from UB", "3D Tees (T) Split from UC"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("BlueBookOpenRolledSectionsVC viewDidLoad()")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("BlueBookOpenRolledSectionsVC viewWillAppear()")
        
    }
    
    override func viewWillLayoutSubviews() {
        
        print("BlueBookOpenRolledSectionsVC viewWillLayoutSubviews()")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("BlueBookOpenRolledSectionsVC viewDidLayoutSubviews()")
        
        // The below line of code calculates the required height for the OpenRolledSectionsTabViewController class. By substracting the total height of this view from the height of the NavigationBar plus Status Bar Height defined inside the NewFileTabController Class. The height of the TabBar as well as Bottom Safe Area Height are already substracted from the overall screen height of this ViewController (view.frame.size.height), and therefore, there is no need to substract them again:
        
        let blueBookOpenRolledSectionsCollectionViewHeight: CGFloat = view.frame.size.height - blueBookControllerNavigationBarHeight - blueBookControllerStatusBarHeight
        
        var blueBookOpenRolledSectionsCollectionView = CustomCollectionView(startingHoriztonalCoordinateOfCollectionView: 0, startingVerticalCoordinateOfCollectionView: blueBookControllerStatusBarHeight + blueBookControllerNavigationBarHeight, widthOfCollectionView: view.frame.size.width, heightOfCollectionView: blueBookOpenRolledSectionsCollectionViewHeight, collectionViewLayoutTopEdgeInset: 20, collectionViewLayoutLeftEdgeInset: 20, collectionViewLayoutBottomEdgeInset: 20, collectionViewLayoutRightEdgeInset: 20, collectionViewLayoutCellsMinimumVerticalSpacings: 20, collectionViewLayoutCellsMinimumHorizontalSpacings: 20, numberOfCellsPerRow: 2, numberOfCellsPerColumn: 4, hostViewDataSource: self, hostViewDelegate: self, hexCodeColorForBackgroundColor: "#020301")
        
        view.addSubview(blueBookOpenRolledSectionsCollectionView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("OpenRolledSectionsTabViewController viewDidAppear()")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("FirstTabBarItem viewWillDisappear()")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("FirstTabBarItem viewDidDiappear()")
        
    }
    
    // The below methods are required to adopt the UICollectionViewDataSource and UICollectionViewDelegate protocols:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellTitleArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        
        myCell.setupCustomCellElements(cellImageName: cellImageArray[indexPath.item], cellTitleTextColour: "#797D70", cellTitleTextSize: 15, cellTitleFontType: "Apple SD Gothic Neo", cellTitle: cellTitleArray[indexPath.item], cellHexColorCode: "#E8FFB5", cellCornerRadius: 3, cellShadowOffsetWidth: 0, cellShadowOffsetHeight: 1.5, cellShadowColor: "#9CCC38", cellShadowRadius: 3, cellShadowOpacity: 0.6)
        
        print(myCell.frame.size.height)
        
        return myCell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            
            let viewControllerToGoTo = main.instantiateViewController(identifier: "BlueBookUniversalBeamsVC")
            
            self.present(viewControllerToGoTo, animated: true, completion: nil)
            
        }

    }
    
}
