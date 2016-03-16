//
//  Singleton.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/16/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
    
    static let sharedInstance = Singleton()
    
    init() {
        
    }
    
    /**
     Set color for magnitude
     
     - parameter magnitude: magnitude of the earthquake
     
     - returns: UIColor with the color
     */
    func colorForMagnitude(magnitude: Float) -> UIColor {
        
        switch magnitude {
            
        case 0.0...0.9:
            return UIColor.init(red: 0.83, green: 0.93, blue: 0.75, alpha: 1.0)
        case 1.0...1.9:
            return UIColor.init(red: 1.0, green: 1.0, blue: 0.83, alpha: 1.0)
        case 2.0...2.9:
            return UIColor.init(red: 1.0, green: 0.95, blue: 0.69, alpha: 1.0)
        case 3.0...3.9:
            return UIColor.init(red: 1.0, green: 0.88, blue: 0.55, alpha: 1.0)
        case 4.1...4.9:
            return UIColor.init(red: 1.0, green: 0.75, blue: 0.41, alpha: 1.0)
        case 5.0...5.9:
            return UIColor.init(red: 1.0, green: 0.62, blue: 0.36, alpha: 1.0)
        case 6.1...6.9:
            return UIColor.init(red: 0.99, green: 0.31, blue: 0.16, alpha: 1.0)
        case 7.0...7.9:
            return UIColor.init(red: 0.91, green: 0.24, blue: 0.26, alpha: 1.0)
        case 8.0...8.9:
            return UIColor.init(red: 0.78, green: 0.16, blue: 0.28, alpha: 1.0)
        case 9.0...10.0:
            return UIColor.init(red: 0.58, green: 0.15, blue: 0.28, alpha: 1.0)
            
        default:
            return UIColor.clearColor()
        }
    }
}
