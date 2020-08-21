//
//  PopoverViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/5/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class TableViewSteelSectionsSortByOptionsPopoverViewController: UIViewController {
    
    // MARK: - Assigning protocol delegate:
    
    // Here we are setting a delegate inside this View Controller in order to be able to access all the methods inside the Protocol. Notice that the delegate is defined as a "weak" one, as in most cases you do not want a child object maintaining a string reference to a parent object:

    weak var delegate: PassingDataBackwardsBetweenViewControllersProtocol?

    // MARK: - Instance scope variables and constants declarations:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will get their values from the previous viewController (i.e. SteelSectionsTableViewController), and when this ViewController gets dismissed, any made changes to these variables will be sent back again to SteelSectionsTableViewController using the Protocol:
    
    var sortBy: String = "None"

    var isSearching: Bool = false

    var filtersApplied: Bool = false
    
    var receivedSteelSectionsDataArrayFromSteelSectionsTableViewController = [SteelSectionParameters]()
    
    // Below we are creating an instance from the UIPickerView class:
    
    let sortDataByPickerView = UIPickerView()
    
    // Below we are creating an instance from the UIToolbar class, the tool bar is going to host the Apply button, which when the user taps on the data inside the table will be sorted:
    
    let toolBar = UIToolbar()
    
    // The below two arrays represent the items to be displayed inside the UIPickerView components (i.e., columns):
    
    let sortDataByPickerViewComponentZeroArray = ["Ascending Order:", "Descending Order:"]
    
    let sortDataByPickerViewComponentOneArray = ["Section Designation","Depth, d","Width, b","Area of Section, A"]
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        setupPickerView()
        
        setupToolBar()
        
        // MARK: - Adding subViews and assigning their constraints:
        
        view.addSubview(sortDataByPickerView)
        
        view.addSubview(toolBar)
        
        NSLayoutConstraint.activate([
            
            toolBar.topAnchor.constraint(equalTo: view.topAnchor),

            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),

            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            sortDataByPickerView.topAnchor.constraint(equalTo: toolBar.bottomAnchor),

            sortDataByPickerView.rightAnchor.constraint(equalTo: view.rightAnchor),

            sortDataByPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            sortDataByPickerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
        ])
        
    }
    
    func setupPickerView() {
        
        sortDataByPickerView.backgroundColor = UIColor(named: "SortBy Popover VC - PickerView Background Colour")
        
        sortDataByPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        sortDataByPickerView.delegate = self
        
    }
    
    func setupToolBar() {
        
        // The below line of code will change the colour of the Tool Bar:
        
        toolBar.barTintColor = UIColor(named: "SortBy Popover VC - Top Toolbar Background Colour")
        
        toolBar.sizeToFit()
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
                
        doneButton.contentHorizontalAlignment = .left
        
        doneButton.contentEdgeInsets.top = 11
        
        doneButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        
        doneButton.setTitle("Apply", for: .normal)
        
        doneButton.setTitleColor(UIColor(named: "SortBy Popover VC - Top Toolbar Apply Button Text Colour - Normal"), for: .normal)
        
        doneButton.setTitleColor(UIColor(named: "SortBy Popover VC - Top Toolbar Apply Button Text Colour - Highlighted State"), for: .highlighted)
        
        doneButton.addTarget(self, action: #selector(toolBarButtonPressed(sender:)), for: .touchUpInside)
        
        let doneButtonBarItem = UIBarButtonItem(customView: doneButton)
                        
        toolBar.setItems([doneButtonBarItem], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // MARK: - ToolBar button pressed (i.e., Apply button):
    
    // The below function will be triggered when the user taps on the Apply button contained inside the ToolBar. It is going to check the sort criteria the user is after and send the sorted Array back to the previous ViewController (i.e., SteelSectionsTableViewController) in order to display data accordingly:
    
    @objc func toolBarButtonPressed(sender: UIBarButtonItem) {
        
        switch (sortDataByPickerView.selectedRow(inComponent: 0), sortDataByPickerView.selectedRow(inComponent: 1)) {
            
        // MARK: - PickerView switch case for Sorting data inside Array by Section Designation in Ascending Order:
            
        case (0, 0):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                    
                } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                    
                    return $0.sectionSerialNumber < $1.sectionSerialNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                    
                }
                
            }
                                            
                delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Section Designation in ascending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Depth of Section in Ascending Order:
            
        case (0, 1):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionTotalDepth != $1.sectionTotalDepth {
                    
                    return $0.sectionTotalDepth < $1.sectionTotalDepth
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber < $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Depth of Section in ascending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Width of Section in Ascending Order:
            
        case (0, 2):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionWidth != $1.sectionWidth {
                    
                    return $0.sectionWidth < $1.sectionWidth
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber < $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Width of Section in ascending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Area of Section in Ascending Order:
            
        case(0, 3):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionArea != $1.sectionArea {
                    
                    return $0.sectionArea < $1.sectionArea
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber < $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Section Area in ascending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Section Designation in Descending Order:
            
        case(1, 0):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                    
                } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                    
                    return $0.sectionSerialNumber > $1.sectionSerialNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Section Designation in descending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
        
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Depth of Section in Descending Order:
            
        case(1, 1):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionTotalDepth != $1.sectionTotalDepth {
                    
                    return $0.sectionTotalDepth > $1.sectionTotalDepth
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber > $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Depth of Section in descending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
                                    
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Width of Section in Descending Order:
            
        case(1, 2):
                        
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionWidth != $1.sectionWidth {
                    
                    return $0.sectionWidth > $1.sectionWidth
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber > $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Width of Section in descending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Area of Section in Descending Order:

        case(1, 3):
            
            receivedSteelSectionsDataArrayFromSteelSectionsTableViewController.sort {
                
                if $0.sectionArea != $1.sectionArea {
                    
                    return $0.sectionArea > $1.sectionArea
                    
                } else {
                    
                    if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                        
                        return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                        
                    } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                        
                        return $0.sectionSerialNumber > $1.sectionSerialNumber
                        
                    } else {
                        
                        return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                        
                    }
                    
                }
                
            }
            
            delegate?.dataToBePassedUsingProtocol(datComingFromViewController: "TableViewSteelSectionsSortByOptionsPopoverViewController", configuredArrayContainingSteelSectionsData: receivedSteelSectionsDataArrayFromSteelSectionsTableViewController, configuredArrayContainingSteelSectionsSerialNumbersOnly: [""], configuredSortByVariable: "Sorted by: Section Area in descending order", configuredFiltersAppliedVariable: false, configuredIsSearchingVariable: false, exchangedUserSelectedTableCellSectionNumber: 0, exchangedUserSelectedTableCellRowNumber: 0)
            
            dismiss(animated: true, completion: {})

        case (_, _):
            
            print("Not in list of selection")
            
        }
        
    }
    
}

// MARK: - Extensions for UIPickerView:

// It is considered to be a good code practice to place the Delegates and Datasoure protocols required for each element such as UIPickerView and UITableView in their own extension. As this makes things easier to read and easier to figure out where the bugs occured:

extension TableViewSteelSectionsSortByOptionsPopoverViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // The below Method is needed in order to tell the pickerView how many columns it should display. In this case we need two columns, as one column will be used to let the user select whether to sort the data in Ascending or Descending order. And the second column is going to be used to let the user select the data sort criteria such as; Section Designation, Section Area, etc.:
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return sortDataByPickerViewComponentZeroArray.count
            
        } else {
            
            return sortDataByPickerViewComponentOneArray.count
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return sortDataByPickerViewComponentZeroArray[row]
            
        } else {
            
            return sortDataByPickerViewComponentOneArray[row]
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    // The below function allows us to modify the text colour and font for the text to be displayed inside the pickerView components:
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        
        if let view = view as? UILabel {
            
            label = view
            
        } else {
            
            label = UILabel()
            
        }
        
        label.textColor = UIColor(named: "SortBy Popover VC - PickerView Items Text Colour")
        
        label.textAlignment = .center
        
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
        if component == 0 {
            label.text = sortDataByPickerViewComponentZeroArray[row]
            
        } else if component == 1 {
            
            label.text = sortDataByPickerViewComponentOneArray[row]
            
        }
        
        return label
        
    }
    
}
