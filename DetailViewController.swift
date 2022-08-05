//
//  DetailViewController.swift
//  MyTest
//
//  Created by Mac on 05/08/22.
//

import UIKit

class DetailViewController: UIViewController {
    var user: UserModelElement!
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
    
    func setupUi() {
        userID.text = String(user.userID)
        titleLbl.text = user.title
        body.text = user.body
    }

}
