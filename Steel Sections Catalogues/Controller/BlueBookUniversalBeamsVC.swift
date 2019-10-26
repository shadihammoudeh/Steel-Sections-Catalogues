//
//  BlueBookUniversalBeamsVC.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class BlueBookUniversalBeamsVC: UIViewController {
    
    // MARK: - Instance scope variables and constants declarations:
    
    // The value of the below Variable is set by default to be equal to "None" which means that the data displayed inside the table will be sorted by Section Designation in Ascending Order as soon as this ViewController loads up for the first time:
    
    // The below variables (i.e., sortBy, isSearching and filtersApplied) will be passed back and forth between this ViewController, SortDataPopOverVC and FilterDataVC in order to keep them up-to-date with the changes the user make to how the data inside the tableView is searched, sorted and/or filtered:
    
    var sortBy: String = "None"
    
    var isSearching: Bool = false
    
    var filtersApplied: Bool = false
    
    // The below Arrays will get their values from either FilterDataVC or SortDataVC in order to display the data inside the tableView accordingly:
    
    var universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol = [IsectionsDimensionsParameters]()
    
    var universalBeamsDataArrayReceivedFromSortDataVCViaProtocol = [IsectionsDimensionsParameters]()
    
    // The below Array is the one which contains the data extracted from the passed CSV file. It contains the data in a one big Array, which contains several Arrays inside it, whereby each Array inside the big Array contains several Dictionaries. The below Array is going to be filled using the CSV parser which will be used later on:
    
    var originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData = [IsectionsDimensionsParameters]()
    
    // The below array represents the array containing searchedData as per the user's search criteria out of the originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData:
    
    var universalBeamsDataArrayAsPerTypedSearchCriteria = [IsectionsDimensionsParameters]()
    
    // The below Array is mapped out from the originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData Array, whereby only sectionSerialNumbers are reported inside of it, with no duplication using the extension at the end of this Class (i.e., Array):
    
    var universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault: [String] = []
    
    var universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder: [String] = []
    
    var searchBar = UISearchBar()
    
    // The below code line declares the custom NavigationBar to be added to this ViewController. The reason it is defined as a lazy var, is to allow us to access the view properties of this ViewController. Since the custom NavigationBar is defined outside the viewDidLoad methods, or other methods where UIVIew is available. This navigationBar is going to have a left button (back button), Title in the middle (UILabel) and a rightButton (Sort Data):
    
    lazy var navigationBar = CustomUINavigationBar(rightNavBarTitle: "Sort Data", rightNavBarTitleHexColourCodeNormalState: "#333301", rightNavBarTitleHexColourCodeHighlightedState: "#FFFF05", rightNavBarButtonTarget: self, rightNavBarSelector: #selector(navigationBarRightButtonPressed(sender:)), isNavBarTranslucent: false, navBarBackgroundColourHexCode: "#CCCC04", navBarBackgroundColourAlphaValue: 1.0, navBarStyle: .black, preferLargeTitles: false, navBarDelegate: self, navBarItemsHexColourCode: "#E0E048", normalStateNavBarLeftButtonImage: "normalStateBackButton", highlightedStateNavBarLeftButtonImage: "highlightedStateBackButton", navBarLeftButtonTarget: self, navBarLeftButtonSelector: #selector(navigationBarLeftButtonPressed(sender:)), labelTitleText: "Universal Beams (UB)", titleLabelFontHexColourCode: "#FFFF52", labelTitleFontSize: 16, labelTitleFontType: "AppleSDGothicNeo-Light")
    
    let universalBeamsTableView = UITableView()
    
    // MARK: - sortDataPopOverVC & filterDataVC & BlueBookUniversalBeamDataSummaryVC instances:
    
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    lazy var sortDataPopOverVC = main.instantiateViewController(withIdentifier: "SortDataPopOverVC")
    
    lazy var filterDataVC = main.instantiateViewController(withIdentifier: "FilterDataVC") as! FilterDataVC
    
    lazy var blueBookUniversalBeamDataSummaryVC = main.instantiateViewController(withIdentifier: "BlueBookUniversalBeamDataSummaryVC")
    
    // MARK: - viewDidLoad():
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // MARK: - tapGesture declaration to dismiss keyboard:
        
        // The below code is needed in order to detect when a user has tapped on the screen, consequently dismisses the displayed on-screen keyboard:
        
        //        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        setupSearchBar()
        
        setupTableView()
        
        // MARK: - Adding subViews:
        
        //        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(searchBar)
        
        view.addSubview(navigationBar)
        
        view.addSubview(universalBeamsTableView)
        
        // MARK: - Parsing the CSV file to extract required data out of it:
        
        // We are going to call the parse function on the appropriate CSV file as soon as the application loads in order to extract the needed data to populate the tableView:
        
        parseCsvFile(csvFileToParse: "BlueBookUniversalBeams")
        
        // The below code sorts the Data reported from the relevant CSV file using the Parser in Ascending Order by Section Designation by default, every time the view loads-up for the first time. sort Method below does not create a new Array, it modifieds the existing one:
        
        sortExtractedUniversalBeamsArrayInAscendingOrderByDefault()
        
        // MARK: - Extracting all Universal Beams Section Serial Numbers from originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData Array and plugging them into universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault:
        
        // The below line of code extracts only the sectionSerialNumber Dictionary from the originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData as well as remove any duplicates from it. The below will be used later on to decide how many sections we need to have inside our table, when the data gets sorted by Section Designation:
        
        universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData.map({ return $0.sectionSerialNumber }).removingDuplicates()
        
    }
    
    // MARK: - viewWillAppear():
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - viewWillLayoutSubViews():
    
    override func viewWillLayoutSubviews() {
        
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
        
    }
    
    // MARK: - viewWillDisappear():
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - viewDidDisappear():
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    // MARK: - dismissKeyboard Method used by tapGesture:
    
    @objc func dismissKeyboard() {
        
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
        
    }
    
    // MARK: - function that is needed to sort default universalBeams Array in Ascending Order:
    
    func sortExtractedUniversalBeamsArrayInAscendingOrderByDefault() {
        
        originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData.sort {
            
            if $0.firstSectionSeriesNumber != $1.firstSectionSeriesNumber {
                
                return $0.firstSectionSeriesNumber < $1.firstSectionSeriesNumber
                
            } else if $0.sectionSerialNumber != $1.sectionSerialNumber {
                
                return $0.sectionSerialNumber < $1.sectionSerialNumber
                
            } else {
                
                return $0.lastSectionSeriesNumber < $1.lastSectionSeriesNumber
                
            }
            
        }
        
    }
    
    // MARK: - Setup tableView:
    
    func setupTableView() {
        
        universalBeamsTableView.dataSource = self
        
        universalBeamsTableView.delegate = self
        
        universalBeamsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        universalBeamsTableView.backgroundColor = UIColor(named: "tableViewBackgroundAndCellColour")
        
        universalBeamsTableView.separatorColor = UIColor.brown
        
        // It is very important to note that the below code, which calculates the dynamic height of a TableView Cell only works when all the required constrains (i.e., Top, Right, Bottom and Left) for all subViews to be displayed inside the tableView Cell are defined:
        
        universalBeamsTableView.estimatedRowHeight = 120
        
        universalBeamsTableView.rowHeight = UITableView.automaticDimension
        
        universalBeamsTableView.register(CustomIsectionTableViewCells.self, forCellReuseIdentifier: "IsectionProfileCustomCell")
        
    }
    
    // MARK: - Setup SearchBar:
    
    func setupSearchBar() {
        
        searchBar.delegate = self
        
        searchBar.showsBookmarkButton = true
        
        searchBar.setImage(UIImage(named: "filterButtonIcon"), for: .bookmark, state: .normal)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.tintColor = UIColor.blue
        
        searchBar.sizeToFit()
        
        // The below line of code changes the colour of the text displayed inside the search bar:
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        searchBar.placeholder = "Search by Section Designation..."
        
        searchBar.barStyle = UIBarStyle.default
        
        // The below line of code sets the frame's background colour of the UISearchBar:
        
        searchBar.barTintColor = UIColor.black
        
        searchBar.isTranslucent = false
        
        searchBar.keyboardType = .numberPad
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        
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
            
            universalBeamsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            
            universalBeamsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            universalBeamsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            universalBeamsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
        ])
        
    }
    
    // MARK: CSV Parser Method:
    
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
            
            // Now we want to pull out the data that we are interested in out of the parsed csv file generated in the above line of code. As the above code line will spit out the data in an Arrays of Dictionaries format, whereby each line is going to be an Array, which contains multiple dictionaries inside of it, and each Dictionary is going to have a title as its Key and a value as its Value. We need to loop through each row and pull out the data we want. Then each extraced row (Array of Dictionaries) is going to be appended to the big Array (i.e., originalUniversalBeamsArrayDataExtractedFromTheCsvFileUsingTheParserWithAllData) which is going to contain all other Arrays:
            
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
                originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData.append(individualUniversalBeamArrayOfDictionaries)
                
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
}

