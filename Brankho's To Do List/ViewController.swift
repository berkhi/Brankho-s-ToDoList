//
//  ViewController.swift
//  Brankho's To Do List
//
//  Created by BerkH on 30.01.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }

    @IBAction func addButton(_ sender: Any) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = addButton

    }
    @objc func buttonAction(){
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}

