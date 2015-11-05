/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chat:Chat = Chat()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    func getData() {
        let query = PFQuery(className:Chat.parseClassName())
        query.includeKey("messages")
        query.getFirstObjectInBackgroundWithBlock {
            (chat: PFObject?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successful query.")
                // Do something with the found objects
                if let chat = chat as? Chat {
                    print("Successfully retrieved chat: \(chat)")
                    self.chat = chat
                } else {
                    //no chat? Better save one then
                    print("No chat. Saving one.")
                    self.saveBlankChat()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                self.saveBlankChat()
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func addMessage(sender: AnyObject) {
    }
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        if let addMessageVC = segue.sourceViewController as? DetailViewController {
            if let messageInput = addMessageVC.inputTextField.text {
                let message = Message(className: Message.parseClassName())
                message.text = messageInput
                chat.messages.append(message)
                chat.saveInBackgroundWithBlock({ (saved, error) -> Void in
                    if error == nil {
                        print("Successfully saved message")
                        self.getData()
                    } else {
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                })
            }
        }
    }
    func saveBlankChat() {
        print("Saving a basic chat with no messages.")
        self.chat.messages = []
        self.chat.saveInBackground()
    }
    @IBAction func reloadChat(sender: AnyObject) {
        getData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chat.messages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Message", forIndexPath: indexPath)
        if let textLabel = cell.textLabel {
            textLabel.text = self.chat.messages[indexPath.row].text
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
