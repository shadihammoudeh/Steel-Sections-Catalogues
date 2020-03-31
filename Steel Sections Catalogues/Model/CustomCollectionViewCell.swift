//
//  CustomCollectionViewCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 24/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomCollectionViewCell: UICollectionViewCell {
    
    let cellImage = UIImageView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(cellTextTile text: String) {
        
        self.init()
        
    }
    
    func setupCustomCellElements(cellImageName image: String,  cellTitleTextSize textSize: CGFloat, cellTitle title: String) {
        
//        let cellImage: UIImageView = {
//
////            let imageView = UIImageView()
//
//            imageView.backgroundColor = .clear
//
//            imageView.image = UIImage(named: image)
//
//            // The below line of code maintains the aspect ratio of the image (no distrotion):
//
//            imageView.contentMode = .scaleAspectFit
//
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//
//            return imageView
//
//        }()
        cellImage.backgroundColor = .clear
        
        cellImage.image = UIImage(named: image)
        
        // The below line of code maintains the aspect ratio of the image (no distrotion):
        
        cellImage.contentMode = .scaleAspectFit
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        
        let cellTitle: UILabel = {
            
            let label = UILabel()
            
            label.textColor = UIColor(named: "Collection View Cell Title Colour")
            
            label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: textSize)
            
            label.text = title
            
            label.numberOfLines = 0
            
            label.textAlignment = .center
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
            
        }()
        
        backgroundColor = UIColor(named: "Collection View Cell Background Colour")
        
        layer.borderColor = UIColor(named: "Collection View Cell Border Colour")?.cgColor
        
        layer.borderWidth = 1
        
        layer.cornerRadius = 10
        
        layer.shadowOffset = CGSize(width: 7, height: 7)
        
        layer.shadowColor = UIColor(named: "Collection View Cell Shadow Colour")?.cgColor
        
        layer.shadowRadius = 3
        
        layer.shadowOpacity = 0.60
        
        layer.masksToBounds = false
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        
        addSubview(cellImage)
        
        addSubview(cellTitle)
        
        NSLayoutConstraint.activate([
            
            cellTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            cellTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            cellTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            
            cellImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            cellImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            cellImage.bottomAnchor.constraint(equalTo: cellTitle.topAnchor, constant: -5),
            
            cellImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)
            
        ])
        
    }
    
    func disableCellDropShadow() {
        
        layer.shadowOffset = CGSize(width: 07, height: 0)

        layer.shadowOpacity = 0.0

    }
    
    func changeLocation(x: CGFloat, y: CGFloat) {
        
        cellImage.bounds.origin = CGPoint(x: x, y: y)

    }
    
    // The below function is needed in order to calculate the height of the cellLabel height based on its contents. Then this height is used to calulate the needed constraints for the cellLabel and cellImage:
    
    //    func cellTextLabelHeight(cellTitleTextSize textSize: CGFloat, cellTitleFontType fontType: String, cellTitle title: String) -> CGFloat {
    //
    //        var currentHeight: CGFloat!
    //
    //        let cellTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
    //
    //        cellTitle.text = title
    //
    //        cellTitle.font = UIFont(name: fontType, size: textSize)
    //
    //        cellTitle.numberOfLines = 0
    //
    //        cellTitle.sizeToFit()
    //
    //        cellTitle.lineBreakMode = .byWordWrapping
    //
    //        currentHeight = cellTitle.frame.height
    //
    //        cellTitle.removeFromSuperview()
    //
    //        return currentHeight
    //
    //    }
    
}

