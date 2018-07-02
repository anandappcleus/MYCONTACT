//
//  MyContactVC.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.

import UIKit
import RealmSwift

class MyContactVC: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate
{
 @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
     let realm = try? Realm()
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
        if searchText.characters.count >= 3
        {
            //To fetch data from DB and Converting Realm Object to Array Object
           // let realm = try? Realm()
            
            
            let contactDetails = self.realm?.objects(Contact.self).toArray(ofType: Contact.self)
           
            //comapring string based on search string
            let searchResult = contactDetails?.filter{ $0.firstName.caseInsensitiveCompare(searchText) == .orderedSame }
            
            if searchResult != nil
            {
                self.searchResults = searchResult!
            }
            
           
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // Edit
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            
            let addContactTVC = self.storyboard?.instantiateViewController(withIdentifier: "AddContactTVC") as! AddContactTVC
            if let user = self.realm?.objects(Contact.self).toArray(ofType: Contact.self)[indexPath.row]
            {
                
                addContactTVC.userDetail = user
                
                //print(realm.objects(User.self).first)
            }
            self.navigationController?.pushViewController(addContactTVC, animated: true)
            
            DispatchQueue.main.async(execute: { () -> Void in
                tableView.endEditing(true)
            })
        })
        
        editAction.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        
        // Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            
           // let realm = try? Realm()
            if let user = self.realm?.objects(Contact.self)[indexPath.row]
            {
                try! self.realm?.write {
                    self.realm?.delete(user)
                }
                self.searchResults = (self.realm?.objects(Contact.self).toArray(ofType: Contact.self))!
                
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                tableView.endEditing(true)
            })
        })
        
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction,deleteAction]
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


