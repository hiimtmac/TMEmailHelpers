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
    let fileType: FileType
    let data: Data
    
    public init(name: String, fileType: FileType, data: Data) {
        self.name = name
        self.fileType = fileType
        self.data = data
    }
}

extension EmailAttachment: Equatable, Hashable {
    public static func == (lhs: EmailAttachment, rhs: EmailAttachment) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.fileType.mimeType == rhs.fileType.mimeType &&
            lhs.data == rhs.data
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(fileType.mimeType)
        hasher.combine(data)
    }
}
