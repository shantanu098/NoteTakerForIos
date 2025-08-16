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
            ZStack {
                Color.black
                    .ignoresSafeArea() // Full screen black background
                
                List {
                    ForEach(filteredNotes) { note in
                        NavigationLink(destination: NoteEditView(note: note, noteStore: noteStore)) {
                            NoteRowView(note: note)
                                .foregroundColor(.white) // White text for readability
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
                .background(Color.clear) // Transparent to show black background
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, prompt: "Search Your Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        noteStore.addNote()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white) // Plus button in white
                    }
                }
            }
        }
    }

    private func deleteNotes(at offsets: IndexSet) {
        noteStore.deleteNote(at: offsets)
    }
}

