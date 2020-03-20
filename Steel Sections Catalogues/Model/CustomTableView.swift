//
//  CustomTableView.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(tableViewBackgroundColourHexCode: String, tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, tableViewCustomCellClassToBeRegistered: AnyClass?, tableViewCustomCellReuseIdentifierToBeRegistered: String) {
        
        self.init()
        
        setupEssentialTableViewProperties(tableViewDelegate: tableViewDelegate, tableViewDataSource: tableViewDataSource, tableViewCellClassToBeRegistered: tableViewCustomCellClassToBeRegistered, tableViewCellReuseIdentifierToBeRegistered: tableViewCustomCellReuseIdentifierToBeRegistered, tableViewBackgroundColourHexCode: tableViewBackgroundColourHexCode)
        
    }
    
    func setupEssentialTableViewProperties(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, tableViewCellClassToBeRegistered cellClassRegister: AnyClass?, tableViewCellReuseIdentifierToBeRegistered forCelReuseIdentifierRegister: String, tableViewBackgroundColourHexCode: String) {
        
        backgroundColor = UIColor(hexString: tableViewBackgroundColourHexCode)
        
        delegate = tableViewDelegate
        
        dataSource = tableViewDataSource
        
        separatorColor = UIColor.brown
        
        // The below codes are used to figure out the required TableView Cell height. If the table contains variable height rows, it might be expensive to calculate all their heights when the table loads. Using estimation allows you to defer some of tje cost of geometry calculation from load time to scrolling time.
        
        estimatedRowHeight = 120
        
        rowHeight = UITableView.automaticDimension
        
        // Since we are defining the whole TableView programmatically rather than using Storyboards, we need to register the custom cell we would like to use for our custom table before we can use it:
        
        register(cellClassRegister.self, forCellReuseIdentifier: forCelReuseIdentifierRegister)
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
        
}
