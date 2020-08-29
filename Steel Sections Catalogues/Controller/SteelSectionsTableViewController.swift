//
//  BlueBookUniversalBeamsVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SteelSectionsTableViewController: UIViewController {
    
    var searchBarAutoCompleteBasedOnUserSelectionFromSearchBarOptionsDropListPopoverVC: String = ""
    
    // The below variable is needed whenever the user select Equal Angle Sections tableViewController to be displayed, in order to figure out whether the searchBarDropListOptionsViewController is currently displayed or not, since if it is displayed then it should not be dismissed unless the user select from the available options inside the searchBarDropListOptionsViewController. If it is not displayed, and let's say the user displayed the sortByPopoverViewController instead, and the user tapped anywhere on the screen outside the popOver area, then the popOverViewController should dismiss:
    
    var searcgBarDropListOptionsPopoverViewControllerIsCurrentlyPresentedOnScreen: Bool = false
    
    // MARK: - Data received from previous View Controller (i.e. OpenRolledSteelSectionsCollectionViewController):
    
    // The below is important in order to set the title of the NavigatioBar on this page, whether it is going to be Universal Beams (UB), Universal Columns (UC), Universal Bearing Piles (UBP), Parallel Flange Channels (PFC), Equal Leg Angles (L), Unequal Leg Angles (L), Tees (T) splift from UB or Tees (T) splift from UC:
    
    var receivedNavigatioBarTitleFromPreviousViewController: String = ""
    
    // The below is needed in order to figure out which collectionViewCell the user has pressed on from the previous viewController:
    
    var userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController: Int = 0
    
    // The below two variables will get their values later on inside the accessoryButtonTappedForRowWith method (i.e. when the user taps on a particular discoluse icon button displayed inside a tableView cell). These two variables will be sent to the next viewController (i.e. SelectedSteelSectionSummaryPage) that will be displayed based on which tableView cell disclosure icon button the user tapped on. And then they will be sent back to this viewController again once the displayed viewController for the particular tableView cell disclosure icon that got tapped gets dismissed:
    
    var userLastSelectedTableCellSectionNumberBeforeTheSelectedSteelSectionSummaryPageViewControllerWasDisplayed: Int = 0
    
    var userLastSelectedTableCellRowNumberBeforeTheSelectedSteelSectionSummaryPageViewControllerWasDisplayed: Int = 0
    
    // MARK: - Sorting/Searching criteria Variables definition:
    
    // The value of the sortBy Variable below is set by default to be equal to "None" which means that the data displayed inside the table will be sorted by Section Designation in Ascending Order as soon as this ViewController loads up for the first time:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed back and forth between this ViewController, TableViewSteelSectionsSortByOptionsPopoverViewController, TableViewSteelSectionsDataFilterOptions and SelectedSteelSectionSummaryPage in order to keep them up-to-date with the changes the user make to how the data inside the tableView is searched, sorted and/or filtered:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    // MARK: - Various arrays definitions:
    
    // The below Array is the one which contains the data extracted from the passed CSV file, depending on the selected CollectionViewCell from the previous ViewController. It contains the data in a one big Array, which contains several Arrays inside it, whereby each Array inside the big Array contains several Dictionaries. The below Array is going to be filled using the CSV parser which will be used later on:
    
    var extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser = [SteelSectionParameters]()
    
    // The below Arrays will get their values from either TableViewSteelSectionsDataFilterOptions or TableViewSteelSectionsSortByOptionsPopoverViewController in order to display the data inside the tableView accordingly:
    
    // Array gets filled by the data passed back from the TableViewSteelSectionsDataFilterOptions:
    
    var steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController = [SteelSectionParameters]()
    
    // Array gets filled by the data passed back from the TableViewSteelSectionsSortByOptionsPopoverViewController:
    
    var steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController = [SteelSectionParameters]()
    
    // The below array represents the array containing searchedData as per the user's search criteria out of the extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser:
    
    var steelSectionsDataArrayAsPerSearchedCriteria = [SteelSectionParameters]()
    
    // The below Array is mapped out from the extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser Array, whereby only sectionSerialNumbers are reported inside of it, with no duplication using the extension at the end of this Class (i.e., Array) and sorted in Ascending Order. The below array will be used in order to decide later on how may sections our tableView needs to display:
    
    var steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder: [String] = []
    
    // The below array contains all of the section serial numbers sorted in ascending or descending order, in order for them to be displayed as cells' headers when user sort data by Section Designation in Descending or Ascending Order:
    
    var steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder: [String] = []
    
    // MARK: - Search Bar, Navigation Bar and Table View instances definitions:
    
    var searchBar = UISearchBar()
    
    // The below code line declares the custom NavigationBar to be added to this ViewController. The reason it is defined as a lazy var, is to allow us to access the view properties of this ViewController. Since the custom NavigationBar is defined outside the viewDidLoad methods, or other methods where UIVIew is available. This navigationBar is going to have a left button (back button), Title in the middle (UILabel) and a rightButton (Sort Data). The title of this Navigation Br will depends in the selected Collection View Cell in the previous View Controller:
    
    lazy var navigationBar = CustomUINavigationBar(rightNavBarTitle: "Sort Data", rightNavBarButtonTarget: self, rightNavBarSelector: #selector(navigationBarRightButtonPressed(sender:)), navBarDelegate: self, navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: receivedNavigatioBarTitleFromPreviousViewController)
    
    let steelSectionsTableView = UITableView()
    
    // MARK: - ViewControllers instances definitions:
    
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    lazy var tableViewSteelSectionsSortByOptionsViewController = main.instantiateViewController(withIdentifier: "TableViewSteelSectionsSortByOptionsPopoverViewController")
    
    lazy var tableViewSteelSectionsDataFilterOptionsViewController = main.instantiateViewController(withIdentifier: "TableViewSteelSectionsDataFilterOptions") as! TableViewSteelSectionsDataFilterOptions
    
    lazy var searchBarDropListOptionsPopoverViewController = main.instantiateViewController(identifier: "SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController") as! SearchBarOptionsDropListPopoverViewControllerInsideOfSteelSectionsTableViewController
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // The below gesture is needed in order to go back to the previous View Controller when a right swipe gesture gets detected:
        
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(navigationBarLeftButtonPressed(sender:)))
        
        rightGestureRecognizer.direction = .right
        
        // MARK: - tapGesture declaration to dismiss keyboard:
        
        // The below code is needed in order to detect when a user has tapped on the screen, consequently dismisses the displayed on-screen keyboard:
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        setupSearchBar()
        
        setupTableView()
        
        // MARK: - Gestures & Adding subViews:
        
        view.addGestureRecognizer(tapGesture)
        
        view.addGestureRecognizer(rightGestureRecognizer)
        
        view.addSubview(searchBar)
        
        view.addSubview(navigationBar)
        
        view.addSubview(steelSectionsTableView)
        
        // MARK: - Parsing the CSV file to extract required data out of it:
        
        // We are going to call the parse function on the appropriate CSV file as soon as the application loads in order to extract the needed data to populate the tableView. The CSV file to be parsed will depends on the selected Collection View Cell number by the user made in the previous View Controller:
        
        switch userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController {
            
        case 0:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookUniversalBeamsSections")
            
        case 1:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookUniversalColumnsSections")
            
        case 2:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookUniversalBearingPilesSections")
            
        case 3:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookParallelFlangeChannelsSections")
            
        case 4:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookEqualLegAnglesSections")
            
        case 5:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookUnequalLegAnglesSections")
            
        case 6:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookTeesSplitFromUBSections")
            
        case 7:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookTeesSplitFromUCSections")
            
        default:
            
            parseCsvFile(csvFileToParse: "EurocodesBlueBookUniversalBeamsSections")
            
        }
        
        // The below code sorts the Data reported from the relevant CSV file using the Parser in Ascending Order by Section Designation by default, every time the view loads-up for the first time. Sort Method below does not create a new Array, it modifies the existing one:
        
        sortCsvExtractedSteelSectionsDataInAscendingOrder()
        
        // MARK: - Extracting all Steel Sections Serial Numbers from originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData Array (sorted in ascending order) and plugging them into universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault:
        
        // The below line of code extracts only the sectionSerialNumber Dictionary from the extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser as well as remove any duplicates from it. This data extracted will be sorted in Ascending order by default. The below will be used later on to decide how many sections we need to have inside our table, when the data gets sorted by Section Designation:
        
        steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser.map({ return $0.sectionSerialNumber }).removingDuplicates()
        
    }
    
    // MARK: - viewDidLayoutSubViews():
    
    override func viewDidLayoutSubviews() {
        
        // MARK: - Applying constraints to Navigation Bar, Search Bar and Table View:
        
        setupConstraints()
        
        // The below code is needed in order to dismiss the keyboard if the searchBar is empty:
        
        if searchBar.text?.isEmpty == true {
            
            searchBar.endEditing(true)
            
        }
        
    }
    
    // MARK: - viewDidAppear():
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Below code is required in order to scroll back inside the tableView to the last selected Row inside of its relevant Section by the user when they go back from the SelectedSteelSectionSummaryPage to this View Controller:
        
        self.steelSectionsTableView.scrollToRow(at: IndexPath.init(row: userLastSelectedTableCellRowNumberBeforeTheSelectedSteelSectionSummaryPageViewControllerWasDisplayed, section: userLastSelectedTableCellSectionNumberBeforeTheSelectedSteelSectionSummaryPageViewControllerWasDisplayed), at: UITableView.ScrollPosition.none, animated: true)
        
    }
    
    // MARK: - dismissKeyboard Method used by tapGesture:
    
    @objc func dismissKeyboard() {
        
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
        
    }
    
    // MARK: - Method to display Search Bar popover VC whenever the user type two characters inside the searchBar field of an equal and unequal angle sections. In order to know for example whether when the user type 10 whether he would like the first section serial number to be 10 or 100:
    
    func displaySearchBarPopoverVC() {
        
        searchBarDropListOptionsPopoverViewController.modalPresentationStyle = .popover
        
        let popover = searchBarDropListOptionsPopoverViewController.popoverPresentationController!
        
        popover.delegate = self
        
        popover.permittedArrowDirections = .up
        
        searchBarDropListOptionsPopoverViewController.preferredContentSize = CGSize(width: 270, height: 96)
        
        // The below code is needed in order for the backwards protocol which pass data backwards from the seachBarDropListOptionsPopoverViewController to this ViewController to work, since this this where we are assigning this viewController as the delegate for the searchBarDropListOptionsPopoverViewController (i.e. this is the viewController in charge):
        
        searchBarDropListOptionsPopoverViewController.delegate = self
        
        // The below specifies the location for the popover view up arrow head to start from the bottom left corner of the magnifying glass icon displayed in the left hand side of the searchBar textField:
        
        popover.sourceView = searchBar.searchTextField.leftView
        
        // The below code adjust the up arrow head pointer to go down 25 points from the location defined above:
        
        popover.sourceRect = CGRect(x: 0, y: 25, width: 0, height: 0)
        
        present(self.searchBarDropListOptionsPopoverViewController, animated: true, completion:{
            
            self.dismissKeyboard()
            
            self.searcgBarDropListOptionsPopoverViewControllerIsCurrentlyPresentedOnScreen = true
            
        })
        
    }
    
    // MARK: - UIAlertHandler Method for searchBar Popover VC. Whenever the user click on the UIAlert "Ok" button, he will be presented again with the searchBar Popover VC in order to force him to make a selection from the available options before proceeding further:
    
    func searchBarPopoverVCHandlerMethod(action: UIAlertAction) {
        
        displaySearchBarPopoverVC()
        
    }
    
    // MARK: - function that is needed to sort data array extracted from the CSV parser in Ascending order:
    
    func sortCsvExtractedSteelSectionsDataInAscendingOrder() {
        
        extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser.sort {
            
            // If the user selected Tee sections cut from Universal Beams or Columns Sections from the previous viewController (i.e. OpenRolledSteelSectionsCollectionViewController.swift file) then the sorting criteria will be according to the Universal Beam or Columns cross-section the T-section has been cut from rather than the actual full section designation itself:
            
            if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 7 {
                
                if $0.firstSectionSeriesNumberCrossSectionIsCutFrom != $1.firstSectionSeriesNumberCrossSectionIsCutFrom {
                    
                    return $0.firstSectionSeriesNumberCrossSectionIsCutFrom < $1.firstSectionSeriesNumberCrossSectionIsCutFrom
                    
                } else if $0.secondSectionSeriesNumberCrossSectionIsCutFrom != $1.secondSectionSeriesNumberCrossSectionIsCutFrom && $0.firstSectionSeriesNumberCrossSectionIsCutFrom == $1.firstSectionSeriesNumberCrossSectionIsCutFrom {
                    
                    return $0.secondSectionSeriesNumberCrossSectionIsCutFrom < $1.secondSectionSeriesNumberCrossSectionIsCutFrom
                    
                } else {
                    
                    return $0.thirdSectionSeriesNumberCrossSectionIsCutFrom < $1.thirdSectionSeriesNumberCrossSectionIsCutFrom
                    
                }
                
            }
                
                // Otherwise the sorting criteria will be carried out according to the actual full section designation of the selected cross-section from the previous viewController (i.e. OpenRolledSteelSectionsCollectionViewController.swift file):
                
            else {
                
                if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                    
                    return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                    
                } else if $0.secondSectionSeriesNumber != $1.secondSectionSeriesNumber && $0.firstSectionSeriesNumber == $1.firstSectionSeriesNumber {
                    
                    return $0.secondSectionSeriesNumber < $1.secondSectionSeriesNumber
                    
                } else {
                    
                    return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                    
                }

            }
            
        }
        
    }
    
    // MARK: - Setup tableView:
    
    func setupTableView() {
        
        steelSectionsTableView.dataSource = self
        
        steelSectionsTableView.delegate = self
        
        // The below line of code is needed in order to flash the tableViewScrollIndicator when this viewController loads up for the first time, in order to draw the user's attention that data can be scrolled through vertically:
        
        steelSectionsTableView.flashScrollIndicators()
        
        steelSectionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        steelSectionsTableView.allowsSelection = false
        
        // The below line of code is needed in order to avoid displaying extra empty cells inside of our tableView:
        
        steelSectionsTableView.tableFooterView = UIView()
        
        steelSectionsTableView.backgroundColor = UIColor(named: "Table View Background Colour")
        
        steelSectionsTableView.separatorColor = UIColor(named: "Table View Cells Separation Line Colour")
        
        // It is very important to note that the below code, which calculates the dynamic height of a TableView Cell only works when all the required constrains (i.e., Top, Right, Bottom and Left) for all subViews to be displayed inside the tableView Cell are defined:
        
        steelSectionsTableView.estimatedRowHeight = 120
        
        steelSectionsTableView.rowHeight = UITableView.automaticDimension
        
        // The below IF STATEMENT is needed in order to decide which custom tableView cell should be used depending on the selected collectionViewCell from the ClosedSteelSectionsCollectionViewController:
        
        // Below code gets executed if the user selected an equal or unequal leg section:
        
        if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 4 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 5 {
            
            steelSectionsTableView.register(LegSteelSectionCustomTableViewCell.self, forCellReuseIdentifier: "LegSteelSectionCustomTableViewCell")
            
        }
            
            // Below code gets executed if the user selected either a Tee section cut from a UB or UC:
            
        else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 7 {
            
            steelSectionsTableView.register(CustomTableViewCellForTeeSteelSections.self, forCellReuseIdentifier: "CustomTableViewCellForTeeSteelSections")
            
        }
            
            // Below code gets executed for all other selections:
            
        else {
            
            steelSectionsTableView.register(CustomTableViewCellForIandPFCSteelSections.self, forCellReuseIdentifier: "CustomTableViewCellForIandPFCSteelSections")
            
        }
        
    }
    
    // MARK: - Setup SearchBar:
    
    func setupSearchBar() {
        
        searchBar.delegate = self
        
        searchBar.showsBookmarkButton = true
        
        // The below line of code sets the image to be used for the filter results button as well as asks Xcode to render the image in its original conditions without applying any additional effects:
        
        let searchBarFilterImageForNormalState = UIImage(named:"searchBarFilterButtonIcon - Normal State")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarFilterImageForHighlightedState = UIImage(named:"searchBarFilterButtonIcon - Highlighted State")?.withRenderingMode(.alwaysOriginal)
        
        searchBar.setImage(searchBarFilterImageForNormalState, for: .bookmark, state: .normal)
        
        searchBar.setImage(searchBarFilterImageForHighlightedState, for: .bookmark, state: .highlighted)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.searchTextField.contentVerticalAlignment = .center
        
        searchBar.sizeToFit()
        
        searchBar.placeholder = "Search by Section Designation..."
        
        // The below line of code make use of the UISearchbar Extension, which allows for quick changes to be made for the colour of the placeholder text inside the UISearchBar text field:
        
        searchBar.setPlaceholder(textColor: UIColor(named: "Search Bar Text Field Placeholder Text And Search Icon Colour")!)
        
        // The below line of code make use of the UISearchbar Extension, which allows for quick changes to be made for the colour of the search icon (i.e. magnifying glass inside the UISearchBar text field:
        
        searchBar.setSearchImage(color: UIColor(named: "Search Bar Text Field Placeholder Text And Search Icon Colour")!)
        
        // The below line of code make use of the UISearchbar Extension, which allows for quick changes to be made for the colour of the text that the user will type inside the UISearchBar text field:
        
        searchBar.set(textColor: UIColor(named: "Search Bar Text Field Label Text Font Colour")!)
        
        // The below line of code make use of the UISearchbar Extension, which allows for quick changes to be made for the background colour of the UISearchBar text field:
        
        searchBar.setTextField(color: UIColor(named: "Search Bar Text Field Background Colour")!.withAlphaComponent(0.6))
        
        // The below line of code sets the font type and size to be used for the placeholder text as well as the text typed by the user inside the UISearchBar text field:
        
        searchBar.searchTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        
        searchBar.barStyle = UIBarStyle.default
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        
        // The below line of code sets the frame's background colour of the UISearchBar:
        
        searchBar.barTintColor = UIColor(named: "Search Bar Background Colour")
        
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchBar
                .searchTextField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor, constant: 0),
            
            searchBar.searchTextField.leftAnchor.constraint(equalTo: searchBar.leftAnchor, constant: 5),
            
            searchBar.searchTextField.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: -5)
            
        ])
        
        searchBar.isTranslucent = false
        
        searchBar.keyboardType = .numberPad
        
    }
    
    // MARK: Setup Constraints for navigationBar, searchBar and tableView:
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            steelSectionsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            
            steelSectionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            steelSectionsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            steelSectionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
        ])
        
    }
    
    // MARK: CSV Parser Method:
    
    // We want to create a function that will parse the Steel Sections CSV data into a format that is useful:
    
    func parseCsvFile(csvFileToParse: String) {
        
        // We first need a path for where the CSV file is located. The below can be forced un-wrapped since we know for sure that the path for the file does exist:
        
        let path = Bundle.main.path(forResource: csvFileToParse, ofType: "csv")!
        
        // Then we need to use the parser (i.e., CsvParser.swift) which can throw an error, thus, we need to use a do catch statement:
        
        do {
            
            // In the below line of code we are passing the path of the CSV file we are interested in extracting its data and pass it to the CsvParser Class:
            
            let csv = try CsvParser(contentOfURL: path)
            
            // The below line of code will generate an array of dictionaries, whereby each parsed CSV row represents an Array of Dictionaries:
            
            let rows = csv.rows
            
            // Now we want to pull out the data that we are interested in out of the parsed csv file generated in the above line of code. As the above code line will spit out the data in an Arrays of Dictionaries format, whereby each line is going to be an Array, which contains multiple dictionaries inside of it, and each Dictionary is going to have a title as its Key and a value as its Value. We need to loop through each row and pull out the data we want. Then each extraced row (Array of Dictionaries) is going to be appended to the big Array (i.e., originalUniversalBeamsArrayDataExtractedFromTheCsvFileUsingTheParserWithAllData) which is going to contain all other Arrays:
            
            for row in rows {
                
                let firstSectionSeriesNumber = Int(row["First Section Series Number"]!)!
                
                let secondSectionSeriesNumber = Int(row["Second Section Series Number"]!)!
                
                let lastSectionSeriesNumber = Double(row["Last Section Series Number"]!)!
                
                let sectionSerialNumber = row["Section Serial Number"]!
                
                let fullSectionDesignation = row["Full Section Designation"]!
                
                let firstSectionSeriesNumberCrossSectionIsCutFrom = Int(row["First Section Series Number Cross-Section is Cut From"]!)!
                
                let secondSectionSeriesNumberCrossSectionIsCutFrom = Int(row["Second Section Series Number Cross-Section is Cut From"]!)!
                
                let thirdSectionSeriesNumberCrossSectionIsCutFrom = Int(row["Third Section Series Number Cross-Section is Cut From"]!)!
                
                let sectionSerialNumberCrossSectionIsCutFrom = row["Section Serial Number Cross-Section is Cut From"]!
                
                let sectionCutFromUniversalBeam = row["Cut from Universal Beams"]!
                
                let sectionCutFromUniversalColumn = row["Cut from Universal Columns"]!
                
                let sectionMassPerMetre = Double(row["Mass Per Metre (kg/m)"]!)!
                
                let sectionLegLength = Double(row["Leg Length [h] (mm)"]!)!
                
                let sectionTotalDepth = Double(row["Depth of Section [h] (mm)"]!)!
                
                let sectionWidth = Double(row["Width of Section [b] (mm)"]!)!
                
                let sectionLegThickness = Double(row["Leg Thickness [t] (mm)"]!)!
                
                let sectionWebThickness = Double(row["Web Thickness [tw] (mm)"]!)!
                
                let sectionFlangeThickness = Double(row["Flange Thickness [tf] (mm)"]!)!
                
                let sectionRootRadiusOne = Double(row["Root Radius [r1] (mm)"]!)!
                
                let sectionRootRadiusTwo = Double(row["Toe Radius [r2] (mm)"]!)!
                
                let sectionDepthBetweenFillets = Double(row["Depth between Fillets [d] (mm)"]!)!
                
                let sectionLocalDiameterBucklingRatio = Double(row["Ratio for local Buckling [d/t]"]!)!
                
                let sectionLocalWebBucklingRatio = Double(row["Ratio for Local Web Buckling [cw/tw] (mm)"]!)!
                
                let sectionLocalFlangeBucklingRatio = Double(row["Ratio for Local Flange Buckling [cf/tf] (mm)"]!)!
                
                let sectionShearCentreFromWebCentreline = Double(row["Shear Centre from Web Centreline [e0] (cm)"]!)!
                
                let sectionCentreOfGravityXdirection = Double(row["Centre of Gravity X-direction (cm)"]!)!
                
                let sectionCentreOfGravityYdirection = Double(row["Centre of Gravity y-direction (cm)"]!)!
                
                let sectionEndClearanceDimensionForDetailing = Int(row["End Clearance [C] (mm)"]!)!
                
                let sectionNotchNdimensionForDetailing = Int(row["Dimension for Detailing Notch [N] (mm)"]!)!
                
                let sectionNotchnDimensionForDetailing = Int(row["Dimension for Detailing Notch [n] (mm)"]!)!
                
                let sectionSurfaceAreaPerMetre = Double(row["Surface Area per Metre (m2)"]!)!
                
                let sectionSurfaceAreaPerTonne = Double(row["Surface Area per Tonne (m2)"]!)!
                
                let sectionMajorSecondMomentOfAreaAboutYYaxis = Double(row["Second Moment of Area yy axis Major [cm4]"]!)!
                
                let sectionMinorSecondMomentOfAreaAboutZZaxis = Double(row["Second Moment of Area zz axis Minor [cm4]"]!)!
                
                let sectionMajorSecondMomentOfAreaAboutUUaxis = Double(row["Second Moment of Area uu axis  [cm4]"]!)!
                
                let sectionMinorSecondMomentOfAreaAboutVVaxis = Double(row["Second Moment of Area vv axis Minor [cm4]"]!)!
                
                let sectionMajorRadiusOfGyrationAboutYYaxis = Double(row["Radius of Gyration yy axis Major [cm]"]!)!
                
                let sectionMinorRadiusOfGyrationAboutZZaxis = Double(row["Radius of Gyration zz axis Minor [cm]"]!)!
                
                let sectionMajorRadiusOfGyrationAboutUUaxis = Double(row["Radius of Gyration uu axis Major [cm]"]!)!
                
                let sectionMinorRadiusOfGyrationAboutVVaxis = Double(row["Radius of Gyration vv axis Minor [cm]"]!)!
                
                let sectionMajorElasticModulusAboutYYaxis = Double(row["Elastic Modulus yy axis Major [cm3]"]!)!
                
                let sectionMinorElasticModulusAboutZZaxis = Double(row["Elastic Modulus zz axis Minor [cm3]"]!)!
                
                let sectionMajorFlangeElasticModulusAboutYYaxis = Double(row["Elastic Modulus Flange yy axis Major [cm3]"]!)!
                
                let sectionMajorToeElasticModulusAboutYYaxis = Double(row["Elastic Modulus Toe yy axis Major [cm3]"]!)!
                
                let sectionMinorToeElasticModulusAboutZZaxis = Double(row["Elastic Modulus Toe zz axis Minor [cm3]"]!)!
                
                let sectionMajorPlasticModulusAboutYYaxis = Double(row["Plastic Modulus yy axis Major [cm3]"]!)!
                
                let sectionMinorPlasticModulusAboutZZaxis = Double(row["Plastic Modulus zz axis Minor [cm3]"]!)!
                
                let sectionAngleAxisYYtoAxisUUtanAlpha = Double(row["Angle Axis yy to Axis uu Tanα"]!)!
                
                let sectionBucklingParameterU = Double(row["Buckling Parameter (U)"]!)!
                
                let sectionTorsionalIndexX = Double(row["Torsional Index (X)"]!)!
                
                let sectionWarpingConstantIwInDm6 = Double(row["Warping Constant (Iw) [dm6]"]!)!
                
                let sectionWarpingConstantIwInCm6 = Double(row["Warping Constant (Iw) [cm6]"]!)!
                
                let sectionTorsionalConstantIt = Double(row["Torsional Constant (IT) [cm4]"]!)!
                
                let sectionTorsionalConstantWt = Double(row["Torsional Constant (Wt) [cm3]"]!)!
                
                let sectionEquivalentSlendernessCoefficient = Double(row["Equivalent Slenderness Coefficient (ϕa)"]!)!
                
                let sectionMinimumEquivalentSlendernessCoefficient = Double(row["Equivalent Slenderness Coefficient Min.  (ϕa)"]!)!
                
                let sectionMaximumEquivalentSlendernessCoefficient = Double(row["Equivalent Slenderness Coefficient Max.  (ϕa)"]!)!
                
                let sectionMonoSymmetryIndexPsiA = Double(row["Mono-symmetry Index (ψa)"]!)!
                
                let sectionMonoSymmetryIndexPsi = Double(row["Mono-symmetry Index (ψ)"]!)!
                
                let sectionArea = Double(row["Area of Section [cm2]"]!)!
                
                let individualSteelSectionArrayOfDictionaries = SteelSectionParameters(firstSectionSeriesNumber: firstSectionSeriesNumber, secondSectionSeriesNumber: secondSectionSeriesNumber, lastSectionSeriesNumber: lastSectionSeriesNumber, sectionSerialNumber: sectionSerialNumber, fullSectionDesignation: fullSectionDesignation, firstSectionSerialNumberCrossSectionIsCutFrom: firstSectionSeriesNumberCrossSectionIsCutFrom, secondSectionSerialNumberCrossSectionIsCutFrom: secondSectionSeriesNumberCrossSectionIsCutFrom, thirdSectionSerialNumberCrossSectionIsCutFrom: thirdSectionSeriesNumberCrossSectionIsCutFrom, sectionSerialNumberCrossSectionIsCutFrom: sectionSerialNumberCrossSectionIsCutFrom, sectionCutFromUniversalBeam: sectionCutFromUniversalBeam, sectionCutFromUniversalColumn: sectionCutFromUniversalColumn, sectionMassPerMetre: sectionMassPerMetre, sectionLegLength: sectionLegLength, sectionTotalDepth: sectionTotalDepth, sectionWidth: sectionWidth, sectionLegThickness: sectionLegThickness, sectionWebThickness: sectionWebThickness, sectionFlangeThickness: sectionFlangeThickness, sectionRootRadiusOne: sectionRootRadiusOne, sectionRootRadiusTwo: sectionRootRadiusTwo, sectionDepthBetweenFillets: sectionDepthBetweenFillets, sectionLocalDiameterBucklingRatio: sectionLocalDiameterBucklingRatio, sectionLocalWebBucklingRatio: sectionLocalWebBucklingRatio, sectionLocalFlangeBucklingRatio: sectionLocalFlangeBucklingRatio, sectionShearCentreFromWebCentreline: sectionShearCentreFromWebCentreline, sectionCentreOfGravityXdirection: sectionCentreOfGravityXdirection, sectionCentreOfGravityYdirection: sectionCentreOfGravityYdirection, sectionEndClearanceDimensionForDetailing: sectionEndClearanceDimensionForDetailing, sectionNotchNdimensionForDetailing: sectionNotchNdimensionForDetailing, sectionNotchnDimensionForDetailing: sectionNotchnDimensionForDetailing, sectionSurfaceAreaPerMetre: sectionSurfaceAreaPerMetre, sectionSurfaceAreaPerTonne: sectionSurfaceAreaPerTonne, sectionMajorSecondMomentOfAreaAboutYYaxis: sectionMajorSecondMomentOfAreaAboutYYaxis, sectionMinorSecondMomentOfAreaAboutZZaxis: sectionMinorSecondMomentOfAreaAboutZZaxis, sectionMajorSecondMomentOfAreaAboutUUaxis: sectionMajorSecondMomentOfAreaAboutUUaxis, sectionMinorSecondMomentOfAreaAboutVVaxis: sectionMinorSecondMomentOfAreaAboutVVaxis, sectionMajorRadiusOfGyrationAboutYYaxis: sectionMajorRadiusOfGyrationAboutYYaxis, sectionMinorRadiusOfGyrationAboutZZaxis: sectionMinorRadiusOfGyrationAboutZZaxis, sectionMajorRadiusOfGyrationAboutUUaxis: sectionMajorRadiusOfGyrationAboutUUaxis, sectionMinorRadiusOfGyrationAboutVVaxis: sectionMinorRadiusOfGyrationAboutVVaxis, sectionMajorElasticModulusAboutYYaxis: sectionMajorElasticModulusAboutYYaxis, sectionMinorElasticModulusAboutZZaxis: sectionMinorElasticModulusAboutZZaxis, sectionMajorFlangeElasticModulusAboutYYaxis: sectionMajorFlangeElasticModulusAboutYYaxis, sectionMajorToeElasticModulusAboutYYaxis: sectionMajorToeElasticModulusAboutYYaxis, sectionMinorToeElasticModulusAboutZZaxis: sectionMinorToeElasticModulusAboutZZaxis, sectionMajorPlasticModulusAboutYYaxis: sectionMajorPlasticModulusAboutYYaxis, sectionMinorPlasticModulusAboutZZaxis: sectionMinorPlasticModulusAboutZZaxis, sectionAngleAxisYYtoAxisUUtanAlpha: sectionAngleAxisYYtoAxisUUtanAlpha, sectionBucklingParameterU: sectionBucklingParameterU, sectionTorsionalIndexX: sectionTorsionalIndexX, sectionWarpingConstantIwInDm6: sectionWarpingConstantIwInDm6, sectionWarpingConstantIwInCm6: sectionWarpingConstantIwInCm6, sectionTorsionalConstantIt: sectionTorsionalConstantIt, sectionTorsionalConstantWt: sectionTorsionalConstantWt, sectionEquivalentSlendernessCoefficient: sectionEquivalentSlendernessCoefficient, sectionMinimumEquivalentSlendernessCoefficient: sectionMinimumEquivalentSlendernessCoefficient, sectionMaximumEquivalentSlendernessCoefficient: sectionMaximumEquivalentSlendernessCoefficient, sectionMonoSymmetryIndexPsiA: sectionMonoSymmetryIndexPsiA, sectionMonoSymmetryIndexPsi: sectionMonoSymmetryIndexPsi, sectionArea: sectionArea)
                
                // Then we need to append each of the above created Array of Dictionaries to the main Array declared above:
                
                extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser.append(individualSteelSectionArrayOfDictionaries)
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
}

// MARK: - UINavigationBarDelegate Extension:

extension SteelSectionsTableViewController: UINavigationBarDelegate {
    
    // MARK: Navigation Bar Left button pressed (back button):
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "OpenAndClosedSteelSectionsTabViewController")
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    // MARK: - Navigaton Bar Right button pressed (Sort Data button):
    
    @objc func navigationBarRightButtonPressed(sender : UIButton) {
        
        tableViewSteelSectionsSortByOptionsViewController.modalPresentationStyle = .popover
        
        let popover = tableViewSteelSectionsSortByOptionsViewController.popoverPresentationController!
        
        popover.delegate = self
        
        popover.permittedArrowDirections = .up
        
        // The below code is needed in order to set the size of the pop-over view controller:
        
        tableViewSteelSectionsSortByOptionsViewController.preferredContentSize = CGSize(width: 320, height: 160)
        
        // The sourceView in the below code line represents the view containing the anchor rectangle for the popover:
        
        popover.sourceView = navigationBar.navigationBarRightButtonView
        
        // The sourceRect in the below code line represents The rectangle in the specified view in which to anchor the popover:
        
        popover.sourceRect = navigationBar.navigationBarRightButtonView.bounds
        
        let viewControllerToPassDataTo = tableViewSteelSectionsSortByOptionsViewController as! TableViewSteelSectionsSortByOptionsPopoverViewController
        
        viewControllerToPassDataTo.delegate = self
        
        // Below we are passing the Variables sortBy, isSearching and filtersApplied from this View Controller onto the TableViewSteelSectionsSortByOptionsPopoverViewController:
        
        viewControllerToPassDataTo.sortBy = self.sortBy
        
        viewControllerToPassDataTo.isSearching = self.isSearching
        
        viewControllerToPassDataTo.filtersApplied = self.filtersApplied
        
        // Below we are passing the extracted CSV steel sections data array from this View Controller onto the TableViewSteelSectionsSortByOptionsPopoverViewController:
        
        viewControllerToPassDataTo.receivedSteelSectionsDataArrayFromSteelSectionsTableViewController = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser
        
        viewControllerToPassDataTo.userLastSelectedCollectionViewCellNumber = self.userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController
        
        present(viewControllerToPassDataTo, animated: true, completion:{
            
            self.dismissKeyboard()
            
        })
        
    }
    
    // The below function is needed in order for the Navigation Bar to be attached directly underneath the bottom of the top Status Bar:
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

// MARK: - UITableViewDataSource Extension:

// Below is the tableViewDataSource extension onto this viewController. The methods inside this extension will provide all needed data for the tableView:

extension SteelSectionsTableViewController: UITableViewDataSource {
    
    // MARK: - numberOfSection:
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // The below lines of code check the values of the sortBy, filtersApplied and isSearching Variables in order to decide on how many sections the tableView should contains. The tableView will only displays multiple sections when the data is sorted by Section Designation in an ascending or descending order, and isSearching as well as filtersApplied variables are both equal to false:
        
        if sortBy == "Sorted by: Section designation in ascending order" || sortBy == "Sorted by: Section designation in descending order" {
            
            return steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder.count
            
        } else if sortBy == "None" && filtersApplied == false && isSearching == false {
            
            return steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder.count
            
        }
            
            // In the case where the data to be displayed inside the tableView are not sorted by Section Designation in Ascending or Descending Order then we are only going to have one Section Header for our tableView, which will cotains the title:
            
        else  {
            
            return 1
            
        }
        
    }
    
    // MARK: - viewForHeaderInSection:
    
    // The below function defines the properties of section headers as well as what should be displayed inside them:
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        
        let sectionHeaderTitle = UILabel()
        
        sectionHeaderTitle.translatesAutoresizingMaskIntoConstraints = false
        
        sectionHeaderTitle.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        
        sectionHeaderView.backgroundColor = UIColor(named: "Table View Sections Header Background Colour")
        
        sectionHeaderTitle.textColor = UIColor(named: "Table View Section Header Text Colour")
        
        sectionHeaderTitle.textAlignment = .left
        
        sectionHeaderTitle.baselineAdjustment = .alignCenters
        
        sectionHeaderTitle.numberOfLines = 0
        
        if sortBy == "Sorted by: Section designation in ascending order" || sortBy == "Sorted by: Section designation in descending order" {
            
            // In this case the title for each section header is equal to each section serial number (thus, we will have multiple Section Headers for each set of Section Serial Number):
            
            sectionHeaderTitle.text = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder[section] + " Series"
            
        }
            
        else if sortBy == "None" && isSearching == false && filtersApplied == false {
            
            sectionHeaderTitle.text = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder [section] + " Series"
            
        }
            
            // If the below case is true then we are only going to have one Section Header:
            
        else if sortBy == "Sorted by: Depth of section in ascending order" || sortBy == "Sorted by: Width of section in ascending order" || sortBy == "Sorted by: Area of section in ascending order" || sortBy == "Sorted by: Depth of section in descending order" || sortBy == "Sorted by: Width of section in descending order" || sortBy == "Sorted by: Area of section in descending order" {
            
            sectionHeaderTitle.text = self.sortBy
            
        } else if isSearching == true {
            
            sectionHeaderTitle.text = "Searched results:"
            
        } else if filtersApplied == true {
            
            sectionHeaderTitle.text = "Filtered data:"
            
        }
        
        sectionHeaderView.addSubview(sectionHeaderTitle)
        
        NSLayoutConstraint.activate([
            
            sectionHeaderTitle.leftAnchor.constraint(equalTo: sectionHeaderView.leftAnchor, constant: 20),
            
            sectionHeaderTitle.rightAnchor.constraint(equalTo: sectionHeaderView.rightAnchor, constant: -20),
            
            sectionHeaderTitle.topAnchor.constraint(equalTo: sectionHeaderView.topAnchor),
            
            sectionHeaderTitle.bottomAnchor.constraint(equalTo: sectionHeaderView.bottomAnchor)
            
        ])
        
        return sectionHeaderView
        
    }
    
    // MARK: - numberOfRowsInSection:
    
    // The below method will be used in order to decide how many rows each tableView section is going to have:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The below two arrays will be filled depending on the value of the exchanged Variables namely; sortBy, filtersApplied and isSearching. In turn these Arrays will be used in order to decide how many rows each tableView section is going to have:
        
        var extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParserConvertedIntoKeyValuePairsTuples = [(String, Int)]()
        
        var numberOfRowsRequiredForEachSteelSectionSerialNumber = [String : Int]()
        
        if sortBy == "Sorted by: Section designation in ascending order" || sortBy == "Sorted by: Section designation in descending order" {
            
            // The below line of code will convert the extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser Array into an Array of key-value pairs using tuples, where each value has the number 1. This is needed in order to enable us to count how many times a specific serial number occurs to know how many rows its relevant section needs to have:
            
            extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParserConvertedIntoKeyValuePairsTuples = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController.map { ($0.sectionSerialNumber, 1) }
            
            // The below line of code create a Dictionary from the above tuple array, asking it to add the 1s together every time it finds a duplicate key:
            
            numberOfRowsRequiredForEachSteelSectionSerialNumber = Dictionary(extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParserConvertedIntoKeyValuePairsTuples, uniquingKeysWith: +)
            
            return numberOfRowsRequiredForEachSteelSectionSerialNumber["\(steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder[section])"]!
            
        } else if sortBy == "None" && filtersApplied == false && isSearching == false {
            
            extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParserConvertedIntoKeyValuePairsTuples = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser.map { ($0.sectionSerialNumber, 1) }
            
            // The below line of code create a Dictionary from the above tuple array, asking it to add the 1s together every time it finds a duplicate key:
            
            numberOfRowsRequiredForEachSteelSectionSerialNumber = Dictionary(extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParserConvertedIntoKeyValuePairsTuples, uniquingKeysWith: +)
            
            return numberOfRowsRequiredForEachSteelSectionSerialNumber["\(steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder[section])"]!
            
        } else if filtersApplied == true {
            
            // Below we are first checking whether any steel section has been found as per the user's filters criteria, if there is then the number of rows to be displayed will be equal to the number of steel sections filtered. Otherwise, if there is not, then we will only display one row which will contain the message saying that "no section has been found as per the applied filters, try again":
            
            if steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController.count > 0 {
                
                return steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController.count
                
            } else {
                
                return 1
                
            }
            
        } else if sortBy == "Sorted by: Depth of section in ascending order" || sortBy == "Sorted by: Width of section in ascending order" || sortBy == "Sorted by: Area of section in ascending order" || sortBy == "Sorted by: Depth of section in descending order" || sortBy == "Sorted by: Width of section in descending order" || sortBy == "Sorted by: Area of section in descending order" {
            
            return steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController.count
            
        } else if isSearching == true {
            
            // Below we are first checking whether any steel section has been found as per the user's searched criteria, if there is then the number of rows to be displayed will be equal to the number of steel sections found. Otherwise, if there is not, then we will only display one row which will contain the message saying that "no section has been found, try again":
            
            if steelSectionsDataArrayAsPerSearchedCriteria.count > 0 {
                
                return steelSectionsDataArrayAsPerSearchedCriteria.count
                
            } else {
                
                return 1
                
            }
            
        } else {
            
            return 1
            
        }
        
    }
    
    // MARK: - cellForRowAtIndexPath:
    
    // The below function will be used in order to populate the required data for each tableView cell:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // The below custom tableView cell will be used to display data related to the following steel sections, UBs, UCs, UBPs or PFCs:
        
        let cutomTableViewCellForIandPFCSteelSections = Bundle.main.loadNibNamed("CustomTableViewCellForIandPFCSteelSections", owner: self, options: nil)?.first as! CustomTableViewCellForIandPFCSteelSections
        
        // The below custom tableView cell will be used to display data related to L-profile steel section such as; Equal Leg Angles and Unequal Leg Angles:
        
        let customTableViewCellForLshapedSections = Bundle.main.loadNibNamed("LegSteelSectionCustomTableViewCell", owner: self, options: nil)?.first as! LegSteelSectionCustomTableViewCell
        
        // The below custom tableView cell will be used to display data related to Tee steel sections:
        
        let customTableViewCellForTeeShapedSteelSections = Bundle.main.loadNibNamed("CustomTableViewCellForTeeSteelSections", owner: self, options: nil)?.first as! CustomTableViewCellForTeeSteelSections
        
        // The below custom tableView cell will be used to display specific messages to the user, for example when specific search criteria by the user couldn't find relevant data:
        
        let tableViewErrorMessageCell = Bundle.main.loadNibNamed("CustomTableViewMessageCell", owner: self, options: nil)?.first as! CustomTableViewMessageCell
        
        // The below arrays will be filled depending on the outcome of the below IF STATEMENTS:
        
        var arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = [SteelSectionParameters]()
        
        var arrayContainingDataRelatedOnlyToSectionsSerialNumbers: [String] = [""]
        
        if (sortBy == "None" && filtersApplied == false && isSearching == false) || sortBy == "Sorted by: Section designation in ascending order" ||  sortBy == "Sorted by: Section designation in descending order" {
            
            // The below represents the default case as soon as the tableView gets loaded for the first time:
            
            if (sortBy == "None" && filtersApplied == false && isSearching == false) {
                
                arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser
                
                arrayContainingDataRelatedOnlyToSectionsSerialNumbers = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder
                
            }
                
                // The below IF STATEMENT represents the case when the user select to sort results either by Section Designation in Ascending or Descending order:
                
            else {
                
                arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController
                
                arrayContainingDataRelatedOnlyToSectionsSerialNumbers = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder
                
            }
            
            // The below lines of code are needed in order to fill the tableView cells with needed data:
            
            // The below checks whether ther user has selected Universal Beams, Universal Columns, Universal Bearing Piles or Parallel Flange Channels from the OpenRolledSteelSectionsCollectionViewController, and if so then the customTableViewCellForIandPFCandTsteelSections will be used to display relevant data:
            
            if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 0 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 1 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 2 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 3 {
                
                // The below is needed in order to display information related to the Section Designation:
                
                cutomTableViewCellForIandPFCSteelSections.sectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section] }).map({ $0.fullSectionDesignation })[indexPath.row])"
                
                // The below is needed in order to display information related to the Total Depth of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.depthOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.depthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Width of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.widthOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.widthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Flange Thickness of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.flangeThicknessLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.flangeThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Flange Thickness", cellSubLabelText: "Flange Thickness, tf [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 18, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 19, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Web Thickness of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.webThicknessLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.webThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Web Thickness", cellSubLabelText: "Web Thickness, tw [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 16, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Mass per Metre of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.massPerMetreLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.massPerMetreLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Area of the Section:
                
                cutomTableViewCellForIandPFCSteelSections.areaOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.areaOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return cutomTableViewCellForIandPFCSteelSections
                
            }
                
                // The below checks whether ther user has selected Equal Leg Angles or Unequal Leg Angles from the OpenRolledSteelSectionsCollectionViewController, and if so then the customTableViewCellForLshapedSections will be used to display relevant data:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 4 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 5 {
                
                // The below is needed in order to display information related to the Section Designation:
                
                customTableViewCellForLshapedSections.steelAngleSectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section] }).map({ $0.fullSectionDesignation })[indexPath.row])"
                
                // The below is needed in order to display information related to the Total Depth of the Section:
                
                customTableViewCellForLshapedSections.steelAngleDepthLabel.attributedText = customTableViewCellForLshapedSections.steelAngleDepthLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Width of the Section:
                
                customTableViewCellForLshapedSections.steelAngleWidthLabel.attributedText = customTableViewCellForLshapedSections.steelAngleWidthLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Thickness of the Section:
                
                customTableViewCellForLshapedSections.steelAngleThicknessLabel.attributedText = customTableViewCellForLshapedSections.steelAngleThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Leg Thickness", cellSubLabelText: "Leg Thickness, t [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionLegThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Mass per Metre of the Section:
                
                customTableViewCellForLshapedSections.steelAngleMassPerMetre.attributedText = customTableViewCellForLshapedSections.steelAngleMassPerMetre.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Area of the Section:
                
                customTableViewCellForLshapedSections.steelAngleSectionArea.attributedText = customTableViewCellForLshapedSections.steelAngleSectionArea.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return customTableViewCellForLshapedSections
                
            }
                
                // The below code will use the customTableViewCell for Tee Steel Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 7 {
                
                // The below is needed in order to display information related to the Section Designation:
                
                customTableViewCellForTeeShapedSteelSections.actualSectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section] }).map({ $0.fullSectionDesignation })[indexPath.row])"
                
                if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 {
                    
                    customTableViewCellForTeeShapedSteelSections.crossSectionTeeSectionCutFromLabel.text = "Section Cut from: UB \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section] }).map({ $0.sectionCutFromUniversalBeam })[indexPath.row])"
                    
                } else {
                    
                    customTableViewCellForTeeShapedSteelSections.crossSectionTeeSectionCutFromLabel.text = "Section Cut from: UC \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section] }).map({ $0.sectionCutFromUniversalColumn })[indexPath.row])"
                    
                }
                
                // The below is needed in order to display information related to the Total Depth of the Section:
                
                customTableViewCellForTeeShapedSteelSections.depthOfSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.depthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Width of the Section:
                
                customTableViewCellForTeeShapedSteelSections.widthOfSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.widthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Flange Thickness of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionFlangeSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionFlangeSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Flange Thickness", cellSubLabelText: "Flange Thickness, tf [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 18, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 19, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Web Thickness of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionWebThicknessLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionWebThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Web Thickness", cellSubLabelText: "Web Thickness, tw [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 16, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Mass per Metre of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionMassPerMetreLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionMassPerMetreLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Area of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionAreaLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionAreaLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.filter({ $0.sectionSerialNumber == "\(arrayContainingDataRelatedOnlyToSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return customTableViewCellForTeeShapedSteelSections
                
            }
            
        }
            
            // The below catches the cases where the user sorted data by any criteria other than "None", Section Designation in Ascending or Descending order or filters or searches are applied:
            
        else {
            
            if (sortBy == "Sorted by: Depth of section in ascending order" || sortBy == "Sorted by: Width of section in ascending order" || sortBy == "Sorted by: Area of section in ascending order" || sortBy == "Sorted by: Depth of section in descending order" || sortBy == "Sorted by: Width of section in descending order" || sortBy == "Sorted by: Area of section in descending order") {
                
                arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController
                
            } else if isSearching == true {
                
                arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = steelSectionsDataArrayAsPerSearchedCriteria
                
                // The below IF STATEMENT catches the case where there are no results to be displayed due to invalid searched criteria:
                
                if arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.count == 0 {
                    
                    tableViewErrorMessageCell.messageLabel.text = "Invalid search criteria, please try again..."
                    
                    return tableViewErrorMessageCell
                    
                }
                
            } else if filtersApplied == true {
                
                arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController
                
                if arrayContainingDataRelatedOnlyToSectionsSerialNumbers.count == 0 {
                    
                    tableViewErrorMessageCell.messageLabel.text = "No results matched applied filters, try again."
                    
                    return tableViewErrorMessageCell
                    
                }
                
            }
            
            // The below lines of code are needed in order to fill the tableView cells with needed data:
            
            // The below checks whether ther user has selected Universal Beams, Universal Columns, Universal Bearing Piles or Parallel Flange Channels from the OpenRolledSteelSectionsCollectionViewController, and if so then the customTableViewCellForIandPFCandTsteelSections will be used to display relevant data:
            
            if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 0 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 1 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 2 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 3 {
                
                cutomTableViewCellForIandPFCSteelSections.sectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.fullSectionDesignation })[indexPath.row])"
                
                cutomTableViewCellForIandPFCSteelSections.depthOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.depthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                cutomTableViewCellForIandPFCSteelSections.widthOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.widthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                cutomTableViewCellForIandPFCSteelSections.flangeThicknessLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.flangeThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Flange Thickness", cellSubLabelText: "Flange Thickness, tf [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionFlangeThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 18, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 19, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                cutomTableViewCellForIandPFCSteelSections.webThicknessLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.webThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Web Thickness", cellSubLabelText: "Web Thickness, tw [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionWebThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 16, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                cutomTableViewCellForIandPFCSteelSections.massPerMetreLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.massPerMetreLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                cutomTableViewCellForIandPFCSteelSections.areaOfSectionLabel.attributedText = cutomTableViewCellForIandPFCSteelSections.areaOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return cutomTableViewCellForIandPFCSteelSections
                
            } // The below checks whether ther user has selected Equal Leg Angles or Unequal Leg Angles from the OpenRolledSteelSectionsCollectionViewController, and if so then the customTableViewCellForLshapedSections will be used to display relevant data:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 4 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 5 {
                
                // The below is needed in order to display information related to the Section Designation:
                
                customTableViewCellForLshapedSections.steelAngleSectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.fullSectionDesignation })[indexPath.row])"
                
                // The below is needed in order to display information related to the Total Depth of the Section:
                
                customTableViewCellForLshapedSections.steelAngleDepthLabel.attributedText = customTableViewCellForLshapedSections.steelAngleDepthLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Width of the Section:
                
                customTableViewCellForLshapedSections.steelAngleWidthLabel.attributedText = customTableViewCellForLshapedSections.steelAngleWidthLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Thickness of the Section:
                
                customTableViewCellForLshapedSections.steelAngleThicknessLabel.attributedText = customTableViewCellForLshapedSections.steelAngleThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Leg Thickness", cellSubLabelText: "Leg Thickness, t [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionLegThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Mass per Metre of the Section:
                
                customTableViewCellForLshapedSections.steelAngleMassPerMetre.attributedText = customTableViewCellForLshapedSections.steelAngleMassPerMetre.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Area of the Section:
                
                customTableViewCellForLshapedSections.steelAngleSectionArea.attributedText = customTableViewCellForLshapedSections.steelAngleSectionArea.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return customTableViewCellForLshapedSections
                
            }
                
                // The below code will use the customTableViewCell for Tee Steel Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 || userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 7 {
                
                // The below is needed in order to display information related to the Section Designation:
                
                customTableViewCellForTeeShapedSteelSections.actualSectionDesignationLabel.text = "Section Designation: \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.fullSectionDesignation })[indexPath.row])"
                
                if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 {
                    
                    customTableViewCellForTeeShapedSteelSections.crossSectionTeeSectionCutFromLabel.text = "Section Cut from: UB \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionCutFromUniversalBeam })[indexPath.row])"
                    
                } else {
                    
                    customTableViewCellForTeeShapedSteelSections.crossSectionTeeSectionCutFromLabel.text = "Section Cut from: UC \(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionCutFromUniversalColumn })[indexPath.row])"
                    
                }
                
                // The below is needed in order to display information related to the Total Depth of the Section:
                
                customTableViewCellForTeeShapedSteelSections.depthOfSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.depthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Depth", cellSubLabelText: "Depth, h [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionTotalDepth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Width of the Section:
                
                customTableViewCellForTeeShapedSteelSections.widthOfSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.widthOfSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Width", cellSubLabelText: "Width, b [mm] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionWidth })[indexPath.row]), containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 7, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Flange Thickness of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionFlangeSectionLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionFlangeSectionLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Flange Thickness", cellSubLabelText: "Flange Thickness, tf [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionFlangeThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 18, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 19, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Web Thickness of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionWebThicknessLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionWebThicknessLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Web Thickness", cellSubLabelText: "Web Thickness, tw [mm] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionWebThickness })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 15, abbreviationLettersLength: 2, containsSubscriptLetters: true, subScriptLettersStartingLocation: 16, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Mass per Metre of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionMassPerMetreLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionMassPerMetreLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Mass", cellSubLabelText: "Mass per Metre [kg/m] = " + String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionMassPerMetre })[indexPath.row]), containsAbbreviationLetters: false, abbreviationLettersStartingLocation: 0, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 1, containsSuperScriptLetters: false, superScriptLettersStartingLocation: 0, superScriptLettersLength: 1)
                
                // The below is needed in order to display information related to the Area of the Section:
                
                customTableViewCellForTeeShapedSteelSections.sectionAreaLabel.attributedText = customTableViewCellForTeeShapedSteelSections.sectionAreaLabel.returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: self.sortBy, cellTitleRelatedTo: "Area", cellSubLabelText: "Area of Section, A [cm2] = \(String(arrayContainingSteelSectionsDataToBeDisplayedInsideTheTableView.map({ $0.sectionArea })[indexPath.row]))", containsAbbreviationLetters: true, abbreviationLettersStartingLocation: 17, abbreviationLettersLength: 1, containsSubscriptLetters: false, subScriptLettersStartingLocation: 0, subScriptLettersLength: 0, containsSuperScriptLetters: true, superScriptLettersStartingLocation: 22, superScriptLettersLength: 1)
                
                return customTableViewCellForTeeShapedSteelSections
                
            }
            
        }
        
        return cutomTableViewCellForIandPFCSteelSections
        
    }
    
}

