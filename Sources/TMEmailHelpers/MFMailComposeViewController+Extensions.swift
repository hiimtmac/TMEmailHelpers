import Foundation
import MessageUI

extension MFMailComposeViewController {
    public func setToContacts(_ contacts: Set<Contact>) {
        setToRecipients(contacts.map(\.email))
    }
    
    public func setCcContacts(_ contacts: Set<Contact>) {
        setCcRecipients(contacts.map(\.email))
    }
    
    public func setBccContacts(_ contacts: Set<Contact>) {
        setBccRecipients(contacts.map(\.email))
    }
    
    public func setAttachments(_ attachments: Set<EmailAttachment>) {
        attachments.forEach { attachment in
            addAttachmentData(attachment.data, mimeType: attachment.fileType.mimeType, fileName: "\(attachment.name).\(attachment.fileType.fileExtension)")
        }
    }
}
