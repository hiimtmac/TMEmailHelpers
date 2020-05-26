//
//  MimeType.swift
//  SwiftyMimes
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import Foundation

public enum FileType: Equatable, Hashable {
    case pdf
    case json
    case csv
    case html
    case txt
    case other(mime: String, ext: String)
    
    public var fileExtension: String {
        switch self {
        case .pdf: return "pdf"
        case .json: return "json"
        case .csv: return "csv"
        case .html: return "html"
        case .txt: return "txt"
        case .other(_, let ext): return ext
        }
    }
    
    public var mimeType: String {
        switch self {
        case .pdf: return "application/pdf"
        case .json: return "application/json"
        case .csv: return "text/csv"
        case .html: return "text/html"
        case .txt: return "text/txt"
        case .other(let mime, _): return mime
        }
    }
}
