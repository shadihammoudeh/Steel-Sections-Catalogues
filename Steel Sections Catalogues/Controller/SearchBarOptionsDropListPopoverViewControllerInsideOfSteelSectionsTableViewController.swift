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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.

        setUpTableView()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        setUpConstraints()
        
    }
    
    func setUpTableView() {
        
        dropListOptionsTableViewInsidePopoverView.dataSource = self
        
        dropListOptionsTableViewInsidePopoverView.delegate = self
        
        dropListOptionsTableViewInsidePopoverView.translatesAutoresizingMaskIntoConstraints = false
        
        // The below line of code is needed in order to avoid displaying extra empty cells inside of our tableView:
        
        dropListOptionsTableViewInsidePopoverView.tableFooterView = UIView()
        
        dropListOptionsTableViewInsidePopoverView.isScrollEnabled = false
        
        dropListOptionsTableViewInsidePopoverView.backgroundColor = UIColor.red
        
//        dropListOptionsTableViewInsidePopoverView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        
        view.addSubview(dropListOptionsTableViewInsidePopoverView)
        
    }
    
    func setUpConstraints() {
        
        dropListOptionsTableViewInsidePopoverView.pin(to: view)
        
    }

}

extension SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
    }
    
}

extension SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController: UITableViewDelegate {
    
    
    
}


