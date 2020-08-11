//
//  LegSteelSectionCustomTableViewCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 5/24/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class LegSteelSectionCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var steelAngleSectionDesignationLabel: UILabel!
    
    @IBOutlet weak var steelAngleDepthLabel: UILabel!
    
    @IBOutlet weak var steelAngleWidthLabel: UILabel!
    
    @IBOutlet weak var steelAngleThicknessLabel: UILabel!
    
    @IBOutlet weak var steelAngleMassPerMetre: UILabel!
    
    @IBOutlet weak var steelAngleSectionArea: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
        steelAngleSectionDesignationLabel.textColor = UIColor(named: "Table View Sections Header Background Colour")
        
        steelAngleSectionDesignationLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
