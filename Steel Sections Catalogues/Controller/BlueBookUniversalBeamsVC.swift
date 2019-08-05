//
//  BlueBookUniversalBeamsVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UIPopoverPresentationControllerDelegate {
    
    let tableViewCustomCellClass = IsectionsCustomTableViewCell()
    
    // The below instance is needed in order to access and print out the heights and widths of the textLabel as well as the buttons displayed inside the dropdown menu:
    
    let sortByDropdownTableViewCell = SortByDropdownTableViewCell()
    
    // Below is an instance for the dropdown menu that is going to be displayed once the user clicks on the Sort By button, located at the right corner of the navigation bar:
    
    let sortByDropdownMenuView = DropdownCustomView()
    
    // The below gets passed into the setupDropdown function in order to calculate the starting X-coordinate for the dropdown tableView menu by substracting the total view width from the width of the dropdown menu:
    
    var widthOfDropdownTableView: CGFloat = 280
    
    // Below Variable represents the height of each cell that is going to be contained inside the dropdown view:
    
    var sortByDropdownTableViewCellHeight: CGFloat = 65
    
    // Below Constant represents the items that are going to be displayed inside the dropdown menu tableView rows:
    
    let sortByDropdownMenuItemsArray = ["Section Designation","Depth, h","Width, b","Area of Section, A"]
    
    var sortByTextLabelWidthsInsideDropdownTableViewArray: [CGFloat] = []
    
    var sortByTextLabelHeightsInsideDropdownTableViewArray: [CGFloat] = []
    
    var ascendingButtonWidthsInsideDropdownTableViewArray: [CGFloat] = []
    
    var ascendingButtonHeightsInsideDropdownTableViewArray: [CGFloat] = []
    
    var descendingButtonWidthsInsideDropdownTableViewArray: [CGFloat] = []
    
    var descendingButtonHeightsInsideDropdownTableViewArray: [CGFloat] = []
    
    let sectionDesignationLabelFontName: String = "AppleSDGothicNeo-Bold"
    
    let sectionDesignationLabelFontSize: CGFloat = 18
    
    let otherCustomCellLabelsFontName: String = "AppleSDGothicNeo-Light"
    
    let otherCustomCellLabelsFontSize: CGFloat = 15
    
    let subscripAndSuperscriptChractersFontName: String = "AppleSDGothicNeo-Light"
    
    let subscriptAndSuperscriptChractersFontSize: CGFloat = 9
    
    // The below code line declares the custom NavigationBar to be added to this ViewController. The reason it is defined as a lazy var, is to allow us to access the view properties of this ViewController. Since the custom NavigationBar is defined outside the viewDidLoad methods, or other methods where view will be available:
    
    lazy var navigationBar = CustomUINavigationBar(rightNavBarButtonTitleForNormalState: "Sort By:", rightNavBarButtonImageForNormalState: "pullDownButton", rightNavBarButtonImageForHighlightedState: "pullUpButton", rightNavBarButtonTarget: self, rightNavBarButtonSelector: #selector(navigationBarRightButtonPressed(sender:)), isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#FFFFFF", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#FF4F40", normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Universal Beams (UB)", titleLabelFontHexColourCode: "#000000", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light")
    
    lazy var universalBeamsTableView = CustomTableView(tableViewBackgroundColourHexCode: "#0D0D0D", tableViewDelegate: self, tableViewDataSource: self, tableViewCustomCellClassToBeRegistered: IsectionsCustomTableViewCell.self, tableViewCustomCellReuseIdentifierToBeRegistered: "customCell")
    
    var tableSectionHeaderFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
    
    // The below Array is the one which contains the data extracted from the passed CSV file. It contains the data in a one big Array, which contains several Arrays inside it, whereby each Array inside the big Array contains several Dictionaries. The below Array is going to be filled using the CSV parser which will be used later on:
    
    var universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser = [IsectionsDimensionsParameters]()
    
    // The below Array is mapped from the above Array, whereby only sectionSerialNumbers are reported inside of it, with no duplication using the extension at the end of this Class (i.e., Array):
    
    lazy var universalBeamsSectionSerialNumberArray = universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.map({ return $0.sectionSerialNumber }).removingDuplicates()
    
    // The below is the first ViewController cycle:
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("UniversalBeamsViewController viewDidLoad()")
        
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamsTableView)
        
        // We are going to call the parse function as soon as the application loads in order to extract the CSV data inside of it:
        
        parseCsvFile(csvFileToParse: "BlueBookUniversalBeams")
        
        // The below code sorts the Data reported from the relevant CSV file using the Parser either in an Ascending or Dscending order:
        
        universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.sort {
            
            if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                
                return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                
            } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                
                return $0.sectionSerialNumber < $1.sectionSerialNumber
                
            } else {
                
                return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                
            }
            
        }
        
        // It is very important to note that the below code, which calculates the dynamic height of a TableView Cell only works when all the required constrains (i.e., Top, Right, Bottom and Left) for all subViews to be displayed inside the tableView Cell are defined:
        
        self.universalBeamsTableView.rowHeight = UITableView.automaticDimension
        
        self.universalBeamsTableView.estimatedRowHeight = 120
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("UniversalBeamsViewController viewWillAppear()")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        print("UniversalBeamsViewController viewDidLayoutSubViews()")
        
        setupConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("UniversalBeamsViewController viewDidAppear()")
        
        setUpDropdown()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("UniversalBeamsViewController viewWillDisappear()")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("UniversalBeamsViewController viewDidDisappear()")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // The below code returns the total number of items inside the universalBeamsSectionSerialNumberArray, which is equal to the ttoal number of section in our table:
        
        return universalBeamsSectionSerialNumberArray.count
        
    }
    
    func setUpDropdown(){
        
        sortByDropdownMenuView.dropdownTableViewCellClass = "DROP_DOWN_NEW"
        
        sortByDropdownMenuView.dropdownTableViewCellReusableIdentifier = "dropDownCell"
        
        sortByDropdownMenuView.dropdownCustomDataSourceProtocol = self
        
        // Offset in the below line of code defines the vertical offset from the bottom of the viewPositionReference item to the top of the sortByDropDownMenuUIView:
        
        sortByDropdownMenuView.setUpDropdown(xCoordinateOfDropdownTableView: self.view.frame.size.width - widthOfDropdownTableView, yCoordinateOfDropdownTableView: UIApplication.shared.statusBarFrame.height + navigationBar.frame.size.height, widthOfDropdownTableView: widthOfDropdownTableView, offset: 0)
        
        sortByDropdownMenuView.nib = UINib(nibName: "SortByDropdownTableViewCell", bundle: nil)
        
        sortByDropdownMenuView.setRowHeight(height: self.sortByDropdownTableViewCellHeight)
        
        self.view.addSubview(sortByDropdownMenuView)
        
    }
    
    // The below function defines the properties of section headers as well as what should be displayed inside them:
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        
        let sectionHeaderTitle = UILabel()
        
        sectionHeaderTitle.font = tableSectionHeaderFont
        
        sectionHeaderTitle.translatesAutoresizingMaskIntoConstraints = false
        
        sectionHeaderView.frame.size.width = view.frame.size.width
        
        let maxWidth = view.frame.size.width
        
        sectionHeaderView.backgroundColor = UIColor(hexString: "#BF2C0B")
        
        sectionHeaderTitle.textColor = UIColor(hexString: "#F2AB6D")
        
        sectionHeaderTitle.textAlignment = .left
        
        sectionHeaderTitle.text = universalBeamsSectionSerialNumberArray[section] + " Series"
        
        sectionHeaderTitle.numberOfLines = 0
        
        sectionHeaderTitle.frame.size.width = sectionHeaderView.frame.size.width
        
        sectionHeaderTitle.frame.size.height = calculateUILabelHeightBasedOnItsText(text: sectionHeaderTitle.text!, font: tableSectionHeaderFont!, width: maxWidth)
        
        sectionHeaderView.addSubview(sectionHeaderTitle)
        
        NSLayoutConstraint.activate([
            
            sectionHeaderTitle.leftAnchor.constraint(equalTo: sectionHeaderView.leftAnchor, constant: 20),
            
            sectionHeaderTitle.rightAnchor.constraint(equalTo: sectionHeaderView.rightAnchor, constant: -20),
            
            sectionHeaderTitle.centerYAnchor.constraint(equalTo: sectionHeaderView.centerYAnchor)
            
            ])
        
        return sectionHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return calculateUILabelHeightBasedOnItsText(text: universalBeamsSectionSerialNumberArray[section] + " Series", font: tableSectionHeaderFont!, width: view.frame.size.width - 40)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The below line of code will convert the original Array into an Array of key-value pairs using tuples, where each value has the number 1:
        
        let convertedUniversalBeamsArrayDataExtractedFromTheCsvFileUsingTheParserIntoKeyValuePairsTuples = universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.map { ($0.sectionSerialNumber, 1) }
        
        // The below line of code create a Dictionary from the above tuple array, asking it to add the 1s together every time it finds a duplicate key:
        
        var totalSectionSerialNumberCountDictionaryCollection = Dictionary(convertedUniversalBeamsArrayDataExtractedFromTheCsvFileUsingTheParserIntoKeyValuePairsTuples, uniquingKeysWith: +)
        
        return totalSectionSerialNumberCountDictionaryCollection["\(universalBeamsSectionSerialNumberArray[section])"]!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! IsectionsCustomTableViewCell
        
        cell.sectionDesignationLabel.text = "Section Designation: \(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == universalBeamsSectionSerialNumberArray[indexPath.section] }).map({ $0.fullSectionDesignation })[indexPath.row])"
        
        cell.sectionDesignationLabel.font = UIFont(name: sectionDesignationLabelFontName, size: sectionDesignationLabelFontSize)
        
        cell.depthOfSectionLabel.text = "Depth, h [mm] = " + String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.depthOfSection })[indexPath.row])
        
        cell.depthOfSectionLabel.font = UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)
        
        let attributedSectionWebThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Web Thickness, tw [mm] = \(String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row]))", attributes: [.font: UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)])
        
        attributedSectionWebThicknessString.setAttributes([.font: UIFont(name: subscripAndSuperscriptChractersFontName, size: subscriptAndSuperscriptChractersFontSize),.baselineOffset:-3], range: NSRange(location:16,length:1))
        
        cell.sectionWebThicknessLabel.attributedText = attributedSectionWebThicknessString
        
        cell.widthOfSectionLabel.text = "Width, b [mm] = " + String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.widthOfSection })[indexPath.row])
        
        cell.widthOfSectionLabel.font = UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)
        
        let attributedSectionFlangeThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Flange Thickness, tf [mm] = \(String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row]))", attributes: [.font: UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)])
        
        attributedSectionFlangeThicknessString.setAttributes([.font: UIFont(name: subscripAndSuperscriptChractersFontName, size: subscriptAndSuperscriptChractersFontSize),.baselineOffset: -3], range: NSRange(location: 19, length: 1))
        
        cell.sectionFlangeThicknessLabel.attributedText = attributedSectionFlangeThicknessString
        
        cell.sectionMassPerMetreLabel.text = "Mass per Metre [kg/m] = " + String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row])
        
        cell.sectionMassPerMetreLabel.font = UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)
        
        let attributedAreaOfSectionString: NSMutableAttributedString = NSMutableAttributedString(string: "Area of Section, A [cm2] = \(String(universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.filter({ $0.sectionSerialNumber == "\(universalBeamsSectionSerialNumberArray[indexPath.section])" }).map({ $0.areaOfSection })[indexPath.row]))", attributes: [.font: UIFont(name: otherCustomCellLabelsFontName, size: otherCustomCellLabelsFontSize)])
        
        attributedAreaOfSectionString.setAttributes([.font: UIFont(name: subscripAndSuperscriptChractersFontName, size: subscriptAndSuperscriptChractersFontSize),.baselineOffset: 5.5], range: NSRange(location: 22, length: 1))
        
        cell.areaOfSectionLabel.attributedText = attributedAreaOfSectionString
        
        cell.backgroundColor = UIColor(hexString: "#0D0D0D")
        
        return cell
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        return 150
    //
    //    }
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let viewControllerToGoTo = BlueBookTabController()
        
        present(viewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    @objc func navigationBarRightButtonPressed(sender : UIButton) {
        
        print("Right navigation bar button pressed")

        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let popOverViewController = storyboard.instantiateViewController(withIdentifier: "PopoverViewController")
        
        popOverViewController.modalPresentationStyle = .popover

        let popover = popOverViewController.popoverPresentationController!

        popover.delegate = self

        popover.permittedArrowDirections = .up
        
        // The sourceView in the below code line represents the view containing the anchor rectangle for the popover:

        popover.sourceView = navigationBar.navigationBarRightButtonView
        
        // The sourceRect in the below code line represents The rectangle in the specified view in which to anchor the popover:
        
        popover.sourceRect = navigationBar.navigationBarRightButtonView.bounds
        
        present(popOverViewController, animated: true, completion:nil)
    
    }
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
        
//        if sortByDropdownMenuView.isDropdownPresent == false {
//            navigationBar.rightNavigationBarDropDownButton.setImage(UIImage(named: "pullUpButton"), for: .normal)
//
//            universalBeamsTableView.isUserInteractionEnabled = false
//
//            self.sortByDropdownMenuView.showDropdown(height: self.sortByDropdownTableViewCellHeight * CGFloat(sortByDropdownMenuItemsArray.count))
//
//        } else {
//
//            navigationBar.rightNavigationBarDropDownButton.setImage(UIImage(named: "pullDownButton"), for: .normal)
//
//            universalBeamsTableView.isUserInteractionEnabled = true
//
//            self.view.alpha = 1.0
//
//            sortByDropdownMenuView.hideDropdown()
//
//        }
    
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
    // The below function calculates the needed height for a UILabel based on the size of the text inisde of it:
    
    func calculateUILabelHeightBasedOnItsText (text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        // The below code line allows the UILabel to display the text on multiple lines if the do not fit in its width:
        
        label.numberOfLines = 0
        
        // lineBreakMode in the below code defines the technique used to for wrapping and trauncating the label's text.
        
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.font = font
        
        label.text = text
        
        label.sizeToFit()
        
        return label.frame.height
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            universalBeamsTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            universalBeamsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            universalBeamsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            universalBeamsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            ])
        
    }
    
    // We want to create a function that will parse the Universal Beam CSV data into a format that is useful:
    
    func parseCsvFile(csvFileToParse: String) {
        
        // We first need a path for where the CSV file is located. The below can be forced un-wrapped since we know for sure that the path for the file does exist:
        
        let path = Bundle.main.path(forResource: csvFileToParse, ofType: "csv")!
        
        // Then we need to use the parser (i.e., CsvParser.swift) which can throw an error, thus, we need to use a do catch statement:
        
        do {
            
            // In the below line of code we are passing the path of the CSV file we are interested in extracting its data and pass it to the CsvParser Class:
            
            let csv = try CsvParser(contentOfURL: path)
            
            // The below line of code will generate an array of dictionaries, whereby each parsed CSV row represents an Array of Dictionaries:
            
            let rows = csv.rows
            
            // Now we want to pull out the data that we are interested in out of the parsed csv file generated in the above line of code. As the above code line will spit out the data in an Arrays of Dictionaries format, whereby each line is going to be an Array, which contains multiple dictionaries inside of it, and each Dictionary is going to have a title as its Key and a value as its Value. We need to loop through each row and pull out the data we want. Then each extraced row (Array of Dictionaries) is going to be appended to the big Array (i.e., universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser) which is going to contain all other Arrays:
            
            for row in rows {
                
                let firstSectionSeriesNumber = Int(row["First Section Series Number"]!)!
                
                let secondSectionSeriesNumber = Int(row["Second Section Series Number"]!)!
                
                let lastSectionSeriesNumber = Int(row["Last Section Series Number"]!)!
                
                let sectionSerialNumber = row["Section Serial Number"]!
                
                let fullSectionDesignation = row["Full Section Designation"]!
                
                let sectionMassPerMetre = Double(row["Mass Per Metre (kg/m)"]!)!
                
                let depthOfSection = Double(row["Depth of Section [h] (mm)"]!)!
                
                let widthOfSection = Double(row["Width of Section [b] (mm)"]!)!
                
                let sectionWebThickness = Double(row["Web Thickness [tw] (mm)"]!)!
                
                let sectionFlangeThickness = Double(row["Flange Thickness [tf] (mm)"]!)!
                
                let sectionRootRadius = Double(row["Root Radius [r] (mm)"]!)!
                
                let depthOfSectionBetweenFillets = Double(row["Depth between Fillets [d] (mm)"]!)!
                
                let ratioForLocalWebBuckling = Double(row["Ratio for Local Web Buckling (cw/tw)"]!)!
                
                let ratioForLocalFlangeBuckling = Double(row["Ratio for Local Flange Buckling (ct/tf)"]!)!
                
                let dimensionForDetailingEndClearance = Int(row["Dimension for Detailing End Clearance [C] (mm)"]!)!
                
                let dimensionForDetailingNotchN = Int(row["Dimension for Detailing Notch [N] (mm)"]!)!
                
                let dimensionForDetailingNotchn = Int(row["Dimension for Detailing Notch [n] (mm)"]!)!
                
                let surfaceAreaPerMetre = Double(row["Surface Area Per Metre [m2]"]!)!
                
                let surfaceAreaPerTonne = Double(row["Surface Area Per Tonne [m2]"]!)!
                
                let secondMomentOfAreaMajorAxis = Double(row["Second Moment of Area [Axis y-y] (cm4)"]!)!
                
                let secondMomentOfAreaMinorAxis = Double(row["Second Moment of Area [Axis z-z] (cm4)"]!)!
                
                let radiusOfGyrationMajorAxis = Double(row["Radius of Gyration [Axis y-y] (cm)"]!)!
                
                let radiusOfGyrationMinorAxis = Double(row["Radius of Gyration [Axis z-z] (cm)"]!)!
                
                let elasticModulusMajorAxis = Double(row["Elastic Modulus [Axis y-y] (cm3)"]!)!
                
                let elasticModulusMinorAxis = Double(row["Elastic Modulus [Axis z-z (cm3)"]!)!
                
                let plasticModulusMajorAxis = Double(row["Plastic Modulus [Axis y-y] (cm3)"]!)!
                
                let plasticModulusMinorAxis = Double(row["Plastic Modulus [Axis z-z (cm3)"]!)!
                
                let bucklingParameter = Double(row["Buckling Parameter [U]"]!)!
                
                let torsionalIndex = Double(row["Torsional Index [X]"]!)!
                
                let wrapingConstant = Double(row["Wraping Constant [Iw] (dm6)"]!)!
                
                let torsionalConstant = Double(row["Torsional Constant [IT] (cm4)"]!)!
                
                let areaOfSection = Double(row["Area of Section [A] (cm2)"]!)!
                
                let individualUniversalBeamArrayOfDictionaries = IsectionsDimensionsParameters(firstSectionSeriesNumber: firstSectionSeriesNumber, secondSectionSeriesNumber: secondSectionSeriesNumber, lastSectionSeriesNumber: lastSectionSeriesNumber, sectionSerialNumber: sectionSerialNumber, fullSectionDesignation: fullSectionDesignation, sectionMassPerMetre: sectionMassPerMetre, depthOfSection: depthOfSection, widthOfSection: widthOfSection, sectionWebThickness: sectionWebThickness, sectionFlangeThickness: sectionFlangeThickness, sectionRootRadius: sectionRootRadius, depthOfSectionBetweenFillets: depthOfSectionBetweenFillets, ratioForLocalWebBuckling: ratioForLocalWebBuckling, ratioForLocalFlangeBuckling: ratioForLocalFlangeBuckling, dimensionForDetailingEndClearance: dimensionForDetailingEndClearance, dimensionForDetailingNotchN: dimensionForDetailingNotchN, dimensionForDetailingNotchn: dimensionForDetailingNotchn, surfaceAreaPerMetre: surfaceAreaPerMetre, surfaceAreaPerTonne: surfaceAreaPerTonne, secondMomentOfAreaMajorAxis: secondMomentOfAreaMajorAxis, secondMomentOfAreaMinorAxis: secondMomentOfAreaMinorAxis, radiusOfGyrationMajorAxis: radiusOfGyrationMajorAxis, radiusOfGyrationMinorAxis: radiusOfGyrationMinorAxis, elasticModulusMajorAxis: elasticModulusMajorAxis, elasticModulusMinorAxis: elasticModulusMinorAxis, plasticModulusMajorAxis: plasticModulusMajorAxis, plasticModulusMinorAxis: plasticModulusMinorAxis, bucklingParameter: bucklingParameter, torsionalIndex: torsionalIndex, wrapingConstant: wrapingConstant, torsionalConstant: torsionalConstant, areaOfSection: areaOfSection)
                
                // Then we need to append each of the above created Array of Dictionaries to the main Array declared above:
                universalBeamsArrayDataExtractedFromTheCsvFileUsingTheParser.append(individualUniversalBeamArrayOfDictionaries)
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
}

// The below extension is needed in order to extend the Array's functionalities so that any duplicate item inside Arrays can be removed:

extension Array where Element: Hashable {
    
    func removingDuplicates() -> [Element] {
        
        var addedDict = [Element: Bool]()
        
        return filter {
            
            addedDict.updateValue(true, forKey: $0) == nil
            
        }
        
    }
    
    mutating func removeDuplicates() {
        
        self = self.removingDuplicates()
        
    }
    
}

extension BlueBookUniversalBeamsVC: DropdownCustomViewDataSourceProtocol {
    
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, dropdownTableViewCellClass: String) {
        
        if dropdownTableViewCellClass == "DROP_DOWN_NEW" {
            
            let customCell = cell as! SortByDropdownTableViewCell
            
            customCell.sortByTextLabel.text = self.sortByDropdownMenuItemsArray[indexPos]
            
            customCell.layoutIfNeeded()
            
            print("Custom cell intrinsic content size width is equal to \(customCell.intrinsicContentSize.width)")
            
            print("Custom cell intrinsic content size height is equal to \(customCell.intrinsicContentSize.height)")
            
            print("Sort By textLabel Width is equal to \(customCell.sortByTextLabel.frame.width)")
            
            print("Sort By textLabel Height is equal to \(customCell.sortByTextLabel.frame.height)")
            
            print("Ascending Button Width is equal to \(customCell.ascendingOrderButton.frame.size.width)")
            
            print("Ascending Button Height is equal to \(customCell.ascendingOrderButton.frame.size.height)")
            
            print("Descending Button Width is equal to \(customCell.descendingOrderButton.frame.size.width)")
            
            print("Descending Button Height is equal to \(customCell.descendingOrderButton.frame.size.height)")
            
        }
        
    }
    
    func selectItemInDropdownView(indexPos: Int, dropdownTableViewCellClass: String) {
        
        self.sortByDropdownMenuView.hideDropdown()
        
    }
    
    func numberOfRows(dropdownTableViewCellClass: String) -> Int {
        
        return self.sortByDropdownMenuItemsArray.count
        
    }
    
}
