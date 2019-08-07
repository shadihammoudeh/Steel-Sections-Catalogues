//
//  PopoverViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 8/5/19.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SortDataPopOverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sortByTableView = UITableView()
    
    let cellId = "cellId"
    
    let sortByTableViewOptions = ["Section Designation","Depth, d","Width, b","Area of Section, A"]
    
    let sortByTableViewSections = ["Ascending Order by:", "Descending Order by:"]
    
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
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        
        sortByTableView.isScrollEnabled = false
        
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
        
        return cell
        
    }
    
}
