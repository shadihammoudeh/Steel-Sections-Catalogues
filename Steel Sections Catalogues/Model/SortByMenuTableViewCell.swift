//
//  SortByMenuTableViewCell.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 31/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import UIKit

class SortByMenuTableViewCell: UITableViewCell {
    
    var cellTextLabel: UILabel = {
       
        let label = UILabel()
        
        label.numberOfLines = 1
        
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellTextLabel)
        
        NSLayoutConstraint.activate([
        
            cellTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            cellTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            cellTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
