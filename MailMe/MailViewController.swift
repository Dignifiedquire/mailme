//
//  MailViewController.swift
//  MailMe
//
//  Created by Friedel Ziegelmayer on 02/11/14.
//  Copyright (c) 2014 Friedel Ziegelmayer. All rights reserved.
//

import Cocoa

class MailViewController: NSViewController {

    @IBOutlet weak var textOutput: NSTextField!
    
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

            var content = ""
            
            for message in fetchedMessages {

                let header = message.header as MCOMessageHeader
                println(header.from.nonEncodedRFC822String())
                
                content += "from: \(header.from.nonEncodedRFC822String())\n"

                var recipients = "to: "
                for recipient in header.to {
                    recipients += "\(recipient.nonEncodedRFC822String()), "
                }

                content += "\(recipients)\n"
                content += "re: \(header.subject)\n"
                content += "\n---\n"
            }
            
            self.textOutput.stringValue += content
            
        }
        
    }
    
}
