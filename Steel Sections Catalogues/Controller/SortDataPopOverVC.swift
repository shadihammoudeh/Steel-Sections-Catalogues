//
//  PopoverViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/5/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class SortDataPopOverVC: UIViewController {
    
    // MARK: - Assigning protocol delegate:
    
    // Here we are setting a delegate inside the SortDataPopOverVC in order to be able to access all the methods inside the Protocol:
    
    var delegate: PassingDataBackwardsProtocol?
    
    // MARK: - Instance scope variables and constants declarations:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed from BlueBookUniversalBeamsVC, and when this ViewController gets dismissed, any made changes to these variables will be sent back to BlueBookUniversalBeamsVC using the Protocol:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    var universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC = [IsectionsDimensionsParameters]()
    
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
        
        print("PopoverViewController viewDidLoad()")
        
        setupPickerView()
        
        setupToolBar()
        
        // MARK: - Adding subViews and assigning their constraints:
        
        view.addSubview(sortDataByPickerView)
        
        view.addSubview(toolBar)
        
        NSLayoutConstraint.activate([
            
            toolBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            toolBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            toolBar.topAnchor.constraint(equalTo: view.topAnchor),
            
            sortDataByPickerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            sortDataByPickerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            sortDataByPickerView.topAnchor.constraint(equalTo: toolBar.bottomAnchor),
            
            sortDataByPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func setupPickerView() {
        
        sortDataByPickerView.backgroundColor = UIColor(hexString: "#0D0D0D")
        
        sortDataByPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        sortDataByPickerView.delegate = self
        
    }
    
    func setupToolBar() {
        
        // The below line of code will change the colour of the Tool Bar:
        
        toolBar.barTintColor = UIColor(hexString: "#737373")
        
        // The below line of code will adjust the colour of the text inside the Tool Bar:
        
        toolBar.tintColor = UIColor(hexString: "#262626")
        
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(toolBarButtonPressed(sender:)))
        
        toolBar.setItems([doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // MARK: - ToolBar button pressed (i.e., Apply button):
    
    // The below function will be triggered when the user taps on the Apply button contained inside the ToolBar. It is going to check the sort criteria the user is after and send the sorted Array back to the previous ViewController (i.e., BlueBookUniversalBeamsVC) in order to display data accordingly:
    
    @objc func toolBarButtonPressed(sender: UIBarButtonItem) {
        
        switch (sortDataByPickerView.selectedRow(inComponent: 0), sortDataByPickerView.selectedRow(inComponent: 1)) {
            
        // MARK: - PickerView switch case for Sorting data inside Array by Section Designation in Ascending Order:
            
        case (0, 0):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                    
                } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                    
                    return $0.sectionSerialNumber < $1.sectionSerialNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                    
                }
                
            }
            
            if delegate != nil {
                                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Section Designation in ascending order", filtersApplied: false, isSearching: false)
                                
            }
                        
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Depth of Section in Ascending Order:
            
        case (0, 1):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.depthOfSection != $1.depthOfSection {
                    
                    return $0.depthOfSection < $1.depthOfSection
                    
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
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Depth of Section in ascending order", filtersApplied: false, isSearching: false)
               
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Width of Section in Ascending Order:
            
        case (0, 2):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.widthOfSection != $1.widthOfSection {
                    
                    return $0.widthOfSection < $1.widthOfSection
                    
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
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Width of Section in ascending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Area of Section in Ascending Order:
            
        case(0, 3):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.areaOfSection != $1.areaOfSection {
                    
                    return $0.areaOfSection < $1.areaOfSection
                    
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
            
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Section Area in ascending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Section Designation in Descending Order:
            
        case(1, 0):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                    
                } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                    
                    return $0.sectionSerialNumber > $1.sectionSerialNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                    
                }
                
            }
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Section Designation in descending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Depth of Section in Descending Order:
            
        case(1, 1):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.depthOfSection != $1.depthOfSection {
                    
                    return $0.depthOfSection > $1.depthOfSection
                    
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
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Depth of Section in descending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Width of Section in Descending Order:
            
        case(1, 2):
                        
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.widthOfSection != $1.widthOfSection {
                    
                    return $0.widthOfSection > $1.widthOfSection
                    
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
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Width of Section in descending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})
            
        // MARK: - PickerView switch case for Sorting data inside Array by Area of Section in Descending Order:

        case(1, 3):
            
            universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC.sort {
                
                if $0.areaOfSection != $1.areaOfSection {
                    
                    return $0.areaOfSection > $1.areaOfSection
                    
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
            
            if delegate != nil {
                
                delegate?.dataToBePassedUsingProtocol(modifiedArrayToBePassed: universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC, sortBy: "Sorted by: Section Area in descending order", filtersApplied: false, isSearching: false)
                
            }
            
            dismiss(animated: true, completion: {})

        case (_, _):
            
            print("Not in list of selection")
            
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        
        print("PopoverViewController viewWillLayoutSubviews()")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("PopoverViewController viewDidLayoutSubviews()")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("PopoverViewController viewWillAppear()")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("PopoverViewController viewDidAppear()")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("PopoverViewController viewWillDisappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("PopoverViewController viewDidDisappear")
        
    }
    
}

// MARK: - Extensions for UIPickerView:

// It is considered to be a good code practice to place the Delegates and Datasoure protocols required for each element such as UIPickerView and UITableView in their own extension. As this makes things easier to read and easier to figure out where the bugs occured:

extension SortDataPopOverVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        
        label.textColor = UIColor(hexString: "#F2F2F2")
        
        label.textAlignment = .center
        
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        
        if component == 0 {
            label.text = sortDataByPickerViewComponentZeroArray[row]
            
        } else if component == 1 {
            
            label.text = sortDataByPickerViewComponentOneArray[row]
            
        }
        
        return label
        
    }
    
}