// MARK: - UINavigationBarDelegate Extension:

extension BlueBookUniversalBeamsVC: UINavigationBarDelegate {
    
    // MARK: Navigation Bar Left button pressed (back button):
    
    @objc func navigationBarLeftButtonPressed(sender : UIButton) {
        
        let previousViewControllerToGoTo = main.instantiateViewController(withIdentifier: "BlueBookTabController")
        
        self.present(previousViewControllerToGoTo, animated: true, completion: nil)
        
    }
    
    // MARK: - Navigaton Bar Right button pressed (Sort Data button):
    
    @objc func navigationBarRightButtonPressed(sender : UIButton) {
        
        print("Right navigation bar button pressed")
        
        sortDataPopOverVC.modalPresentationStyle = .popover
        
        let popover = sortDataPopOverVC.popoverPresentationController!
        
        popover.delegate = self
        
        popover.permittedArrowDirections = .up
        
        // The below code is needed in order to set the size of the pop-over view controller:
        
        sortDataPopOverVC.preferredContentSize = CGSize(width: 320, height: 150)
        
        // The sourceView in the below code line represents the view containing the anchor rectangle for the popover:
        
        popover.sourceView = navigationBar.navigationBarRightButtonView
        
        // The sourceRect in the below code line represents The rectangle in the specified view in which to anchor the popover:
        
        popover.sourceRect = navigationBar.navigationBarRightButtonView.bounds
        
        let viewControllerToPassDataTo = sortDataPopOverVC as! SortDataPopOverVC
        
        viewControllerToPassDataTo.delegate = self
        
        viewControllerToPassDataTo.sortBy = self.sortBy
        
        viewControllerToPassDataTo.isSearching = self.isSearching
        
        viewControllerToPassDataTo.filtersApplied = self.filtersApplied
        
        viewControllerToPassDataTo.universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData
        
        present(viewControllerToPassDataTo, animated: true, completion:{
            
            self.view.alpha = 0.5
            
            self.dismissKeyboard()
            
        })
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        
        return UIBarPosition.topAttached
        
    }
    
}

