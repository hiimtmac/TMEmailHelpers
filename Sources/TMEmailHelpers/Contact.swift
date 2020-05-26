//
//  Contact.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2019-01-25.
//  Copyright © 2019 hiimtmac. All rights reserved.
//

import Foundation

public struct Contact: Codable, Hashable {
    public typealias EmailAddress = String

    public let name: String?
    public let email: EmailAddress
    
    public init?(email: EmailAddress?, name: String? = nil) {
        guard let email = email else { return nil }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailPredicate.evaluate(with: trimmedEmail) {
            self.name = name
            self.email = email
        } else {
            return nil
        }
    }
}
