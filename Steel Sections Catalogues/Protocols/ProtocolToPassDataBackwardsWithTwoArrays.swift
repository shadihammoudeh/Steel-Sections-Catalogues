//
//  ProtocolToPassDataBackwardsWithTwoArrays.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 3/20/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

protocol ProtocolToPassDataBackwardsWithTwoArrays {
    
    func dataToBePassedUsingProtocol(modifiedArrayContainingAllUBsDataToBePassed: [IsectionsDimensionsParameters], modifiedArrayContainingSectionSerialNumbersDataToBePassed: [String], sortBy: String, filtersApplied: Bool, isSearching: Bool)
    
}
