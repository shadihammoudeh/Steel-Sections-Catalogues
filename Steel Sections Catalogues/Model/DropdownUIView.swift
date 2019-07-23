//
//  DropdownUIView.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 21/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class DropdownUIView: UIView, UITableViewDelegate, UITableViewDataSource {

    var dropdownItemsArray = ["First", "Second", "Third"]
    
    var dropdownTableView = UITableView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        dropdownTableView.delegate = self
        
        dropdownTableView.dataSource = self
        
        self.addSubview(dropdownTableView)
        
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            dropdownTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            dropdownTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            dropdownTableView.topAnchor.constraint(equalTo: self.topAnchor),
            
            dropdownTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dropdownItemsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropdownItemsArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(dropdownItemsArray[indexPath.row])
        
    }

}
