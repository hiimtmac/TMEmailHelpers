//
//  SendInBlueTests.swift
//  TMEmailHelpersTests
//
//  Created by Taylor McIntyre on 2019-01-25.
//  Copyright © 2019 hiimtmac. All rights reserved.
//

import XCTest
import Requester
@testable import TMEmailHelpers

class SendInBlueTests: XCTestCase {

    func testBasicEmail() throws {
        let sender = try Contact(throwingEmail: "taylor@hiimtmac.com")
        
        let attachments = [EmailAttachment(name: "test", fileType: .pdf, data: "hello".data(using: .utf8)!)]
        
        let email = Email(subject: "Hello there!",
                      body: "This is the body",
                      isHTML: false,
                      toContacts: [sender],
                      attachments: attachments)
        
        let sib = SendInBlue(email: email, sender: sender, replyTo: sender, headers: [], tags: [])
        let data = try JSONEncoder().encode(sib)
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        let jSender = json?["sender"] as? [String: String]
        XCTAssertEqual(jSender?["email"], "taylor@hiimtmac.com")
        
        let jContent = json?["textContent"] as? String
        XCTAssertEqual(jContent, "This is the body")
        
        let jReply = json?["replyTo"] as? [String: String]
        XCTAssertEqual(jReply?["email"], "taylor@hiimtmac.com")
        
        let jTo = json?["to"] as? [[String: String]]
        XCTAssertEqual(jTo?.first?["email"], "taylor@hiimtmac.com")
        
        let jAttachment = json?["attachment"] as? [[String: String]]
        XCTAssertEqual(jAttachment?.first?["content"], "aGVsbG8=")
        XCTAssertEqual(jAttachment?.first?["name"], "test")

    }
    
    func testAdvancedEmail() throws {
        let sender = try Contact(throwingEmail: "taylor@hiimtmac.com")
        let receiver = try Contact(throwingEmail: "tmac@hiimtmac.com")
        
        let attachments = [
            EmailAttachment(name: "pdf", fileType: .pdf, data: "pdf".data(using: .utf8)!),
            EmailAttachment(name: "csv", fileType: .csv, data: "csv".data(using: .utf8)!)
        ]
        
        let email = Email(subject: "Hello there!",
                          body: "This is the body",
                          isHTML: false,
                          toContacts: [sender, receiver],
                          attachments: attachments)
        
        let sib = SendInBlue(email: email, sender: sender, replyTo: receiver, headers: [.contentType(.pdf)], tags: ["ios"])
        let data = try JSONEncoder().encode(sib)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        let jSender = json?["sender"] as? [String: String]
        XCTAssertEqual(jSender?["email"], "taylor@hiimtmac.com")
        
        let jContent = json?["textContent"] as? String
        XCTAssertEqual(jContent, "This is the body")
        
        let jReply = json?["replyTo"] as? [String: String]
        XCTAssertEqual(jReply?["email"], "tmac@hiimtmac.com")
        
        let jTo = json?["to"] as? [[String: String]]
        XCTAssertEqual(jTo?.count, 2)
        
        let jAttachment = json?["attachment"] as? [[String: String]]
        XCTAssertEqual(jAttachment?.count, 2)
        
        let jHeader = json?["headers"] as? [[String: String]]
        XCTAssertEqual(jHeader?.first?["Content-Type"], "application/pdf")
        
        let jTag = json?["tags"] as? [String]
        XCTAssertEqual(jTag?.first, "ios")
    }
    
    func testReal() throws {
//        let arc = try Contact(throwingEmail: "no-reply@voltagepower.ca", name: "ARC")
//        let email = Email(subject: "hello there", body: "this is a test", toAddresses: ["EMAIL"])
//        let send = SendInBlue(email: email, sender: arc, replyTo: arc, headers: nil, tags: ["ios", "test"])
//
//        struct Response: Decodable {
//            let messageId: String
//        }
//
//        let headers: [HTTPHeader] = [.contentType(.json), .custom("api-key", "API")]
//        let request = try Request(url: SendInBlue.url, method: .post(send), headers: headers, returning: Response.self)
//
//        let exp = expectation(description: "web")
//
//        Webservice().network(request: request) { result in
//            switch result {
//            case .success(let data):
//                print(String(data: data, encoding: .utf8)!)
//            case .error(let err):
//                print(err)
//                XCTFail()
//            }
//
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 5)
    }
}
