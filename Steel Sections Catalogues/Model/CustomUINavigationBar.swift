//
//  CustomUINavigationBar.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 21/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

import ChameleonFramework

class CustomUINavigationBar: UINavigationBar {
    
    let navigationBarRightButtonView = UIView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    // The below convenience initialiser, initialises a custom standalone Navigation Bar which only contains a custom UILabel that holds the Navigation Bar title:
    
    convenience init(labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String)  {
        
        self.init()
        
        addTitleLabel(labelTitleText: labelTitleText, titleLabelFontHexColourCode: titleLabelFontHexColourCode, labelTitleFontSize: labelTitleFontSize, labelTitleFontType: labelTitleFontType)
        
        setupNavigationBarEssentials(preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
    }
    
    // The below convenience initialiser, initialises a custom standalone Navigation Bar with a custom UILabel for the title and a left button item:
    
    convenience init(normalStateNavBarLeftButtonImage: String, highlightedStateNavBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLeftButtonSelector: Selector, labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        self.init()
        
        addNavBarLeftButton(normalStateNavBarLeftButtonImage: normalStateNavBarLeftButtonImage, highlightedStateNavBarLeftButtonImage: highlightedStateNavBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLeftButtonSelector)
        
        addTitleLabel(labelTitleText: labelTitleText, titleLabelFontHexColourCode: titleLabelFontHexColourCode, labelTitleFontSize: labelTitleFontSize, labelTitleFontType: labelTitleFontType)
        
        setupNavigationBarEssentials(preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
    }
    
    // The below initialiser, initialises a custom Navigation Bar with a default Title prompt, a title image underneath the prompt and a left button item:
    
    convenience init(navBarPromptTitleText: String, navBarTitleImage: String, normalStateNavBarLeftButtonImage: String, highlightedStateNavBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLeftButtonSelector: Selector, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        self.init()
        
        addDefaultNavigationBarTitlePrompt(promptTitleText: navBarPromptTitleText)
        
        addTitleImageToNavBar(navBarTitleImage: navBarTitleImage)
        
        addNavBarLeftButton(normalStateNavBarLeftButtonImage: normalStateNavBarLeftButtonImage, highlightedStateNavBarLeftButtonImage: highlightedStateNavBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLeftButtonSelector)
        
        setupNavigationBarEssentials(preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
    }
    
    // The below initialise a custom Navigation Bar with a Right and Left Button as well as a title with a UILabel in the middle:
    
    convenience init(rightNavBarTitle: String, rightNavBarTitleHexColourCodeNormalState: String, rightNavBarTitleHexColourCodeHighlightedState: String, rightNavBarButtonTarget: Any?, rightNavBarSelector: Selector, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String, normalStateNavBarLeftButtonImage: String, highlightedStateNavBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLeftButtonSelector: Selector, labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String) {
        
        self.init()
        
        addNavBarRightButton(rightNavBarTitle: rightNavBarTitle, rightNavBarTitleHexColourCodeNormalState: rightNavBarTitleHexColourCodeNormalState, rightNavBarTitleHexColourCodeHighlightedState: rightNavBarTitleHexColourCodeHighlightedState, rightNavBarButtonTarget: rightNavBarButtonTarget, rightNavBarSelector: rightNavBarSelector)

        addNavBarLeftButton(normalStateNavBarLeftButtonImage: normalStateNavBarLeftButtonImage, highlightedStateNavBarLeftButtonImage: highlightedStateNavBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLeftButtonSelector)
        
        setupNavigationBarEssentials(preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
        addTitleLabel(labelTitleText: labelTitleText, titleLabelFontHexColourCode: titleLabelFontHexColourCode, labelTitleFontSize: labelTitleFontSize, labelTitleFontType: labelTitleFontType)
        
    }
    
    let customNavigationBarItem = UINavigationItem()
    
    // The below function adds a title Label to the NavigationBar:
    
    func addTitleLabel(labelTitleText titleText: String, titleLabelFontHexColourCode hexCode: String, labelTitleFontSize fontSize: CGFloat, labelTitleFontType fontType: String) {
        
        // The default height for a Navigation Bar is 44 points:
        
        let navBarTitle = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: 44))
        
        navBarTitle.text = titleText
        
        navBarTitle.textColor = UIColor(hexString: hexCode)
        
        navBarTitle.textAlignment = .center
        
        navBarTitle.font = UIFont(name: fontType, size: fontSize)
        
        navBarTitle.numberOfLines = 0
        
        navBarTitle.lineBreakMode = .byWordWrapping
        
        customNavigationBarItem.titleView = navBarTitle
        
    }
    
    // The below function adds the default prompt title to the Navigation Bar:
    
    func addDefaultNavigationBarTitlePrompt(promptTitleText: String) {
        
        // Prompt is a single line of text dispalyed at the top of Navigation Bar. The colour of the text inside the prompt is changed by selecting the barStyle property:
        
        customNavigationBarItem.prompt = promptTitleText
        
    }
    
    func addNavBarLeftButton(normalStateNavBarLeftButtonImage: String, highlightedStateNavBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLeftButtonSelector: Selector) {
        
        // You can specify a custom tint colour for a navigation bar background by using the barTintColor property. Setting this property overrides the default colour inferred from the bar style. As with all UIView subclasses, you can control the colour of the interactive elements within navigation bars, including button images and titles, using the tintColor property.
        
        let navBarLeftButton: UIButton = {
            
            let button = UIButton()
            
            let normalStateNavBarLeftButtonImage = UIImage(named: normalStateNavBarLeftButtonImage)
            
            let highlightedStateNavBarLeftButtonImage = UIImage(named: highlightedStateNavBarLeftButtonImage)
            
            button.setImage(normalStateNavBarLeftButtonImage, for: .normal)
            
            button.setImage(highlightedStateNavBarLeftButtonImage, for: .highlighted)
            
            button.addTarget(navBarLeftButtonTarget, action: navBarLeftButtonSelector, for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
        
        let navBarLeftView: UIView = {
            
            let view = UIView()
            
            view.addSubview(navBarLeftButton)
            
            NSLayoutConstraint.activate([
                
                navBarLeftButton.topAnchor.constraint(equalTo: view.topAnchor),
                
                navBarLeftButton.rightAnchor.constraint(equalTo: view.rightAnchor),
                
                navBarLeftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                navBarLeftButton.leftAnchor.constraint(equalTo: view.leftAnchor)
                
                ])
            
            return view
            
        }()
        
        let navBarLeftButtonItem = UIBarButtonItem(customView: navBarLeftView)
        
        customNavigationBarItem.leftBarButtonItem = navBarLeftButtonItem
        
    }
    
    func addNavBarRightButton(rightNavBarTitle: String, rightNavBarTitleHexColourCodeNormalState: String, rightNavBarTitleHexColourCodeHighlightedState: String, rightNavBarButtonTarget: Any?, rightNavBarSelector: Selector) {
        
        let navBarRightButton: UIButton = {
            
            let button = UIButton()
            
            button.setTitle(rightNavBarTitle, for: .normal)
            
            button.setTitleColor(UIColor(hexString: rightNavBarTitleHexColourCodeNormalState), for: .normal)
            
            button.setTitleColor(UIColor(hexString: rightNavBarTitleHexColourCodeHighlightedState), for: .highlighted)
            
            button.addTarget(rightNavBarButtonTarget, action: rightNavBarSelector, for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
            
        }()
        
            navigationBarRightButtonView.addSubview(navBarRightButton)
            
            NSLayoutConstraint.activate([
                navBarRightButton.topAnchor.constraint(equalTo: navigationBarRightButtonView.topAnchor),
                
                navBarRightButton.rightAnchor.constraint(equalTo: navigationBarRightButtonView.rightAnchor),
                
                navBarRightButton.bottomAnchor.constraint(equalTo: navigationBarRightButtonView.bottomAnchor),
                
                navBarRightButton.leftAnchor.constraint(equalTo: navigationBarRightButtonView.leftAnchor)
                
                ])
        
        let navBarRightButtonItem = UIBarButtonItem(customView: navigationBarRightButtonView)
        
        customNavigationBarItem.rightBarButtonItem = navBarRightButtonItem
        
    }
    
    func addTitleImageToNavBar(navBarTitleImage image: String) {
        
        let navBarTitleImage = UIImage(named: image)
        
        let headerImageView = UIImageView(image: navBarTitleImage)
        
        headerImageView.contentMode = .scaleAspectFit
        
        customNavigationBarItem.titleView = headerImageView
        
    }
    
    func setupNavigationBarEssentials(preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        // The below line of code adds the navigationBarItems created above in different Methods to the navigationBarItems Array, in order for them to be displayed inside the NavigationBar. UINavigationBar contains an array of UINavigationBarItem for displaying content. According to Apple documents, UINavigationBarItem means; the items to be displayed by a navigation bar when the associated view controller is visible:
        
        items = [customNavigationBarItem]
        
        // Navigation bars are translucent by default; that is, their background colour is semitransparent:
        
        isTranslucent = false
        
        // The tint color to apply to the navigation bar background. This color is made translucent by default unless you set the isTranslucent property to false. This one overrides the backgroundColor property:
        
        barTintColor = UIColor(named: "Background Colour for Navigation Bar")
        
        barTintColor?.withAlphaComponent(1.0)
        
        // Navigation bars have two standard appearance styles: white with dark text or black with light text. Any changes you make to other navigation bar appearance properties override those inferred from the bar style. This property also affects the colour of the text inside the navigationBarItemPrompt:
        
        barStyle = .default
        
        // The below line of code decides whether the title property of the navigationBarItem should have large font:
        
        prefersLargeTitles = preferLargeTitles
        
        delegate = navBarDelegate
        
        tintColor = UIColor(hexString: navBarItemsHexColourCode)
        
        // The below lines of code set the needed constraints for the Navigation Bar when displayed inside the hostView:
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
