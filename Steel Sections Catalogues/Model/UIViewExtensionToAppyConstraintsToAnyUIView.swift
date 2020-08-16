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
    
    func pin(to superView: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true

        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true

        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        
    }
    
}
