//
//  ViewController.swift
//  Demo_Realm
//
//  Created by Phan Duy Khanh on 4/22/20.
//  Copyright © 2020 Phan Duy Khanh. All rights reserved.
//

import UIKit

import RealmSwift

@objcMembers class Student: Object {
    enum Property: String {
        case id, firstName, lastName, email, address
    }
    
    enum Property2: Int {
        case age, phoneNumber, score
    }
    
    dynamic var id = UUID().uuidString
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var phoneNumber = 0
    dynamic var age = 0
    dynamic var email = ""
    dynamic var address = ""
    dynamic var score = 0
    
    override static func primaryKey() -> String? {
        return Student.Property.id.rawValue
    }
    
    convenience init(firstName: String,
                     lastName: String,
                     email: String,
                     address: String,
                     age: Int,
                     phoneNumber: Int,
                     score: Int) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.age = age
        self.phoneNumber = phoneNumber
        self.score = score
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var arrData: Results<Student>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrData = realm.objects(Student.self)
    }
    
    func pushToAddInformation(data: Student? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "AddInformationViewController") as! AddInformationViewController
        view.delegate = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        view.data = data
        self.present(view, animated: true) {
        }
    }
    
    @IBAction func tapToAddButton(_ sender: Any) {
        pushToAddInformation()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrData?[indexPath.row]
        let cell: InfoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.data = data
        cell.delegate = self
        return cell
    }
}

extension ViewController: AddInforDelegate {
    func reloadData() {
        arrData = realm.objects(Student.self)
        tableView.reloadData()
    }
}

extension ViewController: InfoCellDelegate {
    func delete(obj: Student?) {
        do {
            try realm.write {
                realm.delete(obj!)
                reloadData()
            }
        } catch {
        }
    }
    
    func edit(obj: Student?) {
        pushToAddInformation(data: obj)
    }
}
