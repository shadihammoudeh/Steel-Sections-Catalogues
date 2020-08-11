//
//  File.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 10/3/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

protocol PassingDataBackwardsProtocol {
    
    func dataToBePassedUsingProtocol(modifiedArrayToBePassed: [SteelSectionParameters], sortBy: String, filtersApplied: Bool, isSearching: Bool)
    
}

