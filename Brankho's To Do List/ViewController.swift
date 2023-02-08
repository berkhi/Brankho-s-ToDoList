//
//  ViewController.swift
//  Brankho's To Do List
//
//  Created by BerkH on 30.01.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var noteArray = [String]()
    var selectedNote = ""
    var chosenNote = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func getData(){
        
        noteArray.removeAll(keepingCapacity: false)

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        
        do{
          let results =  try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let note = result.value(forKey: "note") as? String{
                        self.noteArray.append(note)
                    }
                    self.tableView.reloadData()
                }
            }
        }catch{
            print("error")
        }
       
    }
    

    @IBAction func addButton(_ sender: Any) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAction))
        navigationItem.rightBarButtonItem = addButton

    }
    @objc func buttonAction(){
        selectedNote = ""
        performSegue(withIdentifier: "goToDetails", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = noteArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenNote = selectedNote
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = noteArray[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
            chosenNote = noteArray[indexPath.row]
            fetchRequest.predicate = NSPredicate(format: "note = %@", self.chosenNote)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let  chosenNoteDelete = result.value(forKey: "note") as? String {
                            if chosenNoteDelete == noteArray[indexPath.row] {
                                context.delete(result)
                                noteArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do{
                                   try context.save()
                                }catch{
                                    print("Error while reloading table")
                                }
                                
                                break
                                
                            }
                        }
                    }
                }
            }catch{
                print("Error while deleting")
            }
        }
    }


}