// MARK: - UITableViewDataSource Extension:

// Below is the tableViewDataSource extension onto this viewController. The methods inside this extension will provide all needed data for the tableView:

extension BlueBookUniversalBeamsVC: UITableViewDataSource {
    
    // MARK: - numberOfSection:
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // The below lines of code check the values of the sortBy, filtersApplied and isSearching Variables in order to decide on how many section the tableView should contains. The tableView will only displays multiple sections when the data is sorted by Section Designation in an ascending or descending order, and isSearching as well as filtersApplied variables are both equal to false:
        
        if sortBy == "Sorted by: Section Designation in ascending order" || sortBy == "Sorted by: Section Designation in descending order" {
            
            return universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder.count
            
        } else if sortBy == "None" && filtersApplied == false && isSearching == false {
            
            return universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault.count
            
        } else  {
            
            return 1
            
        }
        
    }
    
    // MARK: - viewForHeaderInSection:
    
    // The below function defines the properties of section headers as well as what should be displayed inside them:
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        
        let sectionHeaderTitle = UILabel()
        
        sectionHeaderTitle.translatesAutoresizingMaskIntoConstraints = false
        
        sectionHeaderTitle.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        
        sectionHeaderView.backgroundColor = UIColor(hexString: "#BF2C0B")
        
        sectionHeaderTitle.textColor = UIColor(hexString: "#F2AB6D")
        
        sectionHeaderTitle.textAlignment = .left
        
        sectionHeaderTitle.numberOfLines = 0
        
        if sortBy == "Sorted by: Section Designation in ascending order" || sortBy == "Sorted by: Section Designation in descending order" {
            
            // In this case the title for each section header is equal to each section serial number:
            
            sectionHeaderTitle.text = universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder[section] + " Series"
            
        } else if sortBy == "None" && isSearching == false && filtersApplied == false {
            
            sectionHeaderTitle.text = universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault [section] + " Series"
            
        } else if sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Section Area in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" || sortBy == "Sorted by: Width of Section in descending order" || sortBy == "Sorted by: Section Area in descending order" {
            
            sectionHeaderTitle.text = self.sortBy
            
        } else if isSearching == true {
            
            sectionHeaderTitle.text = "Results for searched Section Designation for all UBs data:"
            
        } else if filtersApplied == true {
            
            sectionHeaderTitle.text = "Results as per applied filters from all UBs data:"
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sortBy == "Sorted by: Section Designation in ascending order" || sortBy == "Sorted by: Section Designation in descending order" {
            
            // The below line of code will convert the original Array into an Array of key-value pairs using tuples, where each value has the number 1:
            
            let convertedUniversalBeamsArrayIntoKeyValuePairsTuples = universalBeamsDataArrayReceivedFromSortDataVCViaProtocol.map { ($0.sectionSerialNumber, 1) }
            
            // The below line of code create a Dictionary from the above tuple array, asking it to add the 1s together every time it finds a duplicate key:
            
            let totalCountForEveryUniqueSectionSerialNumber = Dictionary(convertedUniversalBeamsArrayIntoKeyValuePairsTuples, uniquingKeysWith: +)
            
            return totalCountForEveryUniqueSectionSerialNumber["\(universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder[section])"]!
            
        } else if sortBy == "None" && filtersApplied == false && isSearching == false {
            
            let convertedUniversalBeamsArrayIntoKeyValuePairsTuples = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData.map { ($0.sectionSerialNumber, 1) }
            
            // The below line of code create a Dictionary from the above tuple array, asking it to add the 1s together every time it finds a duplicate key:
            
            let totalCountForEveryUniqueSectionSerialNumber = Dictionary(convertedUniversalBeamsArrayIntoKeyValuePairsTuples, uniquingKeysWith: +)
            
            return totalCountForEveryUniqueSectionSerialNumber["\(universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault[section])"]!
            
        } else if filtersApplied == true {
            
            if universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol.count > 0 {
                
                return universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol.count
                
            } else {
                
                return 1
                
            }
            
        } else if sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Section Area in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" || sortBy == "Sorted by: Width of Section in descending order" || sortBy == "Sorted by: Section Area in descending order" {
            
            return universalBeamsDataArrayReceivedFromSortDataVCViaProtocol.count
            
        } else if isSearching == true {
            
            
            if universalBeamsDataArrayAsPerTypedSearchCriteria.count > 0 {
                
                return universalBeamsDataArrayAsPerTypedSearchCriteria.count
                
            } else {
                
                return 1
                
            }
            
        } else {
            
            return 1
            
        }
        
    }
    
    // MARK: - cellForRowAtIndexPath:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (sortBy == "None" && filtersApplied == false && isSearching == false) || sortBy == "Sorted by: Section Designation in ascending order" ||  sortBy == "Sorted by: Section Designation in descending order" {
            
            let cell = Bundle.main.loadNibNamed("CustomIsectionTableViewCells", owner: self, options: nil)?.first as! CustomIsectionTableViewCells
            
            var arrayWithAllDataRelatedToUbsSections = [IsectionsDimensionsParameters]()
            
            var arrayWithAllSectionsSerialNumbers: [String]
            
            if (sortBy == "None" && filtersApplied == false && isSearching == false) {
                
                arrayWithAllDataRelatedToUbsSections = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData
                
                arrayWithAllSectionsSerialNumbers = universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault
                
            } else {
                
                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromSortDataVCViaProtocol
                
                arrayWithAllSectionsSerialNumbers = universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder
                
                cell.sectionDesignationLabel.textColor = UIColor(named: "tableViewHighlightedLabel")
                
                cell.depthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.widthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.flangeThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.webThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.massPerMetreLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.areaOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
            }
            
            cell.sectionDesignationLabel.text = "Section Designation: \( arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == arrayWithAllSectionsSerialNumbers[indexPath.section] }).map({ $0.fullSectionDesignation })[indexPath.row])"
            
            cell.depthOfSectionLabel.text = "Depth, h [mm] = " + String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.depthOfSection })[indexPath.row])
            
            cell.widthOfSectionLabel.text = "Width, b [mm] = " + String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.widthOfSection })[indexPath.row])
            
            let attributedSectionWebThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Web Thickness, tw [mm] = \(String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row]))")
            
            attributedSectionWebThicknessString.setAttributes([.baselineOffset:-3], range: NSRange(location:16,length:1))
            
            cell.webThicknessLabel.attributedText = attributedSectionWebThicknessString
            
            let attributedSectionFlangeThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Flange Thickness, tf [mm] = \(String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row]))")
            
            attributedSectionFlangeThicknessString.setAttributes([.baselineOffset: -3], range: NSRange(location: 19, length: 1))
            
            cell.flangeThicknessLabel.attributedText = attributedSectionFlangeThicknessString
            
            cell.massPerMetreLabel.text = "Mass per Metre [kg/m] = " + String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionMassPerMetre })[indexPath.row])
            
            let attributedAreaOfSectionString: NSMutableAttributedString = NSMutableAttributedString(string: "Area of Section, A [cm2] = \(String(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.areaOfSection })[indexPath.row]))")
            
            attributedAreaOfSectionString.setAttributes([.baselineOffset: 5.5], range: NSRange(location: 22, length: 1))
            
            cell.areaOfSectionLabel.attributedText = attributedAreaOfSectionString
            
            return cell
            
        } else {
            
            let cell = Bundle.main.loadNibNamed("CustomIsectionTableViewCells", owner: self, options: nil)?.first as! CustomIsectionTableViewCells
            
            var arrayWithAllDataRelatedToUbsSections = [IsectionsDimensionsParameters]()
            
            if (sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Section Area in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" || sortBy == "Sorted by: Width of Section in descending order" || sortBy == "Sorted by: Section Area in descending order") {
                
                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromSortDataVCViaProtocol
                
            } else if isSearching == true {
                
                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayAsPerTypedSearchCriteria
                
                if arrayWithAllDataRelatedToUbsSections.count == 0 {
                    
                    let cell = Bundle.main.loadNibNamed("CustomTableViewMessageCell", owner: self, options: nil)?.first as! CustomTableViewMessageCell
                    
                    cell.messageLabel.text = "No results matched searched criteria, try again."
                    
                    return cell
                    
                }
                
            } else if filtersApplied == true {
                
                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol
                
                if arrayWithAllDataRelatedToUbsSections.count == 0 {
                    
                    let cell = Bundle.main.loadNibNamed("CustomTableViewMessageCell", owner: self, options: nil)?.first as! CustomTableViewMessageCell
                    
                    cell.messageLabel.text = "No results matched applied filters, try again."
                    
                    return cell
                    
                }
                
            }
            
            cell.sectionDesignationLabel.text = "Section Designation: \(arrayWithAllDataRelatedToUbsSections.map({ $0.fullSectionDesignation })[indexPath.row])"
            
            cell.depthOfSectionLabel.text = "Depth, h [mm] = " + String(arrayWithAllDataRelatedToUbsSections.map({ $0.depthOfSection })[indexPath.row])
            
            let attributedSectionWebThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Web Thickness, tw [mm] = \(String(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionWebThickness })[indexPath.row]))")
            
            attributedSectionWebThicknessString.setAttributes([.baselineOffset:-3], range: NSRange(location:16,length:1))
            
            cell.webThicknessLabel.attributedText = attributedSectionWebThicknessString
            
            cell.widthOfSectionLabel.text = "Width, b [mm] = " + String(arrayWithAllDataRelatedToUbsSections.map({ $0.widthOfSection })[indexPath.row])
            
            let attributedSectionFlangeThicknessString: NSMutableAttributedString = NSMutableAttributedString(string: "Flange Thickness, tf [mm] = \(String(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionFlangeThickness })[indexPath.row]))")
            
            attributedSectionFlangeThicknessString.setAttributes([.baselineOffset: -3], range: NSRange(location: 19, length: 1))
            
            cell.flangeThicknessLabel.attributedText = attributedSectionFlangeThicknessString
            
            cell.massPerMetreLabel.text = "Mass per Metre [kg/m] = " + String(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionMassPerMetre })[indexPath.row])
            
            let attributedAreaOfSectionString: NSMutableAttributedString = NSMutableAttributedString(string: "Area of Section, A [cm2] = \(String(arrayWithAllDataRelatedToUbsSections.map({ $0.areaOfSection })[indexPath.row]))")
            
            attributedAreaOfSectionString.setAttributes([.baselineOffset: 5.5], range: NSRange(location: 22, length: 1))
            
            cell.areaOfSectionLabel.attributedText = attributedAreaOfSectionString
            
            if sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" {
                
                cell.sectionDesignationLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.depthOfSectionLabel.textColor = UIColor(named: "tableViewHighlightedLabel")
                
                cell.widthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.flangeThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.webThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.massPerMetreLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.areaOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
            } else if sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Width of Section in descending order" {
                
                cell.sectionDesignationLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.depthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.widthOfSectionLabel.textColor = UIColor(named: "tableViewHighlightedLabel")
                
                cell.flangeThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.webThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.massPerMetreLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.areaOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
            } else {
                
                cell.sectionDesignationLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.depthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.widthOfSectionLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.flangeThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.webThicknessLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.massPerMetreLabel.textColor = UIColor(named: "tableViewLabelsColour")
                
                cell.areaOfSectionLabel.textColor = UIColor(named: "tableViewHighlightedLabel")
                
            }
            
            return cell
            
        }
        
    }
    
}

