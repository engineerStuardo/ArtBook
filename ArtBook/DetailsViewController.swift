//
//  DetailsViewController.swift
//  ArtBook
//
//  Created by Italo Stuardo on 26/3/23.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        print("test")
    }
}
