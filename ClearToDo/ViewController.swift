//
//  ViewController.swift
//  ClearToDo
//
//  Created by alex oh on 2/15/16.
//  Copyright © 2016 Alex Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.rowHeight = 50.0

        if toDoItems.count > 0 {
            return
        }
        
        toDoItems.append(ToDoItem(text: "spank my monkey"))
        toDoItems.append(ToDoItem(text: "buy more kleenex"))
        toDoItems.append(ToDoItem(text: "pray"))
        toDoItems.append(ToDoItem(text: "spank my monkey"))
        toDoItems.append(ToDoItem(text: "buy more kleenex"))
        toDoItems.append(ToDoItem(text: "pray"))
        toDoItems.append(ToDoItem(text: "spank my monkey"))
        toDoItems.append(ToDoItem(text: "buy more kleenex"))
        toDoItems.append(ToDoItem(text: "pray"))
    }
    
    
    func toDoItemDeleted(todoItem: ToDoItem) {
        let index = (toDoItems as NSArray).indexOfObject(todoItem)
        if index == NSNotFound { return }
        
        toDoItems.removeAtIndex(index)
        
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.selectionStyle = .None
        let item = toDoItems[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = item.text
        
        cell.delegate = self
        cell.toDoItem = item
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 0.0, green: val, blue: 1.0, alpha: 1.0)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = colorForIndex(indexPath.row)
    }
}