// MARK: - UITableViewDelegate Extension:

extension BlueBookUniversalBeamsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let blueBookUniversalBeamsDataSummaryVcProperties = blueBookUniversalBeamDataSummaryVC as! BlueBookUniversalBeamDataSummaryVC
                
        if (sortBy == "None" && filtersApplied == false && isSearching == false) || sortBy == "Sorted by: Section Designation in ascending order" ||  sortBy == "Sorted by: Section Designation in descending order" {

            var arrayWithAllDataRelatedToUbsSections = [IsectionsDimensionsParameters]()

            var arrayWithAllSectionsSerialNumbers: [String]

            if (sortBy == "None" && filtersApplied == false && isSearching == false) {

                arrayWithAllDataRelatedToUbsSections = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData

                arrayWithAllSectionsSerialNumbers = universalBeamsArrayContainingAllSectionSerialNumberOnlyDefault

            } else {

                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromSortDataVCViaProtocol

                arrayWithAllSectionsSerialNumbers = universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder

            }

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamDepthOfSection = CGFloat(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.depthOfSection })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamWidthOfSection = CGFloat(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.widthOfSection })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamWebThickness = CGFloat(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionWebThickness })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamFlangeThickness = CGFloat(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionFlangeThickness })[indexPath.row])
            
            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamRootRadius = CGFloat(arrayWithAllDataRelatedToUbsSections.filter({ $0.sectionSerialNumber == "\(arrayWithAllSectionsSerialNumbers[indexPath.section])" }).map({ $0.sectionRootRadius })[indexPath.row])

        } else {

            var arrayWithAllDataRelatedToUbsSections = [IsectionsDimensionsParameters]()

            if (sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Section Area in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" || sortBy == "Sorted by: Width of Section in descending order" || sortBy == "Sorted by: Section Area in descending order") {

                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromSortDataVCViaProtocol

            } else if isSearching == true {

                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayAsPerTypedSearchCriteria

            } else if filtersApplied == true {

                arrayWithAllDataRelatedToUbsSections = universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol

            }

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamDepthOfSection = CGFloat(arrayWithAllDataRelatedToUbsSections.map({ $0.depthOfSection })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamWebThickness = CGFloat(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionWebThickness })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamWidthOfSection = CGFloat(arrayWithAllDataRelatedToUbsSections.map({ $0.widthOfSection })[indexPath.row])

            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamFlangeThickness = CGFloat(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionFlangeThickness })[indexPath.row])
            
            blueBookUniversalBeamsDataSummaryVcProperties.selectedUniversalBeamRootRadius = CGFloat(arrayWithAllDataRelatedToUbsSections.map({ $0.sectionRootRadius })[indexPath.row])

        }
        
        self.present(blueBookUniversalBeamDataSummaryVC, animated: true, completion: nil)

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

extension BlueBookUniversalBeamsVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let newText: NSMutableString = NSMutableString(string: searchText)
        
        if searchText.isEmpty == false {
            
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
            
            universalBeamsDataArrayAsPerTypedSearchCriteria = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData.filter({ $0.fullSectionDesignation.lowercased().prefix(searchText.count) == searchText.lowercased() })
            
            isSearching = true
            
            sortBy = "None"
            
            filtersApplied = false
            
            self.universalBeamsTableView.reloadData()
            
        } else {
            
            isSearching = false
            
            self.universalBeamsTableView.reloadData()
            
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
        
        self.searchBar.endEditing(true)
        
    }
    
    // MARK: - Filter Data button pressed:
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        filterDataVC.sortBy = self.sortBy
        
        filterDataVC.isSearching = self.isSearching
        
        filterDataVC.filtersApplied = self.filtersApplied
        
        filterDataVC.delegate = self
        
        
        filterDataVC.universalBeamsDataArrayReceivedFromBlueBookUniversalBeamsVC = originalUniversalBeamsArrayDataExtractedFromTheCSVFileUsingTheParserContainingAllData
        
        self.present(filterDataVC, animated: true, completion: nil)
        
    }
    
}

// MARK: - Protocol extension in order to receive data from SortDataPopOverVC or FilterDataVC:

