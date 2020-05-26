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
