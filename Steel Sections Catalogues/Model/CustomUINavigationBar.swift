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

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    // The below convenience initialiser, initialises a custom standalone Navigation Bar which only contains a custom UILabel that holds the Navigation Bar title:
    
    convenience init(labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String, isNavBarTranslucent: Bool, navBarBackgroundColourHexCode: String, navBarBackgroundColourAlphaValue: CGFloat, navBarStyle: UIBarStyle, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String)  {
        
        self.init()
        
        addTitleLabel(labelTitleText: labelTitleText, titleLabelFontHexColourCode: titleLabelFontHexColourCode, labelTitleFontSize: labelTitleFontSize, labelTitleFontType: labelTitleFontType)
        
        setupNavigationBarEssentials(isNavBarTranslucent: isNavBarTranslucent, navBarBackgroundColourHexCode: navBarBackgroundColourHexCode, navBarBackgroundColourAlphaValue: navBarBackgroundColourAlphaValue, navBarStyle: navBarStyle, preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
    }
    
    // The below convenience initialiser, initialises a custom standalone Navigation Bar with a custom UILabel for the title and a left button item:
    
    convenience init(navBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLefButtonSelector: Selector, labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String, isNavBarTranslucent: Bool, navBarBackgroundColourHexCode: String, navBarBackgroundColourAlphaValue: CGFloat, navBarStyle: UIBarStyle, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        self.init()
        
        addNavBarLeftButton(navBarLeftButtonImage: navBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLefButtonSelector)
        
        addTitleLabel(labelTitleText: labelTitleText, titleLabelFontHexColourCode: titleLabelFontHexColourCode, labelTitleFontSize: labelTitleFontSize, labelTitleFontType: labelTitleFontType)
        
        setupNavigationBarEssentials(isNavBarTranslucent: isNavBarTranslucent, navBarBackgroundColourHexCode: navBarBackgroundColourHexCode, navBarBackgroundColourAlphaValue: navBarBackgroundColourAlphaValue, navBarStyle: navBarStyle, preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
    }
    
    // The below initialiser, initialises a custom Navigation Bar with a default Title prompt, a title image underneath the prompt and a left button item:
    
    convenience init(navBarPromptTitleText: String, navBarTitleImage: String, navBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLefButtonSelector: Selector, isNavBarTranslucent: Bool, navBarBackgroundColourHexCode: String, navBarBackgroundColourAlphaValue: CGFloat, navBarStyle: UIBarStyle, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        self.init()
        
        addDefaultNavigationBarTitlePrompt(promptTitleText: navBarPromptTitleText)
        
        addTitleImageToNavBar(navBarTitleImage: navBarTitleImage)
        
        addNavBarLeftButton(navBarLeftButtonImage: navBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLefButtonSelector)
        
        setupNavigationBarEssentials(isNavBarTranslucent: isNavBarTranslucent, navBarBackgroundColourHexCode: navBarBackgroundColourHexCode, navBarBackgroundColourAlphaValue: navBarBackgroundColourAlphaValue, navBarStyle: navBarStyle, preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
    }
    
    // The below initialise a custom Navigation Bar with a Right and Left Button as well as a title with a UILabel in the middle:
    
    convenience init(isNavBarTranslucent: Bool, navBarBackgroundColourHexCode: String, navBarBackgroundColourAlphaValue: CGFloat, navBarStyle: UIBarStyle, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String, navBarLeftButtonImage: String, navBarLeftButtonTarget: Any?, navBarLeftButtonSelector: Selector, labelTitleText: String, titleLabelFontHexColourCode: String, labelTitleFontSize: CGFloat, labelTitleFontType: String) {
        
        self.init()
        
        addNavBarRightButton()
        
        addNavBarLeftButton(navBarLeftButtonImage: navBarLeftButtonImage, navBarLeftButtonTarget: navBarLeftButtonTarget, navBarLeftButtonSelector: navBarLeftButtonSelector)
        
        setupNavigationBarEssentials(isNavBarTranslucent: isNavBarTranslucent, navBarBackgroundColourHexCode: navBarBackgroundColourHexCode, navBarBackgroundColourAlphaValue: navBarBackgroundColourAlphaValue, navBarStyle: navBarStyle, preferLargeTitles: preferLargeTitles, navBarDelegate: navBarDelegate, navBarItemsHexColourCode: navBarItemsHexColourCode)
        
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
    
    func addNavBarLeftButton(navBarLeftButtonImage: String, navBarLeftButtonTarget target: Any?, navBarLeftButtonSelector selector: Selector) {
        
        // You can specify a custom tint colour for a navigation bar background by using the barTintColor property. Setting this property overrides the default colour inferred from the bar style. As with all UIView subclasses, you can control the colour of the interactive elements within navigation bars, including button images and titles, using the tintColor property.
        
        let navBarLeftButtonImage = UIImage(named: navBarLeftButtonImage)
        
        navBarLeftButtonImage!.withRenderingMode(.alwaysOriginal)
        
        let navBarLeftButton = UIBarButtonItem(image: navBarLeftButtonImage, style: .plain, target: target, action: selector)
                
        customNavigationBarItem.leftBarButtonItem = navBarLeftButton
        
    }
    
    func addNavBarRightButton() {
        
        let button = DropdownUIButton()
        
        let navigationBarRightButtonView: UIView = {
            
            let view = UIView()
            
            view.backgroundColor = .yellow
            
            view.addSubview(button)
            
            return view
            
        }()
        
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: navigationBarRightButtonView.topAnchor),
            
            button.rightAnchor.constraint(equalTo: navigationBarRightButtonView.rightAnchor),
            
            button.leftAnchor.constraint(equalTo: navigationBarRightButtonView.leftAnchor),
            
            button.bottomAnchor.constraint(equalTo: navigationBarRightButtonView.bottomAnchor)
            
            ])
        
        let navigationBarRightViewitem = UIBarButtonItem(customView: navigationBarRightButtonView)
        
        customNavigationBarItem.rightBarButtonItem = navigationBarRightViewitem
        
    }
    
    func addTitleImageToNavBar(navBarTitleImage image: String) {
        
        let navBarTitleImage = UIImage(named: image)
        
        let headerImageView = UIImageView(image: navBarTitleImage)
        
        headerImageView.contentMode = .scaleAspectFit
        
        customNavigationBarItem.titleView = headerImageView
        
        
    }
    
    func setupNavigationBarEssentials(isNavBarTranslucent: Bool, navBarBackgroundColourHexCode: String, navBarBackgroundColourAlphaValue: CGFloat, navBarStyle: UIBarStyle, preferLargeTitles: Bool, navBarDelegate: UINavigationBarDelegate, navBarItemsHexColourCode: String) {
        
        // The below line of code adds the navigationBarItems created above in different Methods to the navigationBarItems Array, in order for them to be displayed inside the NavigationBar. UINavigationBar contains an array of UINavigationBarItem for displaying content. According to Apple documents, UINavigationBarItem means; the items to be displayed by a navigation bar when the associated view controller is visible:
        
        items = [customNavigationBarItem]
        
        // Navigation bars are translucent by default; that is, their background colour is semitransparent:
        
        isTranslucent = isNavBarTranslucent
        
        // The tint color to apply to the navigation bar background. This color is made translucent by default unless you set the isTranslucent property to false. This one overrides the backgroundColor property:
        
        barTintColor = UIColor(hexString: navBarBackgroundColourHexCode, withAlpha: navBarBackgroundColourAlphaValue)
        
        // Navigation bars have two standard appearance styles: white with dark text or black with light text. Any changes you make to other navigation bar appearance properties override those inferred from the bar style. This property also affects the colour of the text inside the navigationBarItemPrompt:
        
        barStyle = navBarStyle
        
        // The below line of code decides whether the title property of the navigationBarItem should have large font:
        
        prefersLargeTitles = preferLargeTitles
        
        delegate = navBarDelegate
        
        tintColor = UIColor(hexString: navBarItemsHexColourCode)
        
        // The below lines of code set the needed constraints for the Navigation Bar when displayed inside the hostView:
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}

