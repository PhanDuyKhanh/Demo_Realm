//
//  InfoCell.swift
//  Demo_Realm
//
//  Created by Phan Duy Khanh on 4/23/20.
//  Copyright © 2020 Phan Duy Khanh. All rights reserved.
//

import UIKit
protocol InfoCellDelegate {
    func delete(obj: Student?)
    func edit(obj: Student?)
}
class InfoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var delegate: InfoCellDelegate?
    var data: Student? {
        didSet {
            setupData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData() {
        if let data = data {
            nameLabel.text = data.lastName + " " + data.firstName
            phoneLabel.text = String(data.phoneNumber)
            emailLabel.text = data.email
            addressLabel.text = data.address
            ageLabel.text = String(data.age)
            scoreLabel.text = String(data.score)
        }
    }
    
    @IBAction func tapToDeleteButton(_ sender: Any) {
        delegate?.delete(obj: data)
    }
    @IBAction func tapToEditButton(_ sender: Any) {
        delegate?.edit(obj: data)
    }
    
}
