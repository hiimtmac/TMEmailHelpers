//
//  SendInBlue.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2019-01-25.
//  Copyright © 2019 hiimtmac. All rights reserved.
//

import Foundation
import Requester

public struct SendInBlue: Encodable {
    static let url = URL(string: "https://api.sendinblue.com/v3/smtp/email")!
    
    let sender: Contact
    let email: Email
    let replyTo: Contact
    let headers: [HTTPHeader]?
    let tags: [String]?
    
    public init(email: Email, sender: Contact, replyTo: Contact, headers: [HTTPHeader]?, tags: [String]?) {
        self.email = email
        self.sender = sender
        self.replyTo = replyTo
        self.headers = headers
        self.tags = tags
    }
    
    enum CodingKeys: String, CodingKey {
        case sender
        case to
        case bcc
        case cc
        case htmlContent
        case textContent
        case subject
        case replyTo
        case attachment
        case headers
        case tags
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sender, forKey: .sender)
        
        try container.encode(Array(email.to), forKey: .to)
        
        if !email.cc.isEmpty {
            try container.encode(Array(email.cc), forKey: .cc)
        }
        
        if !email.bcc.isEmpty {
            try container.encode(Array(email.bcc), forKey: .bcc)
        }
        
        if email.isHTML {
            try container.encode(SIBContentType.html(email.body), forKey: .htmlContent)
        } else {
            try container.encode(SIBContentType.text(email.body), forKey: .textContent)
        }
        
        try container.encode(email.subject, forKey: .subject)
        try container.encode(replyTo, forKey: .replyTo)
        
        let attachments = email.attachments.map { SIBAttachment(content: .base64($0.data), name: $0.name) }
        try container.encode(attachments, forKey: .attachment)
        
        if let headers = headers {
            var headerDict = [String: String]()
            for header in headers {
                headerDict[header.headerField] = header.headerValue
            }
            var headContainer = container.nestedUnkeyedContainer(forKey: .headers)
            try headContainer.encode(headerDict)
        }

        try container.encodeIfPresent(tags, forKey: .tags)
    }
}

enum SIBContentType: Encodable {
    case text(String)
    case html(String)
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .text(let val), .html(let val):
            try container.encode(val)
        }
    }
}

struct SIBAttachment: Encodable {
    let content: SIBAttachmentContent
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case content
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch content {
        case .url:
            try container.encode(content, forKey: .url)
        case .base64:
            try container.encode(content, forKey: .content)
        }
    }
    
    enum SIBAttachmentContent: Encodable {
        case url(URL)
        case base64(Data)
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .url(let url):
                try container.encode(url.absoluteString)
            case .base64(let data):
                let encoded = data.base64EncodedString()
                try container.encode(encoded)
            }
        }
    }
}
