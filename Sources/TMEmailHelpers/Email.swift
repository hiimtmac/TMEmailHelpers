import Foundation

public struct Email {
    public let subject: String
    public let body: String
    public let isHTML: Bool
    public var to: Set<Contact>
    public var cc: Set<Contact>
    public var bcc: Set<Contact>
    public var attachments: Set<EmailAttachment>
    
    public init(subject: String,
                body: String,
                isHTML: Bool = false,
                toContacts: [Contact],
                ccContacts: [Contact] = [],
                bccContacts: [Contact] = [],
                attachments: [EmailAttachment] = []) {
        self.subject = subject
        self.body = body
        self.isHTML = isHTML
        self.to = Set(toContacts)
        self.cc = Set(ccContacts)
        self.bcc = Set(bccContacts)
        self.attachments = Set(attachments)
    }
    
    public init(subject: String,
                body: String,
                isHTML: Bool = false,
                toAddresses: [Contact.EmailAddress],
                ccAddresses: [Contact.EmailAddress] = [],
                bccAddresses: [Contact.EmailAddress] = [],
                attachments: [EmailAttachment] = []) {
        self.subject = subject
        self.body = body
        self.isHTML = isHTML
        self.to = Set(toAddresses.compactMap({ Contact(email: $0) }))
        self.cc = Set(ccAddresses.compactMap({ Contact(email: $0) }))
        self.bcc = Set(bccAddresses.compactMap({ Contact(email: $0) }))
        self.attachments = Set(attachments)
    }
    
    public mutating func addToEmail(_ address: Contact.EmailAddress?) {
        if let contact = Contact(email: address) {
            to.insert(contact)
        }
    }
    
    public mutating func addCcEmail(_ address: Contact.EmailAddress?) {
        if let contact = Contact(email: address) {
            cc.insert(contact)
        }
    }
    
    public mutating func addBccEmail(_ address: Contact.EmailAddress?) {
        if let contact = Contact(email: address) {
            bcc.insert(contact)
        }
    }
    
    public mutating func addToContact(_ contact: Contact?) {
        if let contact = contact {
            to.insert(contact)
        }
    }
    
    public mutating func addCcContact(_ contact: Contact?) {
        if let contact = contact {
            cc.insert(contact)
        }
    }
    
    public mutating func addBccContact(_ contact: Contact?) {
        if let contact = contact {
            bcc.insert(contact)
        }
    }
    
    public mutating func addAttachment(_ attachment: EmailAttachment) {
        attachments.insert(attachment)
    }
}