// MARK: - UITableViewDelegate Extension:

extension SteelSectionsTableViewController: UITableViewDelegate {
    
    // The below method is needed in order to decide what should happen when the user taps on a specific disclosure tableView cell icon:
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        var steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom = [SteelSectionParameters]()
        
        var sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom = [String]()
        
        // In order to de-initialize/de-allocate the viewController (i.e. SelectedSteelSectionSummaryPage) that gets displayed depending on which tableView cell disclosure icon the user tapped, once it gets dismissed. So that a new one gets initialised when the user taps on a different tableView cell disclosure icon, and therefore, its navigationBar title as well as relevant information about the selected section get displayed. The below is needed in order to avoid having a Strong Reference to the viewController that will be displayed once the user hit on a particular tableView Cell Disclosure Icon. This is achieved by making the reference to the viewController that will be displayed once the user hit on a particular tableView cell inside this method (i.e. a Local Variable) as opposed to outside this methid (Global Variable):
        
        let selectedSteelSectionSummaryPageViewControllerInstance = main.instantiateViewController(withIdentifier: "SelectedSteelSectionSummaryPage") as! SelectedSteelSectionSummaryPage
        
        selectedSteelSectionSummaryPageViewControllerInstance.delegate = self
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedCollectionViewCellFromOpenRolledSteelSectionsColelctionViewController = self.userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController
        
