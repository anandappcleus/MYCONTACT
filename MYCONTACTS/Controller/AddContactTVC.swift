//
//  AddContactTVC.swift
//  MYCONTACTS
//
//  Created by NexGenTech on 26/06/18.
//  Copyright © 2018 Anand. All rights reserved.
//

import UIKit
import RealmSwift



class AddContactTVC: UITableViewController,UIPopoverPresentationControllerDelegate,CountryCodeTVCProtocol,UIAlertViewDelegate  {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    var alert :UIAlertController!
    
    var userDetail:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        self.navigationItem.title = "ADD CONTACT"
        UIsetup()
        
    }
    
    func UIsetup()
    {
        if userDetail != nil
        {
            self.firstNameLabel.text = self.userDetail?.firstName
            self.lastNameLabel.text = self.userDetail?.lastName
            self.phoneLabel.text = self.userDetail?.phone
            self.emailLabel.text = self.userDetail?.email
            self.countryCodeLabel.text = self.userDetail?.countryCode
        }
    }

   
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    @IBAction func addContactButtonAction(_ sender: UIButton) {
        
        if self.userDetail == nil
        {
            if isEmailIDValid(self.emailLabel.text!)
            {
            
            //Saving Data
            let realm = try? Realm()
            let contactDetail = Contact(firstName: self.firstNameLabel.text!, lastName: self.lastNameLabel.text!, phone: self.phoneLabel.text!, email: self.emailLabel.text!, countryCode: self.countryCodeLabel.text!)
            
         
            self.alert = UIAlertController(title: "Do You Want To Save Data", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                
                
                try? realm?.write {
                    realm?.add(contactDetail)
                    
                    DispatchQueue.main.async {
                        self.firstNameLabel.text = ""
                        self.lastNameLabel.text = ""
                        self.phoneLabel.text = ""
                        self.emailLabel.text = ""
                        self.countryCodeLabel.text = ""
                        
                        
                    }
                    
                }
                
                
                
            }
                        
           
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
                
                DispatchQueue.main.async {
                    self.firstNameLabel.text = ""
                    self.lastNameLabel.text = ""
                    self.phoneLabel.text = ""
                    self.emailLabel.text = ""
                    self.countryCodeLabel.text = ""
                    
                    
                }
                
            }
            
            
                
                
            
            
            self.alert.addAction(saveAction)
            
            self.alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        
        
        }
        }
        
        else
        {
            if isEmailIDValid(self.emailLabel.text!)
            {
                
                //Saving Data
                let realm = try? Realm()
                let contactDetail = Contact(firstName: self.firstNameLabel.text!, lastName: self.lastNameLabel.text!, phone: self.phoneLabel.text!, email: self.emailLabel.text!, countryCode: self.countryCodeLabel.text!)
                
                
                self.alert = UIAlertController(title: "Do You Want To Save Data", message: "", preferredStyle: .alert)
                
                let saveAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                    
                    
                    try? realm?.write {
                        realm?.add(contactDetail)
                       
                        
                        DispatchQueue.main.async {

                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        
                    }
                    
                    
                    
                }
                
                
                let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
                    
                    DispatchQueue.main.async {
                        
                        
                    }
                    
                }
                
               
                self.alert.addAction(saveAction)
                
                self.alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
        }
        
    }
 
    
    func didSendCountryCode(_ countryCode: String) {
        print(countryCode)
        self.countryCodeLabel.text = "\(countryCode)"
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countrycodesegue"
        {
            let countryCodeTVC = segue.destination as! CountryCodeTVC
            countryCodeTVC.popoverPresentationController!.delegate = self
            countryCodeTVC.preferredContentSize = CGSize(width: 300,height: 234)
            countryCodeTVC.delegate = self
        }
    }
    
    func isEmailIDValid(_ email:String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._]+@[A-Za-z0-9.]+.[A-Za-z]"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if  predicate.evaluate(with: email)
        {
            return true
        }
        else
        {
            let alertView = UIAlertView(title: "Error", message: "Please enter a valid email id", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
            alertView.show()
            return false
        }
    }


}
