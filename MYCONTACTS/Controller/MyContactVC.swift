//
//  MyContactVC.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.

import UIKit
import RealmSwift

class MyContactVC: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {

   

    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    
    var searchResults = [Contact]()
    {
        didSet
        {
            DispatchQueue.main.async(execute: { () -> Void in
                self.searchResultsTableView.reloadData()
            })
            
        }
    }
    
    var filteredData: [String]!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Changing Search bar Text color
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.gray
        self.SearchBar.tintColor = UIColor.darkGray
        searchResultsTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.searchResultsTableView.isHidden = true
        
        
        
    }
    
    
    
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closeButtonAction(_ sender: UIButton)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Search Bar Delegate Method
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.characters.count >= 2
        {
            //To fetch data from DB
            let realm = try? Realm()
            let contactDetails = realm?.objects(Contact.self).toArray(ofType: Contact.self) as? [Contact]

            self.searchResults = contactDetails!

            
            self.searchResultsTableView.isHidden = false
            
        }
        else
        {
            self.searchResults = []
            self.searchResultsTableView.isHidden = true
            
        }
    }
    
    
    
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyContactCell") as? MyContactCell
        
        cell?.title.text = self.searchResults[indexPath.row].firstName
        cell?.value.text = self.searchResults[indexPath.row].email
        
        return cell!
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.SearchBar.resignFirstResponder()
        
        
    }
    
    

   
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
