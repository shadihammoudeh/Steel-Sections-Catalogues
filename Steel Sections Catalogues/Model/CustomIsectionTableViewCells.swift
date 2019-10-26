//
//  customIsectionTableViewCells.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 10/11/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class CustomIsectionTableViewCells: UITableViewCell {
    
    @IBOutlet weak var sectionDesignationLabel: UILabel!
    
    @IBOutlet weak var depthOfSectionLabel: UILabel!
    
    @IBOutlet weak var widthOfSectionLabel: UILabel!
    
    @IBOutlet weak var flangeThicknessLabel: UILabel!
    
    @IBOutlet weak var webThicknessLabel: UILabel!
    
    @IBOutlet weak var massPerMetreLabel: UILabel!
    
    @IBOutlet weak var areaOfSectionLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}
