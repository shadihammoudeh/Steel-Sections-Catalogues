//
//  SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/16/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UIViewController {
    
    // MARK: - Assigning protocol delegate:
    
    weak var delegate: PassingDataBackwardsFromSearchBarOptionsDropListPopoverVCToSteelSectionsTableVC?

    var userSelectedCollectionViewCellFromOpenRolledSteelSectionsCollectionViewController: Int = 0
    
    var userTypedCharactersInsideSteelSectionsTableViewControllerSearchBarField: String = ""
    
    var dropListOptionsTableViewInsidePopoverView = UITableView()
    
    var firstTwoCharactersUserTypedInsideOfSteelSectionsTableViewVCSearchBarTextField: String = ""
    
    var tableViewDataArray: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        setDataArrayToBeDisplayedInTableView()
            
        // Do any additional setup after loading the view.
                        
        // Below we code is where the data will be passed from the previous viewController (i.e. SteelSectionsTableViewController) to this VC depending on which collectionViewCell the user has selected (i.e. UB, UB, UBP, etc..) as well as what the user typed into the searchBar so far:

        configureTableView()
        
        view.backgroundColor = UIColor(named: "Search Bar Popover TableView Controller - VC Background Colour")
                
    }
    
    override func viewDidLayoutSubviews() {
        
        setUpConstraints()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // The below line of code is needed in order to de-select (i.e. remove highlight from cell) the previously select tableViewCell, once the tableView have been dismissed and displayed again:
        
        if let indexPath = self.dropListOptionsTableViewInsidePopoverView.indexPathForSelectedRow {
            
            dropListOptionsTableViewInsidePopoverView.deselectRow(at: indexPath, animated: true)
            
        }
        
    }
    
    func configureTableView() {
        
        dropListOptionsTableViewInsidePopoverView.dataSource = self
        
        dropListOptionsTableViewInsidePopoverView.delegate = self
                
        // The below line of code is needed in order to avoid displaying extra empty cells inside of our tableView:
        
        dropListOptionsTableViewInsidePopoverView.tableFooterView = UIView()
        
        dropListOptionsTableViewInsidePopoverView.isScrollEnabled = false
        
        // In order to have the cells inside of the tableView to automatically adjust their sizes depending on their contents. The first step is to have a rough estimate on how much the cell's height need to be. If the table contains variable height rows, it might be expensive to calculate all their heights when the table loads. Using estimation allows you to defer some of the cost of geometry calculation from load time to scrolling time. When you create a self-sizing table view cell, you need to set this property and use constraints to define the cell’s size:
        
        dropListOptionsTableViewInsidePopoverView.estimatedRowHeight = 50
        
        dropListOptionsTableViewInsidePopoverView.rowHeight = UITableView.automaticDimension
        
        dropListOptionsTableViewInsidePopoverView.backgroundColor = UIColor(named: "Search Bar Popover TableView Controller - TableView Background Colour")
        
        dropListOptionsTableViewInsidePopoverView.register(SearchBarPopoverTableViewCustomCell.self, forCellReuseIdentifier: "SearchBarPopoverTableViewCustomCell")
        
        view.addSubview(dropListOptionsTableViewInsidePopoverView)
        
    }
    
    func setUpConstraints() {
        
        dropListOptionsTableViewInsidePopoverView.pin(to: self.view, topAnchorConstant: 13, rightAnchorConstant: 0, bottomAnchorConstant: 0, leftAnchorConstant: 0)
        
    }
    
    func setDataArrayToBeDisplayedInTableView() {
        
        // The below code will be executed if the user selected Equal Angle Sections from the OpenRolledSteelSectionsCollectionVC:
        
        if userSelectedCollectionViewCellFromOpenRolledSteelSectionsCollectionViewController == 4 {
            
            if firstTwoCharactersUserTypedInsideOfSteelSectionsTableViewVCSearchBarTextField == "20" {
                
                tableViewDataArray = ["20 x ", "200 x "]
                
            }
            
        }
        
    }

}

extension SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The number of rows that need to be displayed inside the tableView depends on how many items are there inside of the tableViewCellLabelData array:
                
        return tableViewDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        // The reason we need to cast the below as! SearchBarPopoverTableViewCustomCell is to be able to get access to the methods inside of it:
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarPopoverTableViewCustomCell") as! SearchBarPopoverTableViewCustomCell
                
        let cellLabelTextContents = tableViewDataArray[indexPath.row]
        
        cell.set(textLabel: cellLabelTextContents)
        
        return cell
        
    }
    
}

extension SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        
        let sectionHeaderTextLabel = UILabel()
        
        sectionHeaderView.addSubview(sectionHeaderTextLabel)
        
        sectionHeaderTextLabel.text = "Available sections starting series:"
        
        sectionHeaderTextLabel.textColor = UIColor(named: "Search Bar Popover TableView Controller - Section Header Text Font Colour")
        
        sectionHeaderTextLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        
        sectionHeaderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            sectionHeaderTextLabel.topAnchor.constraint(equalTo: sectionHeaderView.topAnchor, constant: 5),
            
            sectionHeaderTextLabel.rightAnchor.constraint(equalTo: sectionHeaderView.rightAnchor, constant: -5),
            
            sectionHeaderTextLabel.bottomAnchor.constraint(equalTo: sectionHeaderView.bottomAnchor, constant: -5),
            
            sectionHeaderTextLabel.leftAnchor.constraint(equalTo: sectionHeaderView.leftAnchor, constant: 5)
        
        ])
        
        sectionHeaderView.backgroundColor = UIColor(named: "Search Bar Popover TableView Controller - Section Header Background Colour")
        
        return sectionHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.dataToBePassedBackwards(userSelectedTableViewCellContent: tableViewDataArray[indexPath.row])
        
        dismiss(animated: true, completion: {})
                
    }
    
}


