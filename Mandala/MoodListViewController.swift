//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Juan Manuel Tome on 05/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class MoodListViewController: UITableViewController {
    
    var moodEntries: [MoodEntry] = [MoodEntry]()
    
    //let defaults = UserDefaults.standard
    
    //    override func didMove(toParent parent: UIViewController?) {
    //        super.didMove(toParent: parent)
    //
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadUserDefaults()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//TODO: - Implement Codable on the MoodEntry Type to save table to userdefaults
    
//    func saveUserDefaults() {
//        defaults.set(moodEntries, forKey: "moodEntries")
//    }
//    func loadUserDefaults() {
//        self.moodEntries = defaults.object(forKey: "moodEntries") as? [MoodEntry] ?? [MoodEntry]()
//    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moodEntries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let moodEntry = moodEntries[indexPath.row]
        cell.backgroundColor = moodEntry.mood.color
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        let dateString = DateFormatter.localizedString(from: moodEntry.timestamp, dateStyle: .medium, timeStyle: .short)
        cell.detailTextLabel?.text = "on \(dateString)"
        // Configure the cell...
        
        //saveUserDefaults()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            
            // 1. remove object from your array
            self.moodEntries.remove(at: indexPath.row)
            
            //        self.itemStore.allItems.remove(at: indexPath.row)
            // 2. reload the table, otherwise you get an index out of bounds crash
            //self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        //saveUserDefaults()
        
        return configuration
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension MoodListViewController: MoodsConfigurable {
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    
}
