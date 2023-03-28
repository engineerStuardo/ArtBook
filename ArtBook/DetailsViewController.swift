//
//  DetailsViewController.swift
//  ArtBook
//
//  Created by Italo Stuardo on 26/3/23.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGR = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGR)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPaiting = NSEntityDescription.insertNewObject(forEntityName: "Painting", into: context)
        
        newPaiting.setValue(nameText.text, forKey: "name")
        newPaiting.setValue(artistText.text, forKey: "artist")
        if let year = Int(yearText.text!) {
            newPaiting.setValue(year, forKey: "year")
        }
        newPaiting.setValue(UUID(), forKey: "id")
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        newPaiting.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            let alert = UIAlertController(title: "Congratulation", message: "Paiting successfuly saved!!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
                NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okButton)
            self.present(alert, animated: true)
            print("Success")
        } catch {
            print("Error")
        }
    }
}
