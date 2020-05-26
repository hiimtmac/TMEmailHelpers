//
//  Attachment.swift
//  TMEmailHelpers
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import Foundation

public struct EmailAttachment: Equatable, Hashable {
    let name: String
    let fileType: FileType
    let data: Data
    
    public init(name: String, fileType: FileType, data: Data) {
        self.name = name
        self.fileType = fileType
        self.data = data
    }
}
