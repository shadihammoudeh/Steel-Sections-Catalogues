//
//  CustomCollectionView.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 24/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(startingHoriztonalCoordinateOfCollectionView xCoordinate: CGFloat, startingVerticalCoordinateOfCollectionView yCoordinate: CGFloat, widthOfCollectionView: CGFloat, heightOfCollectionView height: CGFloat, collectionViewLayoutTopEdgeInset topInset: CGFloat, collectionViewLayoutLeftEdgeInset leftInset: CGFloat, collectionViewLayoutBottomEdgeInset bottomInset: CGFloat, collectionViewLayoutRightEdgeInset rightInset: CGFloat, collectionViewLayoutCellsMinimumVerticalSpacings cellsVerticalSpacings: CGFloat, collectionViewLayoutCellsMinimumHorizontalSpacings cellsHorizontalSpacings: CGFloat, numberOfCellsPerRow cellsPerRow: CGFloat, numberOfCellsPerColumn cellsPerColumn: CGFloat, hostViewDataSource: UICollectionViewDataSource, hostViewDelegate: UICollectionViewDelegate) {
        
        self.init(frame: CGRect(x: xCoordinate, y: yCoordinate, width: widthOfCollectionView, height: height), collectionViewLayout: {
            
            let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            
            //  The below line of code specifies the top. right, bottom and left paddings for the cells (the one at the very top and very bottom are the cells that get affected by top and bottom values, all cells get affected by left and right values) inside the UICollectionView:
            
            collectionViewLayout.sectionInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            
            // The below line of code defines the minimum vertical spacings between cells:
            
            collectionViewLayout.minimumLineSpacing = cellsVerticalSpacings
            
            // The below line of code defines the minimum horizontal spacings between cells:
            
            collectionViewLayout.minimumInteritemSpacing = cellsHorizontalSpacings
            
            let widthOfSingleCollectionViewCell: CGFloat = ((widthOfCollectionView) - (leftInset + rightInset + (cellsHorizontalSpacings * (cellsPerRow - 1)))) / cellsPerRow
            
            let heightOfSingleCollectionViewCell: CGFloat = ((height) - (topInset + bottomInset + (cellsVerticalSpacings * (cellsPerColumn - 1)))) / cellsPerColumn
            
            // The below line of code specifies the size of each cell to be displayed inside the UICollectionView:
            
            collectionViewLayout.itemSize = CGSize(width: widthOfSingleCollectionViewCell, height: heightOfSingleCollectionViewCell)
            
            return collectionViewLayout
            
        } ()
            
        )
        
        dataSource = hostViewDataSource
        
        delegate = hostViewDelegate
        
        backgroundColor = UIColor(named: "Collection View Background Colour")
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // In the below line of code we are registering the CustomCollectionViewCell class that we created as the cell to be used for the custom CollectionView class:
        
        register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
    }
    
}
