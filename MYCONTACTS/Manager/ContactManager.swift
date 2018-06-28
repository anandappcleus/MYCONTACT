//
//  ContactManager.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import Foundation
import Alamofire

class ContactManager
{
    static let shared = ContactManager()
    
    func getCountryCodes(completionHandler:@escaping(_ success:Bool,_ statusMessage:String,_ countryCodes:[[String:Any]]?)->())
    {
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://restcountries.eu/rest/v1/all")! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request as URLRequest).validate().responseJSON { (response) in
            
            switch response.result
            {
            case .success :
                
                if let responseDict = response.result.value as? [[String:Any]]
                {
                    completionHandler(true,"",responseDict)
                }
                else
                {
                    completionHandler(false,"Failed to retrieve rewardSummary. Please try again.",nil)
                }
                
            case .failure:
                
                
              
                
                completionHandler(false,"Failed to retrieve rewardSummary. Please try again.",nil)
                
            }
        }
    }
}
