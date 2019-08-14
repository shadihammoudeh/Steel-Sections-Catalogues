//
//  PopoverViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/5/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

// The below Protocol is required in order to pass data backwards to the previous ViewController (i.e., BlueBookUniversalBeamsVC) as soon as this ViewController gets dismissed:

protocol PassDataBackToBlueBookUniversalBeamsVCDelegate {
    
    func popOverViewControllerWillDismiss(sortedArrayToBePassed: [IsectionsDimensionsParameters])
    
}

class SortDataPopOverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Here we are setting a delegate inside the SortDataPopOverVC in order to be able to access all the methods inside the Protocol:
    
    var delegate: PassDataBackToBlueBookUniversalBeamsVCDelegate?
    
    // The below Variable gets passed from the BlueBookUniversalBeamsVC as soon as this Popover gets displayed on screen:
    
    var passedUniversalBeamsDataArrayFromBlueBookUniversalBeamsVC = [IsectionsDimensionsParameters]()
    
    let sortByTableView = UITableView()
    
    let cellId = "cellId"
    
    let sortByTableViewOptions = ["Section Designation","Depth, d","Width, b","Area of Section, A"]
    
    let sortByTableViewSections = ["In Ascending Order by:", "In Descending Order by:"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("PopoverViewController viewDidLoad()")
        
        setupTableView()
        
        view.addSubview(sortByTableView)
        
        NSLayoutConstraint.activate([
            
            sortByTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            sortByTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            sortByTableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            ])
        
    }
    
    func setupTableView() {
        
        sortByTableView.isScrollEnabled = false
        
        sortByTableView.allowsMultipleSelection = false
        
        sortByTableView.dataSource = self
        
        sortByTableView.delegate = self
        
        // The below line of code removes empty cells from getting displayed inside the tableView:
        
        sortByTableView.tableFooterView = UIView()
        sortByTableView.translatesAutoresizingMaskIntoConstraints = false
        
        sortByTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        sortByTableView.rowHeight = UITableView.automaticDimension
        sortByTableView.estimatedRowHeight = 5
        
    }
    
    override func viewWillLayoutSubviews() {
        
        print("PopoverViewController viewWillLayoutSubviews()")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("PopoverViewController viewDidLayoutSubviews()")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("PopoverViewController viewWillAppear()")
        
        sortByTableView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: sortByTableView.contentSize.height).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("PopoverViewController viewDidAppear()")
        
        print("Total tableView height is equal to \(sortByTableView.frame.size.height)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("PopoverViewController viewWillDisappear")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("PopoverViewController viewDidDisappear")
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sortByTableViewSections[section]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sortByTableViewSections.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortByTableViewOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = sortByTableViewOptions[indexPath.row]
        
        cell.textLabel?.textColor = .black
        
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    // The below function handles tableView cell selections. One of the things it can do is exclusively assign the check-mark image (UITableViewCell.AccessoryType.checkmark) to one row in a section (radio-list style). This method isn’t called when the isEditing property of the table is set to true (that is, the table view is in editing mode):
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sortByTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch (indexPath.section, indexPath.row) {
            
        case (0, 0):
            
            print("Sort Data in Ascending Order by Section Designation")
            
        case (0, 1):
            
            print("Sort Data in Ascending Order by Depth, d")
            
        case (0, 2):
            
            print("Sort Data in Ascending Order by Width, b")
            
        case (0, 3):
            
            print("Sort Data in Ascending Order by Area of Section, A")
            
        case (1, 0):
            
            print("Sort Data in Descending Order by Section Designation")
            
            passedUniversalBeamsDataArrayFromBlueBookUniversalBeamsVC.sort {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber > $1.firstSectionSeriesNumber
                    
                } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                    
                    return $0.sectionSerialNumber > $1.sectionSerialNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber > $1.lastSectionSeriesNumber
                    
                }
                
            }
            
            if delegate != nil {
                delegate?.popOverViewControllerWillDismiss(sortedArrayToBePassed: passedUniversalBeamsDataArrayFromBlueBookUniversalBeamsVC)
                
            }
            
            print(passedUniversalBeamsDataArrayFromBlueBookUniversalBeamsVC)
                        
        case (1, 1):
            
            print("Sort Data in Descending Order by Depth, d")
            
        case (1, 2):
            
            print("Sort Data in Descending Order by Width, b")
            
        case (1, 3):
            
            print("Sort Data in Descending Order by Area of Section, A")
            
        case (_, _):
            
            print("Not in list of selection")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        sortByTableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
}
