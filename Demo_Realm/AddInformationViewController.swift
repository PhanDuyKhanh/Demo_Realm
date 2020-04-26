//
//  AddInformationViewController.swift
//  Demo_Realm
//
//  Created by Phan Duy Khanh on 4/23/20.
//  Copyright © 2020 Phan Duy Khanh. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddInforDelegate {
    func reloadData()
}

class AddInformationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    
    var data: Student?
    let realm = try! Realm()
    var delegate: AddInforDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToHideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        if let data = data {
            firstNameTextField.text = data.firstName
            lastNameTextField.text = data.lastName
            emailTextField.text = data.email
            phoneNumberTextField.text = String(data.phoneNumber)
            ageTextField.text = String(data.age)
            addressTextField.text = data.address
            scoreTextField.text = String(data.score)
        }
    }
    
    @objc
    func tapToHideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tapToSaveButton(_ sender: Any) {
        tapToHideKeyboard()
        if let data = data {
            do {
                try realm.write {
                    data.firstName = firstNameTextField.text ?? ""
                    data.lastName = lastNameTextField.text ?? ""
                    data.email = emailTextField.text ?? ""
                    data.address = addressTextField.text ?? ""
                    data.phoneNumber = Int(phoneNumberTextField.text ?? "") ?? 0
                    data.age = Int(ageTextField.text ?? "") ?? 0
                    data.score = Int(scoreTextField.text ?? "") ?? 0
                }
            } catch {
            }
        } else {
            do {
                try realm.write {
                    realm.add(Student(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", address: addressTextField.text ?? "", age: Int(ageTextField.text ?? "") ?? 0, phoneNumber: Int(phoneNumberTextField.text ?? "") ?? 0, score: Int(scoreTextField.text ?? "") ?? 0), update: .all)
                }
            } catch {
            }
        }
        
        
        dismiss(animated: true) {
            self.delegate?.reloadData()
        }
    }
    
    @IBAction func tapToCancelButton(_ sender: Any) {
        tapToHideKeyboard()
        dismiss(animated: true) {
            
        }
    }
}
