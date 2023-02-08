//
//  DetailsVC.swift
//  Brankho's To Do List
//
//  Created by BerkH on 31.01.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    var chosenNote = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        detailsLabel.isHidden = true
        
        if chosenNote != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
            
            fetchRequest.predicate = NSPredicate(format: "note = %@", self.chosenNote)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
              let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let note = result.value(forKey: "note") as? String{
                            textView.text = note
                            textField.isHidden = true
                            let barButton = self.navigationItem.rightBarButtonItem
                            barButton?.isEnabled = false
                            notesLabel.isHidden = true
                            detailsLabel.isHidden = false

                        }
                    }
                }
            }catch{
                
            }
        }
        

    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: context)
        newNote.setValue(textField.text, forKey: "note")
        /*
        let event = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: context)


        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let dateTime = dateFormatter.string(from: date)

        event.setValue(dateTime, forKeyPath: "createdDate")
*/
        do {
            try context.save()
            print("Save success")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        

    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}