        // Below we are sending the sortBy, isSearching and filtersApplied Variables from this viewController to the next one:
        
        selectedSteelSectionSummaryPageViewControllerInstance.sortBy = self.sortBy
        
        selectedSteelSectionSummaryPageViewControllerInstance.isSearching = self.isSearching
        
        selectedSteelSectionSummaryPageViewControllerInstance.filtersApplied = self.filtersApplied
        
        selectedSteelSectionSummaryPageViewControllerInstance.receivedSelectedTableViewCellSectionNumberFromSteelSectionsTableViewController = indexPath.section
        
        selectedSteelSectionSummaryPageViewControllerInstance.receivedSelectedTableViewCellRowNumberFromSteelSectionsTableViewController = indexPath.row
        
        if sortBy == "None" && isSearching == false && filtersApplied == false {
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser
            
            steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsSerialNumbersOnly = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder
            
            sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrder
            
        } else if (sortBy == "Sorted by: Section designation in ascending order" || sortBy == "Sorted by: Depth of section in ascending order" || sortBy == "Sorted by: Width of section in ascending order" || sortBy == "Sorted by: Area of section in ascending order" || sortBy == "Sorted by: Section designation in descending order" || sortBy == "Sorted by: Depth of section in descending order" || sortBy == "Sorted by: Width of section in descending order" || sortBy == "Sorted by: Area of section in descending order") && isSearching == false && filtersApplied == false {
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController
            
            steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsSerialNumbersOnly = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder
            
            sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom = steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder
            
        } else if sortBy == "None" && isSearching == false && filtersApplied == true {
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController
            
            steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom = steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsDataFilterOptionsViewController
            
        } else if sortBy == "None" && isSearching == true && filtersApplied == false {
            
            selectedSteelSectionSummaryPageViewControllerInstance.receivedArrayFromSteelSectionsTableViewControllerContainingSteelSectionsData = steelSectionsDataArrayAsPerSearchedCriteria
            
            steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom = steelSectionsDataArrayAsPerSearchedCriteria
            
        }
        
