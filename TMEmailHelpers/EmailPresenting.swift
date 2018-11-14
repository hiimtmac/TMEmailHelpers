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

extension EmailPresenting where Self: UIViewController {
    
    public func presentEmail(_ controller: MFMailComposeViewController) {
        if MFMailComposeViewController.canSendMail() {
            present(controller, animated: true, completion: nil)
        } else {
            let message = """
            In order to for this application to create emails on your behalf, you must have at least one account setup for the Mail.app system application.
            """
            let ac = UIAlertController(title: "Unable to Send Email", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
}

