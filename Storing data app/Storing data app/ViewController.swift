//
//  ViewController.swift
//  Storing data app
//
//  Created by Ori Karudo on 8/19/19.
//  Copyright © 2019 Ori Karudo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadFromPhone()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.becomeFirstResponder()
        loadFromPhone()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        cell.textLabel?.text = String(inputList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //subtract from total
            var temp = Int(total.text!)
            temp = temp! - inputList[indexPath.row]
            total.text = String(temp!)
            
            //remove from list
            inputList.remove(at: indexPath.row)
            
            //remove from table
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            //not used
        }
    }

    var inputList = [Int]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var total: UILabel!
    @IBAction func add(_ sender: Any) {
        loadFromPhone()
        inputList.append(Int(input.text!) ?? 0)
        print(inputList)
        tableView?.reloadData()
        var temp = Int(total.text!)
        let temp2 = Int(input.text!) ?? 0
        temp = temp! + temp2
        total.text = String(temp!)
        input.text = ""
        saveToPhone()
        
    }
    @IBAction func clear(_ sender: Any) {
        inputList.removeAll()
        tableView?.reloadData()
        total.text = "0"
        input.text = ""
        
        
    }
    
    let defaults = UserDefaults.standard
    func saveToPhone() {
        defaults.set(inputList, forKey: "list1")
    }
    
    func loadFromPhone() {
        inputList = defaults.array(forKey: "list1") as? [Int] ?? [Int]()
    }
    

}

