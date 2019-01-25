//
//  MFMailComposeViewController+Extensions.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2019-01-25.
//  Copyright © 2019 hiimtmac. All rights reserved.
//

import Foundation
import MessageUI

extension MFMailComposeViewController {
    public func setToContacts(_ contacts: Set<Contact>) {
        setToRecipients(contacts.map { $0.email })
    }
    
    public func setCcContacts(_ contacts: Set<Contact>) {
        setCcRecipients(contacts.map { $0.email })
    }
    
    public func setBccContacts(_ contacts: Set<Contact>) {
        setBccRecipients(contacts.map { $0.email })
    }
    
    public func setAttachments(_ attachments: Set<EmailAttachment>) {
        attachments.forEach { attachment in
            addAttachmentData(attachment.data, mimeType: attachment.fileType.mimeType, fileName: "\(attachment.name).\(attachment.fileType.fileExtension)")
        }
    }
}
