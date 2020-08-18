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
    
    func pin(to superView: UIView, topAnchorConstant: CGFloat, rightAnchorConstant: CGFloat, bottomAnchorConstant: CGFloat, leftAnchorConstant: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            topAnchor.constraint(equalTo: superView.topAnchor, constant: topAnchorConstant),
            
            rightAnchor.constraint(equalTo: superView.rightAnchor, constant: rightAnchorConstant),
            
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottomAnchorConstant),
            
            leftAnchor.constraint(equalTo: superView.leftAnchor, constant: leftAnchorConstant)
        
        ])
        
    }
    
}
