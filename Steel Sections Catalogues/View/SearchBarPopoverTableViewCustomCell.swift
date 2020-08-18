//
//  SearchBarPopoverTableViewCustomCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/17/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class SearchBarPopoverTableViewCustomCell: UITableViewCell {
    
    // The below represents the main component and the only one that will be included inside of our tableViewCell:
    
    var tableViewCellTextLabel: UILabel = UILabel()

    // The below method is not required when creating the UITableViewCell using XIB file (i.e. you have a storyboard), however, since in this case we are creating everything programmatically, therefore, it is required:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // Most likely whenever you override an init, you will need the below code as well:
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(tableViewCellTextLabel)
        
        configureTableViewCellTextLabel()
        
        setTableViewCellTextLabelConstraints()
        
    }
    
    // The below code is also required by Swift, if you do not include you will get a fatal error:
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // Below is the function required to set the customtableViewCell to display what we would like it to display:
    
    func set(textLabel: String) {
        
        tableViewCellTextLabel.text = textLabel
        
        tableViewCellTextLabel.textColor = UIColor(named: "Search Bar Popover TableView Controller - TableView Cell Text Font Colour")
        
        tableViewCellTextLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
    }
    
    // Below we will be configuring our textLabel:
    
    func configureTableViewCellTextLabel() {
        
        // The below code allows the text inside the label to occupy multiple lines if there is a need, rather than occupying only one line and trauncate the text which couldn't fit:
        
        tableViewCellTextLabel.numberOfLines = 0
        
    }
    
    func setTableViewCellTextLabelConstraints() {
        
        // For further information on the below used UIView method refer to "Extention - Pinning UIViews to their superviews quickly - Applying Constraints quickly":
        
        tableViewCellTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            tableViewCellTextLabel.topAnchor.constraint(equalTo: self.contentView.superview!.topAnchor, constant: 5),
            
            tableViewCellTextLabel.leftAnchor.constraint(equalTo: self.contentView.superview!.leftAnchor, constant: 8),
            
            tableViewCellTextLabel.bottomAnchor.constraint(equalTo: self.contentView.superview!.bottomAnchor, constant: -5),
            
            tableViewCellTextLabel.rightAnchor.constraint(equalTo: self.contentView.superview!.rightAnchor, constant: -8)
        
        ])
        
    }
    
}
