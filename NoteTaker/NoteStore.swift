import Foundation

class NoteStore: ObservableObject {
    @Published var notes: [Note] = []
    
    private let userDefaults = UserDefaults.standard
    private let notesKey = "SavedNotes"
    
    init() {
        loadNotes()
    }
    
    func addNote() {
        let newNote = Note()
        notes.insert(newNote, at: 0)
        saveNotes()
    }
    
    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
        saveNotes()
    }
    
    func updateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = note.title
            notes[index].content = note.content
            notes[index].modifiedDate = Date()
            saveNotes()
        }
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: notesKey)
        }
    }
    
    private func loadNotes() {
        if let data = userDefaults.data(forKey: notesKey),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decodedNotes
        }
    }
}
