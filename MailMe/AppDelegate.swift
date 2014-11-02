//
//  AppDelegate.swift
//  MailMe
//
//  Created by Friedel Ziegelmayer on 02/11/14.
//  Copyright (c) 2014 Friedel Ziegelmayer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let session = MCOIMAPSession()
        session.hostname = "imap.gmail.com"
        session.port = 993
        session.username = "friedel.ziegelmayer@gmail.com"
        session.password = "mygooglemail33"
        session.connectionType = MCOConnectionType.TLS
        
        let requestKind = MCOIMAPMessagesRequestKind.Headers
        let folder = "INBOX"
        let uids = MCOIndexSet(range: MCORangeMake(1, UINT64_MAX))
        
        let fetchOperation = session.fetchMessagesOperationWithFolder(folder, requestKind: requestKind, uids: uids)
        
        fetchOperation.start { (error, fetchedMessages, vanishedMessages) -> Void in
            if ((error) != nil) {
                println("Error downloading message headers: \(error)")
            }
            println("The post man delivereth: \(fetchedMessages)")
        }
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

