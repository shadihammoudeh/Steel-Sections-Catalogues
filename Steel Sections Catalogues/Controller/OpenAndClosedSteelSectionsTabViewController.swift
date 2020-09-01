//
//  BlueBookTabController.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class OpenAndClosedSteelSectionsTabViewController: UITabBarController, UINavigationBarDelegate {
    
    // The below lines of code create an instance for the Open and Closed Steel Sections ViewControllers to be displayed in the TabBar View Controller, i.e this one:
            
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    lazy var blueBookOpenRolledSectionsVC = main.instantiateViewController(identifier: "OpenRolledSteelSectionsCollectionViewController") as OpenRolledSteelSectionsCollectionViewController
    
    lazy var blueBookClosedSectionsVC = main.instantiateViewController(identifier: "ClosedSteelSectionsCollectionViewController") as ClosedSteelSectionsCollectionViewController
    
    lazy var navigationBar = CustomUINavigationBar(navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "BlueBook Catalogue", navBarDelegate: self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        view.addSubview(navigationBar)
        
        setupTabBarItems()
        
    }
    
    override func viewWillLayoutSubviews() {
                
        setupNavigationBarConstraint()

    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
                
        // The below line of code calculates the total height of the BlueBookTabController statusBar as well as its NavigationBar and pass the total to the BlueBookOpenRolledSectionsVC:
        
        blueBookOpenRolledSectionsVC.blueBookControllerStatusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                
        blueBookOpenRolledSectionsVC.blueBookControllerNavigationBarHeight = navigationBar.frame.size.height
                
        blueBookOpenRolledSectionsVC.blueBookControllerTabBarHeight = tabBar.frame.size.height
                
        blueBookOpenRolledSectionsVC.blueBookControllerBottomSafeAreaHeight = view.safeAreaInsets.bottom
                
    }
        
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
                
        let viewControllerToGoTo = main.instantiateViewController(identifier: "CataloguesVC")
        
        self.present(viewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    func setupTabBarItems() {
        
        // The below lines of code add required images for the normal and selected state for the first and second tabBarItem:
        
        blueBookOpenRolledSectionsVC.tabBarItem.image = UIImage(named: "normalStateOpenRolledSections")?.withRenderingMode(.alwaysOriginal)
        
        blueBookOpenRolledSectionsVC.tabBarItem.selectedImage = UIImage(named: "highlightedStateOpenRolledSections")?.withRenderingMode(.alwaysOriginal)
        
        blueBookClosedSectionsVC.tabBarItem.image = UIImage(named: "normalStateClosedSections")?.withRenderingMode(.alwaysOriginal)
        
        blueBookClosedSectionsVC.tabBarItem.selectedImage = UIImage(named: "highlightedStateClosedSections")?.withRenderingMode(.alwaysOriginal)
        
        // The below lines of code set the title for the first and second tabBarItem:
        
        blueBookOpenRolledSectionsVC.tabBarItem.title = "Hot Rolled Structural Steel"
        
        blueBookClosedSectionsVC.tabBarItem.title = "Structural Hollow Sections"
        
        // The below line of codes define a tag number for each of the items to be added to the tabBar. So that they can be identified when pressed by the user:
        
        blueBookOpenRolledSectionsVC.tabBarItem.tag = 1
        
        blueBookClosedSectionsVC.tabBarItem.tag = 2
        
        // The below line of code set the text colour of UIBarItems in normal state (i.e., when not selected):
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:.normal)
        
        // The below line of code sets the text colour of UIBarItems in selected state (i.e., when selected):
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for:.selected)
        
        tabBar.isTranslucent = false
        
        tabBar.barTintColor = .black
        
        // The below line of code adds the first and second items to be displayed in our TabBar into an array:
        
        let tabBarList = [blueBookOpenRolledSectionsVC, blueBookClosedSectionsVC]
        
        viewControllers = tabBarList
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if tabBarItem.tag == 1 {
                        
        }
            
        else {
                        
        }
        
    }
    
    func setupNavigationBarConstraint() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            
            ])
        
    }
    
    // The below Method is required in order to attach the custom Navigation Bar to the bottom of the status bar and make them appear as one entity:
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

