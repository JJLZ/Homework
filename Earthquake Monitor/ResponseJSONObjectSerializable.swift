//
//  ResponseJSONObjectSerializable.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/14/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    
    init?(json: SwiftyJSON.JSON)
}
