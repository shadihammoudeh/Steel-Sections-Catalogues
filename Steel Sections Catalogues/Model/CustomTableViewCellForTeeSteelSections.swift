//
//  CustomTableViewCellForTeeSteelSections.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/12/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class CustomTableViewCellForTeeSteelSections: UITableViewCell {

    @IBOutlet weak var actualSectionDesignationLabel: UILabel!
    
    @IBOutlet weak var crossSectionTeeSectionCutFromLabel: UILabel!
    
    @IBOutlet weak var depthOfSectionLabel: UILabel!
    
    @IBOutlet weak var widthOfSectionLabel: UILabel!
    
    @IBOutlet weak var sectionFlangeSectionLabel: UILabel!
    
    @IBOutlet weak var sectionWebThicknessLabel: UILabel!
    
    @IBOutlet weak var sectionMassPerMetreLabel: UILabel!
    
    @IBOutlet weak var sectionAreaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
