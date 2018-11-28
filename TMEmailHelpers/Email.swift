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
    
    public mutating func addToEmail(_ address: EmailAddress?) {
        if let address = address {
            to.insert(address)
        }
    }
    
    public mutating func addCcEmail(_ address: EmailAddress?) {
        if let address = address {
            cc.insert(address)
        }
    }
    
    public mutating func addBccEmail(_ address: EmailAddress?) {
        if let address = address {
            bcc.insert(address)
        }
    }
    
    public mutating func addAttachment(_ attachment: EmailAttachment) {
        attachments.insert(attachment)
    }
    
    var validTo: [EmailAddress] {
        return to.compactMap { validatedEmail($0) }
    }
    
    var validCc: [EmailAddress] {
        return cc.compactMap { validatedEmail($0) }
    }
    
    var validBcc: [EmailAddress] {
        return bcc.compactMap { validatedEmail($0) }
    }
    
    func validatedEmail(_ email: EmailAddress) -> EmailAddress? {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailPredicate.evaluate(with: trimmedEmail) {
            return trimmedEmail
        } else {
            return nil
        }
    }
}
