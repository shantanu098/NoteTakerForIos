import SwiftUI

struct NoteEditView: View {
    @State var note: Note
    let noteStore: NoteStore
    @Environment(\.presentationMode) var presentationMode
    @State private var noteTitle: String
    @State private var noteContent: String
    
    init(note: Note, noteStore: NoteStore) {
        self.note = note
        self.noteStore = noteStore
        self._noteTitle = State(initialValue: note.title)
        self._noteContent = State(initialValue: note.content)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Title", text: $noteTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color(.systemGray6))
                
                TextEditor(text: $noteContent)
                    .padding()
                    .background(Color(.systemBackground))
            }
            .navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
    
    private func saveNote() {
        note.title = noteTitle
        note.content = noteContent
        noteStore.updateNote(note)
    }
}
