//
//  SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/16/20.
//  Copyright © 2020 Bespoke Engineering. All rights reserved.
//

import UIKit

class SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UIViewController {

    var userLastSelectedCollectionViewCellReceivedFromSteelSectionsTableViewController: Int = 0
    
    var userTypedCharactersInsideSteelSectionsTableViewControllerSearchBarField: String = ""
    
    var dropListOptionsTableViewInsidePopoverView = UITableView()
    
    var tableViewCellLabelData: [String] = ["10 x ...", "100 x ..."]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
        
        // Below we code is where the data will be passed from the previous viewController (i.e. SteelSectionsTableViewController) to this VC depending on which collectionViewCell the user has selected (i.e. UB, UB, UBP, etc..) as well as what the user typed into the searchBar so far:

        configureTableView()
        
        view.backgroundColor = .yellow
        
    }
    
    override func viewDidLayoutSubviews() {
        
        setUpConstraints()
        
    }
    
    func configureTableView() {
        
        dropListOptionsTableViewInsidePopoverView.dataSource = self
        
        dropListOptionsTableViewInsidePopoverView.delegate = self
                
        // The below line of code is needed in order to avoid displaying extra empty cells inside of our tableView:
        
        dropListOptionsTableViewInsidePopoverView.tableFooterView = UIView()
        
        dropListOptionsTableViewInsidePopoverView.isScrollEnabled = false
        
        // In order to have the cells inside of the tableView to automatically adjust their sizes depending on their contents. The first step is to have a rough estimate on how much the cell's height need to be. If the table contains variable height rows, it might be expensive to calculate all their heights when the table loads. Using estimation allows you to defer some of the cost of geometry calculation from load time to scrolling time. When you create a self-sizing table view cell, you need to set this property and use constraints to define the cell’s size:
        
        dropListOptionsTableViewInsidePopoverView.estimatedRowHeight = 25
        
        dropListOptionsTableViewInsidePopoverView.rowHeight = UITableView.automaticDimension
        
        dropListOptionsTableViewInsidePopoverView.backgroundColor = UIColor.red
        
        dropListOptionsTableViewInsidePopoverView.register(SearchBarPopoverTableViewCustomCell.self, forCellReuseIdentifier: "SearchbarPopoverTableViewCustomCell")
        
        view.addSubview(dropListOptionsTableViewInsidePopoverView)
        
    }
    
    func setUpConstraints() {
        
        dropListOptionsTableViewInsidePopoverView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            dropListOptionsTableViewInsidePopoverView.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            
            dropListOptionsTableViewInsidePopoverView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            dropListOptionsTableViewInsidePopoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dropListOptionsTableViewInsidePopoverView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        ])
        
    }

}

extension SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The number of rows that need to be displayed inside the tableView depends on how many items are there inside of the tableViewCellLabelData array:
        
        return tableViewCellLabelData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // The reason we need to cast the below as! SearchBarPopoverTableViewCustomCell is to be able to get access to the methods inside of it:
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchbarPopoverTableViewCustomCell") as! SearchBarPopoverTableViewCustomCell
        
        let cellLabelTextContents = tableViewCellLabelData[indexPath.row]
        
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
        
        sectionHeaderTextLabel.pin(to: sectionHeaderView)
        
        sectionHeaderView.backgroundColor = UIColor(named: "Search Bar Popover TableView Controller - Section Header Background Colour")
        
        return sectionHeaderView
        
    }
    
}


