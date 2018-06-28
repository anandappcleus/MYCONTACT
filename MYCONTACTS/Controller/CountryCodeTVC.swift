//
//  CountryCodeTVC.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit

protocol CountryCodeTVCProtocol:class {
    func didSendCountryCode(_ countryCode:String)
}

class CountryCodeTVC: UITableViewController{

    weak var delegate:CountryCodeTVCProtocol?
    
    var countryCodes = [[String:Any]]()
    {
        didSet
        {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCountryCodes()
    }

   func loadCountryCodes()
   {
        ContactManager.shared.getCountryCodes { (success, message, countryCodes) in
            
            if success
            {
                if let countryCodes = countryCodes
                {
                    self.countryCodes = countryCodes
                }
                
            }
        }
    }
    
   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.countryCodes.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let country = self.countryCodes[indexPath.row]
        cell.textLabel?.text = "\(country["name"]!) [\(country["alpha2Code"]!)]"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didSendCountryCode(self.countryCodes[indexPath.row]["alpha2Code"] as! String)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    

    
   

}
