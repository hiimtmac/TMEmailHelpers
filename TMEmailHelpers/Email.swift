//
//  TMEmail.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import UIKit
import MessageUI

public typealias EmailAddress = String

public struct Email {
    let subject: String
    let body: String
    let isHTML: Bool
    var to: Set<EmailAddress>
    var cc: Set<EmailAddress>
    var bcc: Set<EmailAddress>
    var attachments: Set<EmailAttachment>
    
    public init(subject: String, body: String, isHTML: Bool = false, to: [EmailAddress] = [], cc: [EmailAddress] = [], bcc: [EmailAddress] = [], attachments: [EmailAttachment] = []) {
        self.subject = subject
        self.body = body
        self.isHTML = isHTML
        self.to = Set(to)
        self.cc = Set(cc)
        self.bcc = Set(bcc)
        self.attachments = Set(attachments)
    }
    
    public mutating func addToEmail(_ address: EmailAddress) {
        if let valid = validatedEmail(address) {
            to.insert(valid)
        }
    }
    
    public mutating func addCcEmail(_ address: EmailAddress) {
        if let valid = validatedEmail(address) {
            cc.insert(valid)
        }
    }
    
    public mutating func addBccEmail(_ address: EmailAddress) {
        if let valid = validatedEmail(address) {
            bcc.insert(valid)
        }
    }
    
    public mutating func addAttachment(_ attachment: EmailAttachment) {
        attachments.insert(attachment)
    }
    
    public func createMailController() -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        
        mail.setSubject(subject)
        mail.setToRecipients(to.compactMap { validatedEmail($0) })
        mail.setCcRecipients(cc.compactMap { validatedEmail($0) })
        mail.setBccRecipients(bcc.compactMap { validatedEmail($0) })
        
        mail.setMessageBody(body, isHTML: isHTML)
        
        attachments.forEach { attachment in
            mail.addAttachmentData(attachment.data, mimeType: attachment.mimeType.mimeType, fileName: attachment.name)
        }
        
        return mail
    }
    
    func validatedEmail(_ email: EmailAddress) -> EmailAddress? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailPredicate.evaluate(with: email) {
            return email
        } else {
            return nil
        }
    }
}
