//
//  EmailPresenting.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import Foundation
import MessageUI

public protocol EmailPresenting: AnyObject {
    
}

extension EmailPresenting where Self: UIViewController & MFMailComposeViewControllerDelegate {
    
    public func presentEmail(_ email: Email) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            
            mail.setSubject(email.subject)
            mail.setToRecipients(email.validTo)
            mail.setCcRecipients(email.validCc)
            mail.setBccRecipients(email.validBcc)
            
            mail.setMessageBody(email.body, isHTML: email.isHTML)
            
            email.attachments.forEach { attachment in
                mail.addAttachmentData(attachment.data, mimeType: attachment.fileType.mimeType, fileName: "\(attachment.name).\(attachment.fileType.fileExtension)")
            }
            
            mail.mailComposeDelegate = self
            
            present(mail, animated: true, completion: nil)
        } else {
            let message = """
            In order to for this application to create emails, you must have at least one account setup in the Mail.app system application.
            """
            let ac = UIAlertController(title: "Unable to Create Email", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
}
