//
//  SortByPopUpVCViewController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 28/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SortByPopOverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewSectionsArray = ["Ascending Order by:","Descending Order by:"]
    
    var tableViewRowsInsideSectionsArray = ["Section Designation","Depth, h","Width, b","Area of Section, A"]
    
    var sortByTableView = UITableView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.alpha = 0.8
        
        sortByTableView.delegate = self
        
        sortByTableView.dataSource = self
        
        sortByTableView.translatesAutoresizingMaskIntoConstraints = false
        
        sortByTableView.register(SortByMenuTableViewCell.self, forCellReuseIdentifier: "customCell")
        
        sortByTableView.isScrollEnabled = false
        
        sortByTableView.backgroundColor = .yellow
        
        view.addSubview(sortByTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        //        popOverTable.frame = CGRect(x: popOverTable.frame.origin.x, y: popOverTable.frame.origin.y, width: popOverTable.frame.size.width, height: popOverTable.contentSize.height)
        
        NSLayoutConstraint.activate([
            
            sortByTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            sortByTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            
            sortByTableView.widthAnchor.constraint(equalToConstant: 220),
            
            sortByTableView.bottomAnchor.constraint(equalTo: sortByTableView.topAnchor, constant: sortByTableView.contentSize.height)
            
            ])
        
        sortByTableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewRowsInsideSectionsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sortByTableView.dequeueReusableCell(withIdentifier: "customCell") as! SortByMenuTableViewCell
        
        cell.cellTextLabel.text = tableViewRowsInsideSectionsArray[indexPath.row]
        
        cell.cellTextLabel.textColor = .black
        
        cell.cellTextLabel.backgroundColor = .blue
                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
