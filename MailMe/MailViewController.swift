//
//  MailViewController.swift
//  MailMe
//
//  Created by Friedel Ziegelmayer on 02/11/14.
//  Copyright (c) 2014 Friedel Ziegelmayer. All rights reserved.
//

import Cocoa

class MailViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView!

    dynamic var mails: [MCOIMAPMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let session = MCOIMAPSession()
        session.hostname = "imap.gmail.com"
        session.port = 993
        session.username = "friedel.ziegelmayer@gmail.com"
        session.password = "mygooglemail33"
        session.connectionType = MCOConnectionType.TLS
        
        let requestKind = MCOIMAPMessagesRequestKind.Headers
        let folder = "INBOX"
        let uids = MCOIndexSet(range: MCORangeMake(1, 10))
        
        let fetchOperation = session.fetchMessagesByNumberOperationWithFolder(folder, requestKind: requestKind, numbers: uids)
        
        fetchOperation.start { (error, fetchedMessages, vanishedMessages) -> Void in
            if ((error) != nil) {
                println("Error downloading message headers: \(error)")
            }

            self.mails = fetchedMessages as [MCOIMAPMessage]
            
//            var content = ""
//            
//            for message in fetchedMessages {
//
//                let header = message.header as MCOMessageHeader
//                println(header.from.nonEncodedRFC822String())
//                
//                content += "from: \(header.from.nonEncodedRFC822String())\n"
//
//                var recipients = "to: "
//                for recipient in header.to {
//                    recipients += "\(recipient.nonEncodedRFC822String()), "
//                }
//
//                content += "\(recipients)\n"
//                content += "re: \(header.subject)\n"
//                content += "\n---\n"
//            }
            
            //self.textOutput.stringValue += content
            
        }
        
    }
    
    // Table View Methods
    // ------------------
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject!
    {
        //        var string:String = "row " + String(row) + ", Col" + String(tableColumn.identifier)
        //        return string

        return self.data[row]    }
    
    let data = [
        "Debasis",
        "Friedel",
        "Joel"
    ]
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView? {
        
        // Get an existing cell with the MyView identifier if it exists
        var result = tableView.makeViewWithIdentifier("MailPreviewListItemCell", owner:self) as MailPreviewListItemView?
        
        // There is no existing cell to reuse so create a new one
        if result == nil {
            let cellNib = NSNib(nibNamed: "MailPreviewListItem", bundle: nil)
            tableView.registerNib(cellNib!, forIdentifier: "MailPreviewListItemCell")
            
            // Create the new NSTextField with a frame of the {0,0} with the width of the table.
            // Note that the height of the frame is not really relevant, because the row height will modify the height.
            result = tableView.makeViewWithIdentifier("MailPreviewListItemCell", owner:self) as MailPreviewListItemView?
        }
        
        // result is now guaranteed to be valid, either as a reused cell
        // or as a new cell, so set the stringValue of the cell to the
        // nameArray value at row
        result?.senderLabel.stringValue = self.data[row]
        
        // Return the result
        return result

        
    }
    
}
