//
//  DropDownTableViewCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 03/08/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SortByDropdownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sortByTextLabel: UILabel!
    
    @IBOutlet weak var ascendingOrderButton: UIButton!
    
    @IBOutlet weak var descendingOrderButton: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
        sortByTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ascendingOrderButton.translatesAutoresizingMaskIntoConstraints = false
        
        descendingOrderButton.translatesAutoresizingMaskIntoConstraints = false
                        
        NSLayoutConstraint.activate([
            
            sortByTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            sortByTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            sortByTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
            ascendingOrderButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            ascendingOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
            ascendingOrderButton.leftAnchor.constraint(equalTo: sortByTextLabel.rightAnchor, constant: 10),
            
            descendingOrderButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            descendingOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
            descendingOrderButton.leftAnchor.constraint(equalTo: ascendingOrderButton.rightAnchor, constant: 10),
            
            
            ])
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}
