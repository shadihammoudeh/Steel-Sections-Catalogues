//
//  dropdownUIButton.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 21/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class DropdownUIButton: UIButton {
    
    var dropdownView = DropdownUIView()
    
    var dropdownViewHeight = NSLayoutConstraint()
    
    var isOpen = false

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.darkGray
        
        dropdownView = DropdownUIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        dropdownView.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle("Sort by: ", for: .normal)
        
    }
    
    override func didMoveToSuperview() {
        
        self.superview?.addSubview(dropdownView)
        
        self.superview?.bringSubviewToFront(dropdownView)
        
        dropdownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        dropdownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        dropdownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        dropdownViewHeight = dropdownView.heightAnchor.constraint(equalToConstant: 0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.dropdownViewHeight])
            
            self.dropdownViewHeight.constant = 150
            
            NSLayoutConstraint.activate([self.dropdownViewHeight])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                
                self.dropdownView.layoutIfNeeded()
                
                self.dropdownView.center.y += self.dropdownView.frame.height / 2
                
            }, completion: nil)
            
        } else {
            
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.dropdownViewHeight])
            
            self.dropdownViewHeight.constant = 0
            
            NSLayoutConstraint.activate([self.dropdownViewHeight])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                
                self.dropdownView.center.y -= self.dropdownView.frame.height / 2

                
                self.dropdownView.layoutIfNeeded()
                

                
            }, completion: nil)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    
}
