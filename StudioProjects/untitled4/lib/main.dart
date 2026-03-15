import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.yellow[50],
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const NotesPage(),
    );
  }
}

abstract class Note {
  String title;
  String content;

  Note(this.title, this.content);

  String getDescription();
}

class TextNote extends Note {
  TextNote(String title, String content) : super(title, content);

  @override
  String getDescription() {
    return "Note: $title";
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  Future<void> addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNotePage()),
    );

    if (result != null) {
      setState(() {
        notes.add(TextNote(result['title'], result['content']));
      });
    }
  }

  Future<void> editNote(int index) async {
    Note note = notes[index];

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage(note: note)),
    );

    if (result != null) {
      setState(() {
        notes[index].title = result['title'];
        notes[index].content = result['content'];
      });
    }
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        backgroundColor: Colors.amber[300],
        centerTitle: true,
        elevation: 2,
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet.\nTap + to add a note!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note note = notes[index];

                return Card(
                  color: Colors.yellow[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        note.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    onTap: () => editNote(index),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        deleteNote(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.amber[300],
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({super.key, this.note});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.note != null ? widget.note!.title : '',
    );
    contentController = TextEditingController(
      text: widget.note != null ? widget.note!.content : '',
    );
  }

  void saveNote() {
    if (titleController.text.isEmpty && contentController.text.isEmpty) return;

    Navigator.pop(context, {
      'title': titleController.text,
      'content': contentController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Note" : "New Note"),
        backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Text"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[200],
              ),
              child: Text(widget.note != null ? "Save Changes" : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
