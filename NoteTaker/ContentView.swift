import SwiftUI

struct ContentView: View {
    @StateObject private var noteStore = NoteStore()
    @State private var searchText = ""
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return noteStore.notes
        } else {
            return noteStore.notes.filter { note in
                note.title.lowercased().contains(searchText.lowercased()) ||
                note.content.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredNotes) { note in
                    NavigationLink(destination: NoteEditView(note: note, noteStore: noteStore)) {
                        NoteRowView(note: note)
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, prompt: "Search notes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        noteStore.addNote()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func deleteNotes(offsets: IndexSet) {
        noteStore.deleteNote(at: offsets)
    }
}
