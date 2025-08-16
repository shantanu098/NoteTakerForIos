import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var createdDate: Date
    var modifiedDate: Date

    init(title: String = "New Note", content: String = "") {
        self.id = UUID()
        self.title = title
        self.content = content
        self.createdDate = Date()
        self.modifiedDate = Date()
    }
}