extension BlueBookUniversalBeamsVC: PassingDataBackwardsProtocol {
    
    func dataToBePassedUsingProtocol(modifiedArrayToBePassed: [IsectionsDimensionsParameters], sortBy: String, filtersApplied: Bool, isSearching: Bool) {
        
        self.sortBy = sortBy
        
        self.filtersApplied = filtersApplied
        
        self.isSearching = isSearching
        
        searchBar.text = ""
        
        if isSearching == false && filtersApplied == false && (sortBy == "Sorted by: Section Designation in ascending order" || sortBy == "Sorted by: Section Designation in descending order" || sortBy == "Sorted by: Depth of Section in ascending order" || sortBy == "Sorted by: Width of Section in ascending order" || sortBy == "Sorted by: Section Area in ascending order" || sortBy == "Sorted by: Depth of Section in descending order" || sortBy == "Sorted by: Width of Section in descending order" || sortBy == "Sorted by: Section Area in descending order") {
            
            // In this case the title for each section header is equal to each section serial number:
            
            self.universalBeamsDataArrayReceivedFromSortDataVCViaProtocol = modifiedArrayToBePassed
            self.universalBeamsArrayContainingAllSectionSerialNumberOnlySortedInAscendingOrDescendingOrder = modifiedArrayToBePassed.map({ return $0.sectionSerialNumber }).removingDuplicates()
            
        } else if filtersApplied == true {
            
            self.universalBeamsDataArrayReceivedFromFilterDataVCViaProtocol = modifiedArrayToBePassed
            
        }
        
        self.universalBeamsTableView.reloadData()
        
        
        
        self.universalBeamsTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
        
        self.view.alpha = 1.0
        
        print("Data has been passed back")
        
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate Extension:

extension BlueBookUniversalBeamsVC: UIPopoverPresentationControllerDelegate {
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
        
    }
    
    // The below function gets called whenever the SortDataPopOverVC gets dismissed:
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        self.view.alpha = 1.0
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        
        return true
        
    }
    
}
