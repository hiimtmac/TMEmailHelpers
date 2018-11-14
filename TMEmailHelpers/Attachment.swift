//
//  Attachment.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import Foundation
import SwiftyMimes

public struct EmailAttachment {
    let name: String
    let mimeType: MimeType
    let data: Data
    
    public init(name: String, mimeType: MimeType, data: Data) {
        self.name = name
        self.mimeType = mimeType
        self.data = data
    }
}

extension EmailAttachment: Equatable, Hashable {
    public static func == (lhs: EmailAttachment, rhs: EmailAttachment) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.mimeType.mimeType == rhs.mimeType.mimeType &&
            lhs.data == rhs.data
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(mimeType.mimeType)
        hasher.combine(data)
    }
}
