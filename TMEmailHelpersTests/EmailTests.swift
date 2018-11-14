//
//  EmailTests.swift
//  TMEmailHelpersTests
//
//  Created by Taylor McIntyre on 2018-11-14.
//  Copyright © 2018 hiimtmac. All rights reserved.
//

import XCTest
@testable import TMEmailHelpers

class EmailTests: XCTestCase {

    func testTo() {
        var email = Email(subject: "Hello", body: "This is an email", to: ["test@hiimtmac.com"])
        email.addToEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.to.count, 2)
        email.addToEmail("tmcintyre@v")
        XCTAssertEqual(email.to.count, 2)
        email.addToEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.to.count, 2)
        email.addToEmail("hiimtmac@hiimtmac.ca")
        XCTAssertEqual(email.to.count, 3)
    }
    
    func testCc() {
        var email = Email(subject: "Hello", body: "This is an email", to: ["test@hiimtmac.com"])
        XCTAssertEqual(email.to.count, 1)
        email.addCcEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.cc.count, 1)
        email.addCcEmail("tmcintyre@v")
        XCTAssertEqual(email.cc.count, 1)
        email.addCcEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.cc.count, 1)
        email.addCcEmail("hiimtmac@hiimtmac.ca")
        XCTAssertEqual(email.cc.count, 2)
    }
    
    func testBcc() {
        var email = Email(subject: "Hello", body: "This is an email", to: ["test@hiimtmac.com"])
        XCTAssertEqual(email.to.count, 1)
        email.addBccEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.bcc.count, 1)
        email.addBccEmail("tmcintyre@v")
        XCTAssertEqual(email.bcc.count, 1)
        email.addBccEmail("tmcintyre@hiimtmac.ca")
        XCTAssertEqual(email.bcc.count, 1)
        email.addBccEmail("hiimtmac@hiimtmac.ca")
        XCTAssertEqual(email.bcc.count, 2)
    }
    
    func testAttachments() {
        let a1 = EmailAttachment(name: "hi", mimeType: .pdf, data: "hello".data(using: .utf8)!)
        let a2 = EmailAttachment(name: "hi", mimeType: .json, data: "hello".data(using: .utf8)!)
        let a3 = EmailAttachment(name: "hi", mimeType: .pdf, data: "hello".data(using: .utf8)!)
        let a4 = EmailAttachment(name: "hi", mimeType: .pdf, data: "hi there".data(using: .utf8)!)
        let a5 = EmailAttachment(name: "great", mimeType: .pdf, data: "hello".data(using: .utf8)!)
        
        var email = Email(subject: "attachments", body: "chaff", attachments: [a1, a2, a3])
        XCTAssertEqual(email.attachments.count, 2)
        email.addAttachment(a4)
        XCTAssertEqual(email.attachments.count, 3)
        email.addAttachment(a5)
        XCTAssertEqual(email.attachments.count, 4)
    }
}
