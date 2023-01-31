//
//  DetailsVC.swift
//  Brankho's To Do List
//
//  Created by BerkH on 31.01.2023.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var textField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
    }
    
}
