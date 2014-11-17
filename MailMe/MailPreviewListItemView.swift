//
//  MailPreviewListItemView.swift
//  MailMe
//
//  Created by Friedel Ziegelmayer on 17/11/14.
//  Copyright (c) 2014 Friedel Ziegelmayer. All rights reserved.
//

import Cocoa

class MailPreviewListItemView: NSView {

    
    @IBOutlet weak var senderLabel: NSTextField!
    @IBOutlet weak var subjectLabel: NSTextField!
    @IBOutlet weak var previewLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
