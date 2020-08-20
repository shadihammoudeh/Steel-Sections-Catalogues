//
//  PassingDataBackwardsFromSearchBarOptionsDropListPopoverVCToSteelSectionsTableVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/20/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import Foundation

protocol PassingDataBackwardsFromSearchBarOptionsDropListPopoverVCToSteelSectionsTableVC: AnyObject {
    
    func dataToBePassedBackwards(userSelectedTableViewCellContent: String)
    
}
