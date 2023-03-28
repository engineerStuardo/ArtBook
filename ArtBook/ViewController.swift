//
//  ViewController.swift
//  ArtBook
//
//  Created by Italo Stuardo on 26/3/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFunction))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func getData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context?.fetch(fetchRequest)
            
            nameArray.removeAll(keepingCapacity: false)
            idArray.removeAll(keepingCapacity: false)
            
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                
                self.tableView.reloadData()
            }
        } catch {
            print("Error fetching data")
        }
    }
    
    @objc func addFunction() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
}

