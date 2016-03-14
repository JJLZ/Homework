//
//  GeoAPIManager.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/13/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GeoAPIManager {
    
    static let sharedInstance = GeoAPIManager()
    
    //--newcode now --//
//    func getLatestReports() -> Void {
//        
//        // TODO: implement
//    }
    
    //--newcode now --//
    func printAllPastHour() -> Void {
        
        Alamofire.request(GeoRouter.GetAllPastHour())
            .responseString { response in
                if let receivedString = response.result.value {
                    
                    print(receivedString)
                }
        }
    }
}
