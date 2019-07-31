//
//  TrialButtonDropDown.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 28/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class TrialButtonDropDown: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        self.setTitle("Sort by:", for: .normal)
        
        self.setTitle("Pressed", for: .highlighted)
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    convenience init(dropDownButtonTarget: Any?, dropDownButtonSelector: Selector) {
        
        self.init()
        
        addTarget(dropDownButtonTarget, action: dropDownButtonSelector, for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