        switch userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController {
            
            // The below case is when the user selected Universal Beams collectionView cell from the previous viewController:
            
        case 0:
            
            selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController = "UB \(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.fullSectionDesignation })[indexPath.row])"
            
            // The below case is when the user selected Universal Columns collectionView cell from the previous viewController:
            
            
        case 1:
            
            selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController = "UC \(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.fullSectionDesignation })[indexPath.row])"
            
            // The below case is when the user selected Universal Bearing Piles collectionView cell from the previous viewController:
            
            
        case 2:
            
            selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController = "UBP \(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.fullSectionDesignation })[indexPath.row])"
            
        default:
            
            selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionFullSectionDesignationReceivedFromPreviousViewController = "UB \(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.fullSectionDesignation })[indexPath.row])"
            
        }
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionDepthReceivedFromPreviousViewController = CGFloat(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionTotalDepth })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionWidthReceivedFromPreviousViewController = CGFloat(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionWidth })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionWebThicknessReceivedFromPreviousViewController = CGFloat(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionFlangeThicknessReceivedFromPreviousViewController = CGFloat(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionRootRadiusReceivedFromPreviousViewController = CGFloat(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionRootRadiusOne })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionDepthBetweenFilletsReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionDepthBetweenFillets })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionAreaReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionArea })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionMassPerMetreReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionEndClearanceDetailingDimensionReceivedFromPreviousViewController = Int(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionEndClearanceDimensionForDetailing })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionNotchNdetailingDimensionReceivedFromPreviousViewController = Int(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionNotchNdimensionForDetailing })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionNotchnDetailingDimensionReceivedFromPreviousViewController = Int(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionNotchnDimensionForDetailing })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionSecondMomentOfAreaAboutMajorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMajorSecondMomentOfAreaAboutYYaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionSecondMomentOfAreaAboutMinorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMinorSecondMomentOfAreaAboutZZaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionRadiusOfGyrationAboutMajorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMajorRadiusOfGyrationAboutYYaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionRadiusOfGyrationAboutMinorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMinorRadiusOfGyrationAboutZZaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionElasticModulusAboutMajorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMajorElasticModulusAboutYYaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionElasticModulusAboutMinorAxisReceivedFromPreviousViewController = Double(steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMinorElasticModulusAboutZZaxis })[indexPath.row])
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionPlasticModulusAboutMajorAxisReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMajorPlasticModulusAboutYYaxis })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionPlasticModulusAboutMinorAxisReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionMinorPlasticModulusAboutZZaxis })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionBucklingParameterReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionBucklingParameterU })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionTorsionalIndexReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionTorsionalIndexX })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionWarpingConstantReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionWarpingConstantIwInDm6 })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionTorsionalConstantReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionTorsionalConstantIt })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionSurfaceAreaPerMetreReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionSurfaceAreaPerMetre })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionSurfaceAreaPerTonneReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionSurfaceAreaPerTonne })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionRatioForWebLocalBucklingReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionLocalWebBucklingRatio })[indexPath.row]
        
        selectedSteelSectionSummaryPageViewControllerInstance.userSelectedSteelSectionRatioForFlangeLocalBucklingReceivedFromPreviousViewController = steelSectionsDataArrayToBeUsedToExtractRelevantSelectedSteelSectionFrom.filter({ $0.sectionSerialNumber == "\(sectionsSerialNumbersArrayToBeUsedToExtractRelevantSelectedSectionSerialNumberFrom[indexPath.section])" }).map({ $0.sectionLocalFlangeBucklingRatio })[indexPath.row]
        
        self.present(selectedSteelSectionSummaryPageViewControllerInstance, animated: true, completion: nil)
        
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

