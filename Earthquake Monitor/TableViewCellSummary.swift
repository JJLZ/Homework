//
//  TableViewCellSummary.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/15/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import UIKit

class TableViewCellSummary: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblMagnitude: UILabel!
    @IBOutlet weak var lblPlace: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

}
