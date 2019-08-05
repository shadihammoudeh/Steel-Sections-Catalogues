//
//  MakeDropDown.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 03/08/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import Foundation

import UIKit

protocol DropdownCustomViewDataSourceProtocol {
    
    // Below are the functions that are needed for the DropdownCustomViewDataSourceProtocol:
    // dropdownTableViewCellClass in the below code lines identify the Xib (i.e., SortByDropdownTableViewCell Class) to be displayed inside the dropdown tableView once the user clicks on the Sort By button:
    // indexPos in the below code lines refer to the indexPath.row, basically used in order to identify which cell inside the dropdown tableView is currently in use:
    
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, dropdownTableViewCellClass: String)
    
    func numberOfRows(dropdownTableViewCellClass: String) -> Int
    
    // Optional Method for item selection
    
    func selectItemInDropdownView(indexPos: Int, dropdownTableViewCellClass: String)
    
}

extension DropdownCustomViewDataSourceProtocol {
    
    func selectItemInDropdown(indexPos: Int, dropdownTableViewCellClass: String) {}
    
}

class DropdownCustomView: UIView {
    
    //MARK: Variables
    
    // The dropdownTableViewCellClass is to differentiate if you are using multiple Xibs which contain the information related to the cells to be displayed inside the dropdown tableView cells:
    
    var dropdownTableViewCellClass: String = "DROP_DOWN"
    
    // dropdownTableViewCellReusableIdentifier of your custom cell
    
    var dropdownTableViewCellReusableIdentifier: String = "DROP_DOWN_CELL"
    
    // Below is the declaration of the tableView that is going to be displayed inside the dropdown UIView which is going to be displayed once the user clicks on the Sort By button:
    
    var dropdownTableView: UITableView?
    
    // The below line of code define the width of the dropdown UIView to be displayed:
    
    var width: CGFloat = 0
    
    var offset:CGFloat = 0
    
    var dropdownCustomDataSourceProtocol: DropdownCustomViewDataSourceProtocol?
    
    // The below line of code register the tableViewCellReusableIdentifier to be used to display the information inside the dropdown tableView:
    
    var nib: UINib?{
        
        didSet{
            
            dropdownTableView?.register(nib, forCellReuseIdentifier: self.dropdownTableViewCellReusableIdentifier)
            
        }
        
    }
    
    // The below Variable is going to be used to specify the position and the size of the dropdown UIView to be displayed once the user clicks on the Sort By button:
    
    var viewPositionRef: CGRect?
    
    // Below Variable is going to be used to check whether the dropdown is already displayed on the screen or not, by default it is not displayed:
    
    var isDropdownPresent: Bool = false
    
    //MARK: - DropDown Methods
    
    // Make Table View Programatically
    // The below Method setup the dropdown UIView that needs to be displayed by specifying its position on the screen as well as its size (also sets the aesthetics of the UIView):
    
    func setUpDropdown(xCoordinateOfDropdownTableView: CGFloat, yCoordinateOfDropdownTableView: CGFloat, widthOfDropdownTableView: CGFloat, offset: CGFloat){
        
        self.addBorders()
        
        self.addShadowToView()
        
        // The below line of code sets where the drop down menu should be displayed, the width is obtained from the above line of code (i.e., line number 94) self.width = viewPositionReference.width and the height of it is obtained from the BlueBookUniversalBeamVC Class, inside the @objc func navigationBarRightButtonPressed(sender: UIButton) method:
        
        self.viewPositionRef = CGRect(x: xCoordinateOfDropdownTableView, y: yCoordinateOfDropdownTableView, width: 0, height: 0)
        
        self.frame = CGRect(x: viewPositionRef!.minX, y: viewPositionRef!.maxY + offset, width: 0, height: 0)
        
        // The below line of code sets the frame required for the dropdown tableView:
        
        dropdownTableView = UITableView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 0, height: 0))
        
        // The below line of code sets the width of the dropdown tableView equals to the width of the reference's element width, which the dropdown UIView is going to be linked to:
        
        self.width = widthOfDropdownTableView
        
        // The below defines the vertical offset between the reference element and the top of the dropdown UIView:
        
        self.offset = offset
        
        dropdownTableView?.showsVerticalScrollIndicator = false
        
        dropdownTableView?.showsHorizontalScrollIndicator = false
        
        dropdownTableView?.isScrollEnabled = false
        
        dropdownTableView?.backgroundColor = .white
        
        dropdownTableView?.separatorStyle = .none
        
        dropdownTableView?.delegate = self
        
        dropdownTableView?.dataSource = self
        
        dropdownTableView?.allowsSelection = true
        
        dropdownTableView?.isUserInteractionEnabled = true
        
        dropdownTableView?.tableFooterView = UIView()
        
        self.addSubview(dropdownTableView!)
        
    }
    
    // Shows Drop Down Menu
    
    func showDropdown(height: CGFloat){
        
        // If it is already present then hide it:
        
        if isDropdownPresent {
            
            self.hideDropdown()
            
        }
            
            // Otherwise, display it:
            
        else {
            
            isDropdownPresent = true
            
            self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)! + self.offset, width: width, height: 0)
            
            self.dropdownTableView?.frame = CGRect(x: 0, y: 0, width: width, height: 0)
            
            self.dropdownTableView?.reloadData()
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
                , animations: {
                    
                    self.frame.size = CGSize(width: self.width, height: height)
                    
                    self.dropdownTableView?.frame.size = CGSize(width: self.width, height: height)
                    
            })
            
        }
        
    }
    
    // Sets Row Height of your Custom XIB
    
    func setRowHeight(height: CGFloat) {
        
        self.dropdownTableView?.rowHeight = height
        
        self.dropdownTableView?.estimatedRowHeight = height
        
    }
    
    // Hides DropDownMenu
    
    func hideDropdown() {
        
        isDropdownPresent = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
            , animations: {
                
                self.frame.size = CGSize(width: self.width, height: 0)
                
                self.dropdownTableView?.frame.size = CGSize(width: self.width, height: 0)
                
        })
        
    }
    
}

// MARK: - Table View Methods

extension DropdownCustomView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dropdownCustomDataSourceProtocol?.numberOfRows(dropdownTableViewCellClass: self.dropdownTableViewCellClass) ?? 0)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = (dropdownTableView?.dequeueReusableCell(withIdentifier: self.dropdownTableViewCellReusableIdentifier) ?? UITableViewCell())
        
        dropdownCustomDataSourceProtocol?.getDataToDropDown(cell: cell, indexPos: indexPath.row, dropdownTableViewCellClass: self.dropdownTableViewCellClass)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dropdownCustomDataSourceProtocol?.selectItemInDropdown(indexPos: indexPath.row, dropdownTableViewCellClass: self.dropdownTableViewCellClass)
        
    }
    
}

//MARK: - UIView Extension

extension UIView{
    
    func addBorders(borderWidth: CGFloat = 0.2, borderColor: CGColor = UIColor.lightGray.cgColor){
        
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor
        
    }
    
    func addShadowToView(shadowRadius: CGFloat = 2, alphaComponent: CGFloat = 0.6) {
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: alphaComponent).cgColor
        
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        
        self.layer.shadowRadius = shadowRadius
        
        self.layer.shadowOpacity = 1
        
    }
    
}
