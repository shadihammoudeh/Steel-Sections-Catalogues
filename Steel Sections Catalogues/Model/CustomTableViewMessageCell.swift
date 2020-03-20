//
//  CustomTableViewMessageCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 13/10/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class CustomTableViewMessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        messageLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 19)
        
        messageLabel.textColor = UIColor(named: "Custom Table View Message Cell Text Font Colour")
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
