//
//  ProtocolToPassDataBackwardsWithTwoArrays.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 3/20/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

// Since "weak" references do not work in Swift unless a Protocol is declared as @obj. A workaround for this is to declare the type of the Protocol as AnyObject as illustrated below. Using AnyObject means that only Classes can conform to this Protocol, whereas Structs and/or Enums cannot. Remember that you only need to make the Protocol Delegate "weak" if it holds a reference to the delegator and you need to break that strong reference cycle. If the delegate holds no reference to the delegator, the delegate can go out of scole (as it is "weak") and you will have crashes and other problems:

// The prupose of using the "weak" keyword is to avoid Strong Reference Cycles (retain cycles). Strong reference cycles happen when two Class instances have strong references to each other. Their reference counts never go to zero so they never get de-allocated.

// You only need to use "weak" if the delegate is a Class. Swift Structs and Enums are value-types (their values are copied when a new instance is made), not reference-types, so they do not make Strong Reference Cycles.

// "weak" references are always optional (otherwise you would use "unowned") and always use "var" (not "let") so that the optional can be set to nil when it is de-allocated.

// A "parent-class" should naturally have a strong reference to its child-classes and thus, not use the "weak" keyword. When a child wants a reference to its parent though, it should make it a "weak" reference by using the "weak" keyword.

// As a general rule, delegates should be marked as "weak" because most delegates are referencing classes that they do not own. This is definitely true when a child is using a delegate to communicate with a parent. Using a "weak" reference for the delegate is what the documentation recommends.

protocol PassingDataBackwardsBetweenViewControllersProtocol: AnyObject {
    
    func dataToBePassedUsingProtocol(viewControllerDataIsSentFrom: String, filteringSlidersCleared: Bool, userLastSelectedCollectionViewCellNumber: Int, configuredArrayContainingSteelSectionsData: [SteelSectionParameters], configuredArrayContainingSteelSectionsSerialNumbersOnly: [String], configuredSortByVariable: String, configuredFiltersAppliedVariable: Bool, configuredIsSearchingVariable: Bool, exchangedUserSelectedTableCellSectionNumber: Int, exchangedUserSelectedTableCellRowNumber: Int)
    
}
