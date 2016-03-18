//
//  MainViewController.swift
//  Your App
//
//  Created by Swift Off Starting Template.
//  Copyright © 2016 You. All rights reserved.
//

import UIKit
import Material
import Firebase

// Be sure to change this URL for your real app.
let FIREBASE_BASE_URL = "https://swift-off.firebaseio.com"

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet weak var toDoTableView: UITableView!
    
    let fireBaseRef: Firebase = Firebase(url: FIREBASE_BASE_URL + "/todos")
    var toDoItems: [ToDoItem] = []

    // Tasks to run after the main view has loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationBarViewExample()
        fetchAndWatchFireBaseItems()
    }

    override func viewWillAppear(animated: Bool) {
        // Presents the Primer Flow
        Primer.presentExperience()
    }

    // General tasks to prepare view to be shown.
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
    
    // Given two to do items, decides which item should be first in a list.
    // Returns true if toDo1 should be first, and false if toDo2 should be first
    func compareToDoItems(toDo1: ToDoItem, toDo2: ToDoItem) -> Bool {
        // Groups to dos by whether they are completed or not.
        if (!toDo1.isComplete && toDo2.isComplete) {
            return true
        } else if (toDo1.isComplete && !toDo2.isComplete) {
            return false
        }
        // Groups are also sorted with the newest to dos at the top.
        return toDo1.createdAt.compare(toDo2.createdAt) == NSComparisonResult.OrderedDescending
    }

    // Initially fetches to do items, then observes and syncs changes from firebase.
    func fetchAndWatchFireBaseItems() {
        // observeEventType allows us to run this block of code when there is a change in firebase, syncing the app.
        self.fireBaseRef.observeEventType(.Value, withBlock: { snapshot in
            if !snapshot.exists() {
                self.fireBaseRef.setValue([]) // If no todos on server, initializes the value to an empty dictionary.
                return
            }
            self.toDoItems.removeAll()
            let snapshotToDos = snapshot.value as! NSDictionary
            let enumerator = snapshotToDos.keyEnumerator()
            while let key = enumerator.nextObject() as? String {
                if let value = snapshotToDos[key] {
                    let text = value["text"] as? String
                    let createdAt = value["createdAt"] as? NSTimeInterval
                    let isComplete = value["isComplete"] as? Bool
                    if text != nil && createdAt != nil && isComplete != nil {
                        let todo = ToDoItem(text: text!, key: key, timeSince1970: createdAt!, isComplete: isComplete!)
                        self.toDoItems.append(todo)
                    }
                }
            }
            self.toDoItems.sortInPlace(self.compareToDoItems)
            self.toDoTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let mycell = tableView.dequeueReusableCellWithIdentifier("toDoItemCell", forIndexPath: indexPath) as! ToDoTableViewCell
        let toDo = toDoItems[indexPath.row]
        
        let labelText =  NSMutableAttributedString(string: toDo.text)
        if toDo.isComplete {
            labelText.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, labelText.length))
        }
        mycell.cellLabel.attributedText = labelText
        return mycell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let toDo = toDoItems[indexPath.row]
        toDo.isComplete = !toDo.isComplete
        toDo.save()
    }

    func prepareNavigationBarViewExample() {
        // Stylize.
        navigationBarView.backgroundColor = MaterialColor.indigo.darken1

        // To lighten the status bar add the "View controller-based status bar appearance = NO"
        // to your info.plist file and set the following property.
        navigationBarView.statusBarStyle = .LightContent

        // Title label.
        let titleLabel = UILabel()
        titleLabel.text = "To Do"
        titleLabel.textAlignment = .Left
        titleLabel.textColor = MaterialColor.white
        titleLabel.font = RobotoFont.regularWithSize(20)
        navigationBarView.titleLabel = titleLabel
        navigationBarView.titleLabelInset.left = 64

        // Menu button.
        let menuButtonImage = UIImage(named: "ic_menu_white")
        let menuButton: FlatButton = FlatButton()
        menuButton.pulseColor = MaterialColor.white
        menuButton.pulseScale = false
        menuButton.setImage(menuButtonImage, forState: .Normal)
        menuButton.setImage(menuButtonImage, forState: .Highlighted)
        menuButton.addTarget(self, action: "openSideView:", forControlEvents: .TouchUpInside)
        
        let addWhiteIcon = UIImage(named: "ic_add_white")
        let positionX = view.bounds.size.width - 100
        let positionY = view.bounds.size.height - 100
        let diameter: CGFloat = 54
        let btnCompose: FabButton = FabButton(frame: CGRectMake(positionX, positionY, diameter, diameter))
        btnCompose.setImage(addWhiteIcon, forState: .Normal)
        btnCompose.setImage(addWhiteIcon, forState: .Highlighted)
        btnCompose.addTarget(self, action: "openAddToDoModal:", forControlEvents: .TouchUpInside)
        
        // Add button to UIViewController.
        view.addSubview(btnCompose)
        
        // Add buttons to left side.
        navigationBarView.leftButtons = [menuButton]
        
        // Add buttons to right side.
        // navigationBarView.rightButtons = [btn2]
        
        MaterialLayout.height(view, child: navigationBarView, height: 70)
    }

    // Called when our add to do button is tapped
    func openAddToDoModal(sender:UIButton!) {
        let addToDoController = UIAlertController(title: "Add To Do", message: "", preferredStyle: .Alert)
        addToDoController.addTextFieldWithConfigurationHandler({
            (textField: UITextField) in
                textField.placeholder = "Call Dave..."
        })
        let cancelAction = UIAlertAction(title:"Cancel", style: .Cancel, handler: {
            action in
                return
        })
        let saveAction = UIAlertAction(title:"Save", style: .Default, handler: {
            action in
                let value = addToDoController.textFields!.first!.text
                if value != "" {
                    let newToDo: ToDoItem = ToDoItem(text: value!)
                    newToDo.save()
                }
        })
        addToDoController.addAction(cancelAction)
        addToDoController.addAction(saveAction)
        self.presentViewController(addToDoController, animated: true, completion: nil)
    }
    
    func openSideView(sender:UIButton!) {
        sideNavigationViewController?.toggleLeftView()
    }
}

