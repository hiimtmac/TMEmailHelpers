import MessageUI

public protocol EmailPresenting: AnyObject {
    func style(_ controller: MFMailComposeViewController)
}

extension EmailPresenting {
    public func style(_ controller: MFMailComposeViewController) {
        
    }
}

extension EmailPresenting where Self: UIViewController & MFMailComposeViewControllerDelegate {
    public func presentEmail(_ email: Email) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            
            style(mail)
            
            mail.setSubject(email.subject)
            mail.setToContacts(email.to)
            mail.setCcContacts(email.cc)
            mail.setBccContacts(email.bcc)
            mail.setMessageBody(email.body, isHTML: email.isHTML)
            mail.setAttachments(email.attachments)
            
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
