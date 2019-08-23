//
//  mealTableViewController.swift
//  mealLog
//
//  Created by Jianli He on 8/12/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit
import os.log

class mealTableViewController: UITableViewController {
    
    var meals=[meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        if let savedMeals=loadMeals() {
            meals += savedMeals
        }
        else {
            loadSampleMeals()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier="MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? mealTableViewCell else {
            fatalError("Cannot creat cell")
        }

        let meal=meals[indexPath.row]
        cell.nameLabel.text=meal.name
        cell.photoImageView.image=meal.photo
        cell.ratingControl.rating=meal.rating
        
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal", log:OSLog.default,type:.debug)
        case "ShowDetail":
            guard let mealDetailViewController=segue.destination as? MealViewController else {
                fatalError("Unexpected Error in \(segue.destination)")
            }
            guard let sourceCell = sender as? mealTableViewCell else {
                fatalError("Expected error in source \(sender ?? "")")
            }
            guard let indexPath=tableView.indexPath(for: sourceCell) else {
                fatalError("cannot get index path for \(sourceCell)")
            }
            let selectedMeal=meals[indexPath.row]
            mealDetailViewController.newmeal=selectedMeal
        default:
            fatalError("unexpected indentifier \(segue.identifier ?? "")")
        }
    }
    
    //MARK: actions
    @IBAction func unwindToTableView(sender: UIStoryboardSegue) {
        if let sourceController=sender.source as? MealViewController, let newMeal=sourceController.newmeal {
            if let selectedIndexPath=tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row]=newMeal
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
            else {
            let newIndexPath=IndexPath(row:meals.count,section: 0)
            meals.append(newMeal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals()
        }
    }
    //MARK: private functions
    private func loadSampleMeals() {
        let photo1=UIImage(named:"sample1")
        let photo2=UIImage(named:"sample2")
        let photo3=UIImage(named:"sample3")
        
        guard let meal1 = meal(name:"Salad",photo: photo1,rating: 4) else {
            fatalError("cannot creat meal 1")
        }
        
        guard let meal2 = meal(name: "chilcken", photo: photo2, rating: 5) else {
            fatalError("cannot creat meal 2")
        }
        
        guard let meal3 = meal(name: "pasta", photo: photo3, rating: 3) else {
            fatalError("cannot creat meal 3")
        }
        
        meals += [meal1,meal2,meal3]
    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [meal]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: meal.ArchiveURL.path) as? [meal]
    }

}
