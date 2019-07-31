//
//  CsvParser.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import Foundation

public class CsvParser {
    
    // The below Variable stores the titles to be extracted from the concerned CSV file, which should be included in the first row of the extracted CSV data:
    
    public var headers: [String] = []
    
    // The below Variable stores the extracted CSV data for each row in an Arrays of Dictionaries format:
    
    public var rows: [Dictionary<String, String>] = []
    
    public var columns = Dictionary<String, [String]>()
    
    // The below Variable defines the character that is going to be used to separate CSV data into multiple rows in an Arrays of Dictionaries format:
    
    var delimiter = CharacterSet(charactersIn: ",")
    
    // Encoding in the below function refers to the deafult encoding used to read the file (default is UTF-8). Unicode is a text-encoding standard that became necessary as many non-English speaking parts of the world became connected to the World Wide Web. It defines threee structures that are relevant to us: UTF8, UTF16, and UTF32. The number at the end of thos three names represent the size of their code units. A code unit are short blocks of bits that, when combined, represent characters. UTF8 has 8-bit code units and UTF16 has 16-bit code units:
    
    public init(content: String?, delimiter: CharacterSet, encoding: UInt) throws {
        
        // Below we are checking if the contents inside the CSV file actually exists, which is of type Optional String:
        
        if let csvStringToParse = content {
            
            self.delimiter = delimiter
            
            // The below CharacterSet represents a set of Unicode-compliant characters. Foundation types use CharacterSet to group characters together for searching operations, so that they can find any of a particular set of character during a search. CharactersSet is an Objective-C bridged Swift class that represents a set of Unicode characters. Its Objective-C counterpart, NSCharacterSet is itself toll-free bridged with Core Foundation's CFCharacterSet. The below newLines returns a character set containing the newline characters.
            
            let newline = CharacterSet.newlines
            
            // Below we are defining a Variable that is Array, which is going to hold String type values:
            
            var lines: [String] = []
            
            // In the below line of code, trimmingCharacters returns a new string made by removing from both ends of the receiver characters contained in a given character set. Basically, this removes unwanted characters from a String such as white sapces, new lines, commas etc. enurmerateLines in the below code lines instruct Xcode to go over every line:
            
            csvStringToParse.trimmingCharacters(in: newline).enumerateLines { line, stop in lines.append(line) }
            
            
            
            self.headers = self.parseHeaders(fromLines: lines)
            
            self.rows = self.parseRows(fromLines: lines)
            
            self.columns = self.parseColumns(fromLines: lines)
            
        }
        
    }
    
    public convenience init(contentOfURL url: String) throws {
        
        let comma = CharacterSet(charactersIn: ",")
        
        let csvString: String?
        
        do {
            
            csvString = try String(contentsOfFile: url, encoding: String.Encoding.utf8)
            
        } catch _ {
            
            csvString = nil
            
        };
        
        try self.init(content: csvString, delimiter: comma, encoding: String.Encoding.utf8.rawValue)
        
    }
    
    // The below function is responsible to extract the titles for each column, i.e., the key to be assigned to each Dictionary, which in turn is going to have a value. The titles in the inserted CSV file must be included in the first row, that's why in the below code we are extracting the titles from index 0 of the array, i.e., first item in the Array. Eavh title is separed from the next by a comma (i.e., delimiter):
    
    func parseHeaders(fromLines lines: [String]) -> [String] {
        
        return lines[0].components(separatedBy: self.delimiter)
        
    }
    
    // The below function go through each line of the CSV data and convert it the data in each line (row) into an array of dictionaries, whereby each dictionary in the array contains the header as a key and its corresponding value as the dictionary Value:
    
    func parseRows(fromLines lines: [String]) -> [Dictionary<String, String>] {
        
        var rows: [Dictionary<String, String>] = []
        
        for (lineNumber, line) in lines.enumerated() {
            
            // The reason we are ignoring row at index 0 (i.e., the first row) is because it contains the titles, which represent the Keys for the dictionaries that we extracted before as illustrated in the above function:
            
            if lineNumber == 0 {
                
                continue
                
            }
            
            var row = Dictionary<String, String>()
            
            let values = line.components(separatedBy: self.delimiter)
            
            for (index, header) in self.headers.enumerated() {
                
                if index < values.count {
                    
                    row[header] = values[index]
                    
                } else {
                    
                    row[header] = ""
                    
                }
                
            }
            
            rows.append(row)
            
        }
        
        return rows
        
    }
    
    // The below function is used to extract data from the CSV file in an array of dictionaries format, when the data in the CSV file are orginally organised in a way where the title (i.e, the Dictionary Key) is located in a vertical format and the corresponding Dictionary Value is stated next to each key. That is to say something similar to having an Excel spreadsheet rotated 90 degrees. Basically all the Dictionary Keys and Values are listed in a columns format:
    
    func parseColumns(fromLines lines: [String]) -> Dictionary<String, [String]> {
        
        var columns = Dictionary<String, [String]>()
        
        for header in self.headers {
            
            let column = self.rows.map { row in row[header] != nil ? row[header]! : "" }
            
            columns[header] = column
            
        }
        
        return columns
        
    }
    
}
