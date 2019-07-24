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
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(cellTextTile text: String) {
        
        self.init()
        
    }
    
    func setupCustomCellElements(cellImageName image: String, cellTitleTextColour textColour: String, cellTitleTextSize textSize: CGFloat, cellTitleFontType fontType: String, cellTitle title: String, cellHexColorCode hexCode: String, cellCornerRadius radius: CGFloat, cellShadowOffsetWidth offsetWidth: CGFloat, cellShadowOffsetHeight offsetHeight: CGFloat, cellShadowColor shadowColor: String, cellShadowRadius shadowRadius: CGFloat, cellShadowOpacity shadowOpacity: Float) {
        
        let cellImage: UIImageView = {
            
            let imageView = UIImageView()
            
            imageView.backgroundColor = .clear
            
            imageView.image = UIImage(named: image)
            
            // The below line of code maintains the aspect ratio of the image (no distrotion):
            
            imageView.contentMode = .scaleAspectFit
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
            
        }()
        
        let cellTitle: UILabel = {
            
            let label = UILabel()
            
            label.textColor = .init(hexString: textColour)
            
            label.font = UIFont(name: fontType, size: textSize)
            
            label.text = title
            
            label.numberOfLines = 0
            
            label.textAlignment = .center
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
            
        }()
        
        backgroundColor = .init(hexString: hexCode)
        
        layer.cornerRadius = radius
        
        layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        
        layer.shadowColor = UIColor.init(hexString: shadowColor).cgColor
        
        layer.shadowRadius = shadowRadius
        
        layer.shadowOpacity = shadowOpacity
        
        layer.masksToBounds = false
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        
        addSubview(cellImage)
        
        addSubview(cellTitle)
        
        NSLayoutConstraint.activate([
            
            cellTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cellTitle.leftAnchor.constraint(equalTo: leftAnchor),
            
            cellTitle.rightAnchor.constraint(equalTo: rightAnchor),
            
            cellTitle.topAnchor.constraint(equalTo: bottomAnchor, constant: -1 * (cellTextLabelHeight(cellTitleTextSize: textSize, cellTitleFontType: fontType, cellTitle: title))),
            
            cellImage.topAnchor.constraint(equalTo: topAnchor),
            
            cellImage.leftAnchor.constraint(equalTo: leftAnchor),
            
            cellImage.rightAnchor.constraint(equalTo: rightAnchor),
            
            cellImage.bottomAnchor.constraint(equalTo: topAnchor, constant: (self.frame.size.height) - (cellTextLabelHeight(cellTitleTextSize: textSize, cellTitleFontType: fontType, cellTitle: title)))
            
            ])
        
    }
    
    // The below function is needed in order to calculate the height of the cellLabel height based on its contents. Then this height is used to calulate the needed constraints for the cellLabel and cellImage:
    
    func cellTextLabelHeight(cellTitleTextSize textSize: CGFloat, cellTitleFontType fontType: String, cellTitle title: String) -> CGFloat {
        
        var currentHeight: CGFloat!
        
        let cellTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        cellTitle.text = title
        
        cellTitle.font = UIFont(name: fontType, size: textSize)
        
        cellTitle.numberOfLines = 0
        
        cellTitle.sizeToFit()
        
        cellTitle.lineBreakMode = .byWordWrapping
        
        currentHeight = cellTitle.frame.height
        
        cellTitle.removeFromSuperview()
        
        return currentHeight
        
    }
    
}

