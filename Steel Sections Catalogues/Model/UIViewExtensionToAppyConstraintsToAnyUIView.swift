//
//  UIViewExtensionToAppyConstraintsToAnyUIView.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/16/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

// The below extension file will be imported into other Swift files to enable quick pinning of UIViews to its superview:

extension UIView {
    
    func pin(fixedToSuperViewTopAnchor: Bool, fixedToSuperViewRightAnchor: Bool, fixedToSuperViewBottomAnchor: Bool, fixedToSuperViewLeftAnchor: Bool, superViewTopAnchor: NSLayoutYAxisAnchor, superViewRightAnchor: NSLayoutXAxisAnchor, superViewBottomAnchor: NSLayoutYAxisAnchor, superViewLeftAnchor: NSLayoutXAxisAnchor, topAnchorConstant: CGFloat, rightAnchorConstant: CGFloat, bottomAnchorConstant: CGFloat, leftAnchorConstant: CGFloat, heightAnchorAssigned: Bool, heightAnchorConstant: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if fixedToSuperViewTopAnchor == true {
            
            topAnchor.constraint(equalTo: superViewTopAnchor, constant: topAnchorConstant).isActive = true
            
        }
        
        if fixedToSuperViewRightAnchor == true {
            
            rightAnchor.constraint(equalTo: superViewRightAnchor, constant: rightAnchorConstant).isActive = true
            
        }
        
        if fixedToSuperViewBottomAnchor == true {
            
            bottomAnchor.constraint(equalTo: superViewBottomAnchor, constant: bottomAnchorConstant).isActive = true
            
        }
        
        if fixedToSuperViewLeftAnchor == true {
            
            leftAnchor.constraint(equalTo: superViewLeftAnchor, constant: leftAnchorConstant).isActive = true
            
        }
        
        if heightAnchorAssigned == true {
            
            heightAnchor.constraint(equalToConstant: heightAnchorConstant).isActive = true
            
        }
            
    }
    
}