// MARK: - Extension for UISearchBar:

// The below extension is needed in order to make the process of changing UISearchBar parameters much more easier and accessible:

extension SteelSectionsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let newText: NSMutableString = NSMutableString(string: searchText)
        
        // If the below case is true then the user selected Universal Beams from the previous viewController:
        
        // MARK: - Search Criteria and Auto-Fill for Universal Beams Sections:
        
        if searchText.isEmpty == false {
            
            if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 0 {
                
                // "101" is excluded from the below line of code, since if the first three entered digits by the user are 101 then there is the possibility that the section the user is looking for is UB 1016 x 305 x ...:
                
                if searchText.count == 3 && searchText != "101" {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 4 && searchText == "1016" {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 8 && ( searchText.contains("127") == true || searchText.contains("152") == true ) {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 && searchText.contains("1016") == false && ( searchText.contains("127") == false || searchText.contains("152") == false ) {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 10 && searchText.contains("1016") == true {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 && searchText.contains("1016") == false && searchText.contains("127") == false && searchText.contains("152") == false {
                    
                    newText.deleteCharacters(in: NSRange(location: 8, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 5 && searchText.contains("1016") == false {
                    
                    newText.deleteCharacters(in: NSRange(location: 2, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 6 && searchText.contains("1016") == true {
                    
                    newText.deleteCharacters(in: NSRange(location: 2, length: 4))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 10 && (searchText.contains("127") == true || searchText.contains("152") == true) {
                    
                    newText.deleteCharacters(in: NSRange(location: 7, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 12 && searchText.contains("1016") == true {
                    
                    newText.deleteCharacters(in: NSRange(location: 9, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
                
                // The below code gets executed if the user has selected Universal Columns from the previous viewController (i.e. OpenRolledSteelSectionsCollectionViewController.swift):
                
                // MARK: - Search Criteria and Auto-Fill for Universal Columns Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 1 {
                
                // The below code gets executed when the user starts typing something inside the searchBar:
                
                // Whenever the user has typed three number, automatically " x " will be added in the search bar:
                
                if searchText.isEmpty == false {
                    
                    if searchText.count == 3 {
                        
                        newText.append(" x ")
                        
                        searchBar.text = String(newText)
                        
                    }
                        
                        // The below code will make sure to add " x " automatically if the number of characters inside the searchBar is equal to 9, for example 127 x 527, then automaticall the field will become 127 x 527 x :
                        
                    else if searchText.count == 9 {
                        
                        newText.append(" x ")
                        
                        searchBar.text = String(newText)
                        
                    }
                        
                        // The below code deletes automatically for the user whenever the number of characters inside the searcBar is equal to 10, 2 characters after the eights character will be deeleted automatically:
                        
                    else if searchText.count == 10 {
                        
                        newText.deleteCharacters(in: NSRange(location: 8, length: 2))
                        
                        searchBar.text = String(newText)
                        
                    }
                        
                        // The below code deletes automatically for the user whenever the number of characters inside the searcBar is equal to 4, 2 characters after the second character will be deeleted automatically:
                        
                    else if searchText.count == 4 {
                        
                        newText.deleteCharacters(in: NSRange(location: 2, length: 2))
                        
                        searchBar.text = String(newText)
                        
                    }
                    
                }
                
            }
                
                // MARK: - Search Criteria and Auto-Fill for Universal Bearing Piles Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 2 {
                
                if searchText.isEmpty == false {
                    
                    if searchText.count == 3 {
                        
                        newText.append(" x ")
                        
                        searchBar.text = String(newText)
                        
                    } else if searchText.count == 9 {
                        
                        newText.append(" x ")
                        
                        searchBar.text = String(newText)
                        
                    } else if searchText.count == 10 {
                        
                        newText.deleteCharacters(in: NSRange(location: 8, length: 2))
                        
                        searchBar.text = String(newText)
                        
                    } else if searchText.count == 4 {
                        
                        newText.deleteCharacters(in: NSRange(location: 2, length: 2))
                        
                        searchBar.text = String(newText)
                        
                    }
                    
                }
                
            }
                // MARK: - Search Criteria and Auto-Fill for Parallel Flange Channels Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 3 {
                
                if searchText.count == 3 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 8 && (searchText != "430 x 10" && searchText != "380 x 10" && searchText != "300 x 10") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                }
                    
                else if searchText.count == 10 {
                    
                    newText.deleteCharacters(in: NSRange(location: 7, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                    
                else if searchText.count == 5 {
                    
                    newText.deleteCharacters(in: NSRange(location: 2, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 && (searchText.contains("430 x 100 x") || searchText.contains("380 x 100 x") || searchText.contains("300 x 100 x")) {
                    
                    newText.deleteCharacters(in: NSRange(location: 8, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
                
                // MARK: - Search Criteria and Auto-Fill for Equal Leg Angles Sections:
                
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 4 {
                
                if searchText.count == 3 && (searchText == "200" || searchText == "150" || searchText == "120" || searchText == "100") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 2 && (searchText != "15" && searchText != "12" && searchText != "10"){
                    
                    // The reason "20" is chosen is because from the available Equal Angle Section stated in the BlueBook, the used could be looking for 20 x ... or 200 x ... series as both do exist in the BlueBook catalogue manual:
                    
                    if searchText.description == "20" {
                        
                        searchBarDropListOptionsPopoverViewController.firstTwoCharactersUserTypedInsideOfSteelSectionsTableViewVCSearchBarTextField = searchText.description
                        
                        searchBarDropListOptionsPopoverViewController.userSelectedCollectionViewCellFromOpenRolledSteelSectionsCollectionViewController = self.userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController
                        
                        displaySearchBarPopoverVC()
                        
                    } else {
                        
                        newText.append(" x ")
                        
                        searchBar.text = String(newText)
                        
                    }
                    
                } else if searchText.count == 9 && (searchText == "200 x 200" || searchText == "150 x 150" || searchText == "120 x 120" || searchText == "100 x 100") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 7 && (searchText != "200 x 2" && searchText != "150 x 1" && searchText != "120 x 1" && searchText != "100 x 1") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 && (searchText == "200 x 200 x" || searchText == "150 x 150 x" || searchText == "120 x 120 x" || searchText == "100 x 100 x"){
                    
                    newText.deleteCharacters(in: NSRange(location: 8, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 {
                    
                    newText.deleteCharacters(in: NSRange(location: 6, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 4 {
                    
                    newText.deleteCharacters(in: NSRange(location: 1, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
            
                // MARK: - Search Criteria and Auto-Fill for Un-equal Leg Angles Sections:
            
            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 5 {
                
                if searchText.count == 3 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 2 && (searchText != "20" && searchText != "15" && searchText != "12" && searchText != "10") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 && (searchText == "200 x 150" || searchText == "200 x 100"){
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 8 && (searchText != "200 x 15" && searchText != "200 x 10") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 7 && (searchText == "80 x 60" || searchText == "80 x 40" || searchText == "75 x 50" || searchText == "70 x 50" || searchText == "65 x 50" || searchText == "60 x 40" || searchText == "60 x 30" || searchText == "50 x 30" || searchText == "45 x 30" || searchText == "40 x 25" || searchText == "40 x 20" || searchText == "30 x 20") {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 && (searchText == "200 x 150 x" || searchText == "200 x 100 x"){
                    
                    newText.deleteCharacters(in: NSRange(location: 7, length: 4))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 10 && (searchText != "200 x 150 " && searchText != "200 x 100 " && searchText != "80 x 60 x " && searchText != "80 x 40 x " && searchText != "75 x 50 x " && searchText != "70 x 50 x " && searchText != "65 x 50 x " && searchText != "60 x 40 x " && searchText != "60 x 30 x " && searchText != "50 x 30 x " && searchText != "45 x 30 x " && searchText != "40 x 25 x " && searchText != "40 x 20 x " && searchText != "30 x 20 x ") {
                    
                    newText.deleteCharacters(in: NSRange(location: 7, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 {
                     
                    newText.deleteCharacters(in: NSRange(location: 6, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 5 && (searchText == "200 x" || searchText == "150 x") || searchText == "125 x" || searchText == "100 x" {
                    
                    newText.deleteCharacters(in: NSRange(location: 1, length: 4))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 4 {
                    
                    newText.deleteCharacters(in: NSRange(location: 1, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
            
                // MARK: - Search Criteria and Auto-Fill for Tees (T) split from UB Sections:

            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 6 {
                
                if searchText.count == 3 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 {
                    
                    newText.deleteCharacters(in: NSRange(location: 8, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 5 {
                    
                    newText.deleteCharacters(in: NSRange(location: 2, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
                
                // MARK: - Search Criteria and Auto-Fill for Tees (T) split from UC Sections:

            else if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 7 {
                
                if searchText.count == 3 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 9 {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 8 && searchText == "152 x 76" {
                    
                    newText.append(" x ")
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 11 {
                    
                    newText.deleteCharacters(in: NSRange(location: 8, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 10 && searchText == "152 x 76 x" {
                    
                    newText.deleteCharacters(in: NSRange(location: 7, length: 3))
                    
                    searchBar.text = String(newText)
                    
                } else if searchText.count == 5 {
                    
                    newText.deleteCharacters(in: NSRange(location: 2, length: 3))
                    
                    searchBar.text = String(newText)
                    
                }
                
            }
            
            steelSectionsDataArrayAsPerSearchedCriteria = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser.filter({ $0.fullSectionDesignation.lowercased().prefix(searchText.count) == searchText.lowercased() })
            
            isSearching = true
            
            sortBy = "None"
            
            filtersApplied = false
            
            self.steelSectionsTableView.reloadData()
            
        }
            
            // The below code will be triggered whenever the searchBar field is empty, for example this could be the case whenever the user hit the "x" button to the far right end of the searchBar:
            
        else {
            
            isSearching = false
            
            sortBy = "None"
            
            filtersApplied = false
            
            self.steelSectionsTableView.reloadData()
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        
        // The below allow the user to input only numbers in the Search Bar:
        
        if searchBar.keyboardType == .numberPad {
            
            // The below does not allow the user to input number 0 as a first character inside the searchBar:
            
            if searchBar.text?.count == 0 && text == "0" {
                
                return false
                
            }
                
                // Check for invalid input characters:
                
            else if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: text)) {
                
                return totalCharacters <= 16 && true
                
            } else {
                
                return false
                
            }
            
        }
        
        return true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        
        // The below line of code is needed in order to make the on-screen keyboard disappears when the search field is empty:
        
        self.searchBar.endEditing(true)
        
    }
    
    // MARK: - Filter Data button pressed:
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        // Below we are passing sortBy, isSearching and filtersApplied variables onto TableViewSteelSectionsDataFilterOptions:
        
        tableViewSteelSectionsDataFilterOptionsViewController.sortBy = self.sortBy
        
        tableViewSteelSectionsDataFilterOptionsViewController.isSearching = self.isSearching
        
        tableViewSteelSectionsDataFilterOptionsViewController.filtersApplied = self.filtersApplied
        
        tableViewSteelSectionsDataFilterOptionsViewController.delegate = self
        
        tableViewSteelSectionsDataFilterOptionsViewController.receivedSteelSectionsDataArrayFromSteelSectionsTableViewController = extractedSteelSectionsDataArrayFromThePassedCsvFileUsingTheParser
        
        self.present(tableViewSteelSectionsDataFilterOptionsViewController, animated: true, completion: nil)
        
    }
    
}

// MARK: - Protocol extension in order to receive data from SortDataPopOverVC or FilterDataVC:

extension SteelSectionsTableViewController: PassingDataBackwardsBetweenViewControllersProtocol {
    
    func dataToBePassedUsingProtocol(userLastSelectedCollectionViewCellNumber: Int, configuredArrayContainingSteelSectionsData: [SteelSectionParameters], configuredArrayContainingSteelSectionsSerialNumbersOnly: [String], configuredSortByVariable: String, configuredFiltersAppliedVariable: Bool, configuredIsSearchingVariable: Bool, exchangedUserSelectedTableCellSectionNumber: Int, exchangedUserSelectedTableCellRowNumber: Int) {
        
        self.userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController = userLastSelectedCollectionViewCellNumber
        
        self.steelSectionsDataArrayAsReceivedFromTableViewSteelSectionsSortByOptionsPopoverViewController = configuredArrayContainingSteelSectionsData
        
        self.steelSectionsDataArrayContainingOnlyInfoAboutSectionsSerialNumberSortedInAscendingOrDescendingOrder = configuredArrayContainingSteelSectionsSerialNumbersOnly
                
        self.sortBy = configuredSortByVariable
        
        self.filtersApplied = configuredFiltersAppliedVariable
        
        self.isSearching = configuredIsSearchingVariable
        
        // The below line of code will be triggered once the user tap on the Apply button inside the sortDataPopoverVC (i.e. as soon as the passingDataBackwardsProtocol gets triggered). The below line of code will also be executed whenever the PassingDataBackwardsBetweenViewControllersProtocol gets triggered, whether that is from the sortByDataVC, filtersVC and/or hitting the backwards button on the NavigationBar:
        
        self.view.alpha = 1
        
        self.steelSectionsTableView.reloadData()
        
        // The below code is needed in order to scroll back to a specific section and row inside a tableView once it has been reloaded, in this case we are scrolling back to the very top of the table (i.e. section: 0, row: 0):
        
        self.steelSectionsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                
    }
    
}

// MARK: -Protocol to pass data backwards from SearchBarOptionsDropListPopoverVC to this VC:

extension SteelSectionsTableViewController: PassingDataBackwardsFromSearchBarOptionsDropListPopoverVCToSteelSectionsTableVC {
    
    func dataToBePassedBackwards(userSelectedTableViewCellContent: String) {
        
        self.searchBarAutoCompleteBasedOnUserSelectionFromSearchBarOptionsDropListPopoverVC = userSelectedTableViewCellContent
        
        searchBar.text = searchBarAutoCompleteBasedOnUserSelectionFromSearchBarOptionsDropListPopoverVC
        
        // The below line of code is needed in order to set this viewController back to its full brightness (instead of 0.5) as soon as the searchBarOptionsDropListVC has been dismissed:
        
        self.view.alpha = 1
        
        self.searcgBarDropListOptionsPopoverViewControllerIsCurrentlyPresentedOnScreen = false
        
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate Extension:

extension SteelSectionsTableViewController: UIPopoverPresentationControllerDelegate {
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        
        // The below line of code will set the brightness of this VC to 50% whenever the popover view either the one related to sortData or searchBarOptionsDropList is about to get displayed on screen:
        
        self.view.alpha = 0.50
        
    }
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
        
    }
    
    // The below function gets called whenever the SortDataPopOverVC or searchBarOptionsDropListVC gets dismissed:
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        // The below line of code will set the brightness of this viewController back to 100% as soon as the sortByPopoverViewController has been dismissed, whenever the user tap anywhere on the screen outside the sortByPopoverVC area. Note that the below line of code will only work for the sortByPopoverViewController and not for the searchBarDropListVC, when the user tap anywhere outside the sortByPopoverVC area. Since this viewController is in charge of dismissing the sortByPopoverViewController, thus, triggers this method. However, since the searchBarDropListOptionsVC will only be dimissed once the user make a selection from the displayed popOverVC (as whenever the user taps anywhere outside the searchBarDropListOptionsVC area, an Alert will be displayed forcing the user to make a selection from the available options before having the popOverVC dismissed), thus, the searchBarDropListOptionsVC is in charge of dismissing itself, thus, will not trigger this function:
        
        self.view.alpha = 1
        
    }
    
    // The below method get called whenever the user try to tap anywhere on the screen outside the popover view boundaries:
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        
        if userLastSelectedCollectionViewCellBeforeNavigatingToThisViewController == 4 {
            
            if searcgBarDropListOptionsPopoverViewControllerIsCurrentlyPresentedOnScreen == true {
                
                    // Note that in order to be able to display the alert relevant to equal angle sections tableViewController, the first step is to dismiss the already poped up searchBarPopoverVC, which appeared to the user as soon as he typed two characters inside the searchBar textField, in order to know whether for example the user intention is to search for a 10 x ... series or 100 x ... series. Once the searchBarPopoverVC has been dismissed, then the AlertVC can be displayed whenever the user tap amywhere on the screen outside of the UIAlert dialogue box.
                    
                    self.searchBarDropListOptionsPopoverViewController.dismiss(animated: true, completion: {
                        
                        let alert = UIAlertController(title: "Alert", message: "Please select from available options to proceed!", preferredStyle: UIAlertController.Style.alert)
                        
                        // The below title represents the title of the button that will be displayed inside the UIAlert, which the user needs to click on in order to dismiss the alert. The below handler contains the previously defined UIAlertAction, which is required in order to display again the searchBar Popover VC when the user click on the "Ok" button displayed inside the UIAlert. Basically the alert will be dismissed and the searchBarPopoverVC will be displayed again:
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: self.searchBarPopoverVCHandlerMethod(action:)))
                        
                        // The below line of code is needed in order to display the UIAlert:
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    })
                    
                    // The below will prevent the popover VC from disappearing whenever the user tap anywhere on the screen outside the popover VC itself:

                    
                    return false

            } else {
                
                return true
                
            }
            
        } else {
                
                return true
                
            }
    
    }
    
}

// MARK: - UISearchBar Extension to allow for quick changes to be made for placeholder text, text typed by the user inside the UISearchBar textfield and search manifying glass icon colourv:

extension UISearchBar {
    
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }
    
    func setTextField(color: UIColor) {
        
        guard let textField = getTextField() else { return }
        
        switch searchBarStyle {
            
        case .minimal:
            
            textField.layer.backgroundColor = color.cgColor
            
            textField.layer.cornerRadius = 6
            
        case .prominent, .default: textField.backgroundColor = color
            
        @unknown default: break
            
        }
        
    }
    
    func setSearchImage(color: UIColor) {
        
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        
        imageView.tintColor = color
        
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
    }
    
}

private extension UITextField {
    
    private class Label: UILabel {
        
        private var _textColor = UIColor.lightGray
        
        override var textColor: UIColor! {
            
            set { super.textColor = _textColor }
            
            get { return _textColor }
            
        }
        
        init(label: UILabel, textColor: UIColor = .lightGray) {
            
            _textColor = textColor
            
            super.init(frame: label.frame)
            
            self.text = label.text
            
            self.font = label.font
            
        }
        
        required init?(coder: NSCoder) { super.init(coder: coder) }
        
    }
    
    private class ClearButtonImage {
        
        static private var _image: UIImage?
        
        static private var semaphore = DispatchSemaphore(value: 1)
        
        static func getImage(closure: @escaping (UIImage?)->()) {
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                semaphore.wait()
                
                DispatchQueue.main.async {
                    
                    if let image = _image { closure(image); semaphore.signal(); return }
                    
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    
                    searchBar.text = "txt"
                    
                    searchBar.layoutIfNeeded()
                    
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    
                    closure(_image)
                    
                    searchBar.removeFromSuperview()
                    
                    semaphore.signal()
                    
                }
                
            }
            
        }
        
    }
    
    func setClearButton(color: UIColor) {
        
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
    }
    
    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }
    
    func setPlaceholder(textColor: UIColor) {
        
        guard let placeholderLabel = placeholderLabel else { return }
        
        let label = Label(label: placeholderLabel, textColor: textColor)
        
        setValue(label, forKey: "placeholderLabel")
        
    }
    
    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
    
}

private extension UILabel {
    
    func returnedSubTableViewCellLabelNSAttributedString(dataSortedBy: String, cellTitleRelatedTo: String, cellSubLabelText: String, containsAbbreviationLetters: Bool, abbreviationLettersStartingLocation: Int, abbreviationLettersLength: Int, containsSubscriptLetters: Bool, subScriptLettersStartingLocation: Int, subScriptLettersLength: Int, containsSuperScriptLetters: Bool, superScriptLettersStartingLocation: Int, superScriptLettersLength: Int) -> NSAttributedString {
        
        let tableViewCellSubLabelText: String = cellSubLabelText
        
        let checkIfSortByCriteriaForUserToChooseFromExistInSortByCriteriaChosenByUser = dataSortedBy.contains(cellTitleRelatedTo)
        
        let cellSubLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: tableViewCellSubLabelText)
        
        let cellSubLabelGeneralAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 15)!,
            
            .foregroundColor: UIColor(named: "Table View Cell Sub-Label Text Colour")!,
            
        ]
        
        let cellSubLabelAbbrivationLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!,
            
            .foregroundColor: UIColor(named: "Table View Cell Sub-Label Abbreviation Letter Text Colour")!,
            
        ]
        
        let cellSubLabelSubScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: -7,
            
        ]
        
        let cellSubLabelSuperScriptLettersAttributes: [NSAttributedString.Key: Any] = [
            
            .baselineOffset: 7,
            
            .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
            
        ]
        
        let cellTextUnderlineAttributes: [NSAttributedString.Key: Any] = [
            
            .underlineStyle: NSUnderlineStyle.single.rawValue
            
        ]
        cellSubLabelAttributedString.addAttributes(cellSubLabelGeneralAttributes, range: NSRange(location: 0, length: cellSubLabelAttributedString.length))
        
        if checkIfSortByCriteriaForUserToChooseFromExistInSortByCriteriaChosenByUser == true {
            cellSubLabelAttributedString.addAttributes(cellTextUnderlineAttributes, range: NSRange(location: 0, length: cellSubLabelAttributedString.length))
            
        }
        
        if containsAbbreviationLetters == true && containsSubscriptLetters == false && containsSuperScriptLetters == false {
            cellSubLabelAttributedString.addAttributes(cellSubLabelAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
        } else if containsAbbreviationLetters == true && containsSubscriptLetters == true && containsSuperScriptLetters == false {
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelSubScriptLettersAttributes, range: NSRange(location: subScriptLettersStartingLocation, length: subScriptLettersLength))
            
            
        } else if containsAbbreviationLetters == true && containsSuperScriptLetters == true && containsSubscriptLetters == false {
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelSuperScriptLettersAttributes, range: NSRange(location: superScriptLettersStartingLocation, length: superScriptLettersLength))
            
        } else if containsAbbreviationLetters == true && containsSubscriptLetters == true && containsSuperScriptLetters == true {
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelAbbrivationLettersAttributes, range: NSRange(location: abbreviationLettersStartingLocation, length: abbreviationLettersLength))
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelSubScriptLettersAttributes, range: NSRange(location: subScriptLettersStartingLocation, length: subScriptLettersLength))
            
            cellSubLabelAttributedString.addAttributes(cellSubLabelSuperScriptLettersAttributes, range: NSRange(location: superScriptLettersStartingLocation, length: superScriptLettersLength))
            
        }
            
        else {
            
            return cellSubLabelAttributedString
            
        }
        
        return cellSubLabelAttributedString
        
    }
    
}
