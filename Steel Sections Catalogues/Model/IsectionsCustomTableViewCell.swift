//
//  IsectionsCustomTableViewCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class IsectionsCustomTableViewCell: UITableViewCell {
    
    let sectionDesignationLabelTopPadding: CGFloat = 5
    
    let sectionDesignationLabelLeftPadding: CGFloat = 5
    
    let sectionDesignationLabelRightPadding: CGFloat = 5
    
    let depthOfSectionLabelTopPadding: CGFloat = 2.50
    
    let depthOfSectionLabelLeftPadding: CGFloat = 5
    
    let depthOfSectionLabelRightPadding: CGFloat = 1.25
    
    let webThicknessLabelTopPadding: CGFloat = 2.50
    
    let webThicknessLabelLeftPadding: CGFloat = 5
    
    let webThicknessLabelRightPadding: CGFloat = 1.25
    
    let widthOfSectionLabelTopPadding: CGFloat = 2.50
    
    let widthOfSectionLabelLeftPadding: CGFloat = 1.25
    
    let widthOfSectionLabelRightPadding: CGFloat = 5
    
    let sectionFlangeThicknessLabelTopPadding: CGFloat = 2.5
    
    let sectionFlangeThicknessLabelLeftPadding: CGFloat = 1.25
    
    let sectionFlangeThicknessLabelRightPadding: CGFloat = 5
    
    let sectionMassPerMetreLabelTopPadding: CGFloat = 2.50
    
    let sectionMassPerMetreLabelLeftPadding: CGFloat = 5
    
    let sectionMassPerMetreLabelRightPadding: CGFloat = 1.25
    
    let sectionMassPerMetreLabelBottomPadding: CGFloat = 5
    
    let areaOfSectionLabelTopPadding: CGFloat = 2.50
    
    let areaOfSectionLabelRightPadding: CGFloat = 5
    
    let areaOfSectionLabelLeftPadding: CGFloat = 1.25
    
    var sectionDesignationLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //        label.backgroundColor = UIColor.yellow
        
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        return label
        
    }()
    
    var depthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        //        label.backgroundColor = UIColor.blue
        
        label.textAlignment = .left
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        return label
        
    }()
    
    var widthOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.textAlignment = .left
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        //        label.backgroundColor = UIColor.gray
        
        return label
        
    }()
    
    var sectionWebThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        //        label.backgroundColor = UIColor.cyan
        
        label.textAlignment = .left
        
        label.numberOfLines = 0
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        return label
        
    }()
    
    var sectionFlangeThicknessLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.numberOfLines = 0
        
        label.textAlignment = .left
        
        //        label.backgroundColor = UIColor.green
        
        return label
        
    }()
    
    var sectionMassPerMetreLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.numberOfLines = 0
        
        label.textAlignment = .left
        
        //        label.backgroundColor = UIColor.white
        
        return label
        
    }()
    
    var areaOfSectionLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(hexString: "#F27E63")
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.numberOfLines = 0
        
        label.textAlignment = .left
        
        //        label.backgroundColor = UIColor.white
        
        return label
        
    }()
    
    // When you register or call this table view cell later it is going to go ahead and call this initialiser for you and this is where we are going to set out our constraints:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(sectionDesignationLabel)
        
        contentView.addSubview(depthOfSectionLabel)
        
        contentView.addSubview(sectionWebThicknessLabel)
        
        contentView.addSubview(widthOfSectionLabel)
        
        contentView.addSubview(sectionFlangeThicknessLabel)
        
        contentView.addSubview(sectionMassPerMetreLabel)
        
        contentView.addSubview(areaOfSectionLabel)
        
        applyAppropriateSizeAndConstraintsForCellItems()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        print(depthOfSectionLabel.frame.width)
        
        print("depthOfSection Label width \(depthOfSectionLabel.frame.size.width)")
        
    }
    
    func applyAppropriateSizeAndConstraintsForCellItems() {
        
        NSLayoutConstraint.activate([
            
            sectionDesignationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sectionDesignationLabelTopPadding),
            
            sectionDesignationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: sectionDesignationLabelLeftPadding),
            
            sectionDesignationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1*sectionDesignationLabelRightPadding),
            
            depthOfSectionLabel.topAnchor.constraint(equalTo: sectionDesignationLabel.bottomAnchor, constant: depthOfSectionLabelTopPadding),
            
            depthOfSectionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: depthOfSectionLabelLeftPadding),
            
            depthOfSectionLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -1 * depthOfSectionLabelRightPadding),
            
            widthOfSectionLabel.topAnchor.constraint(equalTo: sectionDesignationLabel.bottomAnchor, constant: widthOfSectionLabelTopPadding),
            
            widthOfSectionLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: widthOfSectionLabelLeftPadding),
            
            widthOfSectionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * widthOfSectionLabelRightPadding),
            
            widthOfSectionLabel.bottomAnchor.constraint(equalTo: depthOfSectionLabel.bottomAnchor),
            
            sectionWebThicknessLabel.topAnchor.constraint(equalTo: depthOfSectionLabel.bottomAnchor, constant: webThicknessLabelTopPadding),
            
            sectionWebThicknessLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: webThicknessLabelLeftPadding),
            
            sectionWebThicknessLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -1 * webThicknessLabelRightPadding),
            
            sectionFlangeThicknessLabel.topAnchor.constraint(equalTo: widthOfSectionLabel.bottomAnchor, constant: sectionFlangeThicknessLabelTopPadding),
            
            sectionFlangeThicknessLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: sectionFlangeThicknessLabelLeftPadding),
            
            sectionFlangeThicknessLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * sectionFlangeThicknessLabelRightPadding),
            
            sectionFlangeThicknessLabel.bottomAnchor.constraint(equalTo: sectionWebThicknessLabel.bottomAnchor),
            
            sectionMassPerMetreLabel.topAnchor.constraint(equalTo: sectionWebThicknessLabel.bottomAnchor, constant: sectionMassPerMetreLabelTopPadding),
            
            sectionMassPerMetreLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: sectionMassPerMetreLabelLeftPadding),
            
            sectionMassPerMetreLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -1 * sectionMassPerMetreLabelRightPadding),
            
            sectionMassPerMetreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * sectionMassPerMetreLabelBottomPadding),
            
            areaOfSectionLabel.topAnchor.constraint(equalTo: sectionFlangeThicknessLabel.bottomAnchor, constant: areaOfSectionLabelTopPadding),
            
            areaOfSectionLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: areaOfSectionLabelLeftPadding),
            
            areaOfSectionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * areaOfSectionLabelRightPadding),
            
            areaOfSectionLabel.bottomAnchor.constraint(equalTo: sectionMassPerMetreLabel.bottomAnchor)
            
            ])
        
    }
    
}

