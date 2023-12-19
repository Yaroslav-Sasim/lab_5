import 'package:flutter/material.dart';
import 'custom.dart';
import 'list_screen.dart';
import 'note_info.dart';
import 'create_note.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() {
    try {
      File file = File('notes.json');
      if (file.existsSync()) {
        String noteData = file.readAsStringSync();
        setState(() {
          notes = Note.listFromJson(noteData);
        });
      }
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  void saveNotes() {
    try {
      File file = File('notes.json');
      file.writeAsStringSync(Note.listToJson(notes));
    } catch (e) {
      print('Error saving notes: $e');
    }
  }

  void addNewNote(Note newNote) {
    setState(() {
      notes.add(newNote);
      saveNotes();
    });
  }

  void updateExistingNote(int index, Note updatedNote) {
    setState(() {
      notes[index] = updatedNote;
      saveNotes();
    });
  }

  void deleteNote(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Удалить заметку?'),
          content: Text('Вы уверены, что хотите удалить эту заметку?'),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                setState(() {
                  notes.removeAt(index);
                  saveNotes();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NotesListScreen(
          notes: notes,
          onDelete: deleteNote,
        ),
        '/note_detail': (context) {
          final noteIndex = ModalRoute.of(context)!.settings.arguments as int;
          return NoteDetailScreen(
            note: notes[noteIndex],
            onSave: (updatedNote) {
              updateExistingNote(noteIndex, updatedNote);
            },
          );
        },
        '/create_note': (context) => CreateNoteScreen(
          onSave: (newNote) {
            addNewNote(newNote);
            Navigator.pop(context);
          },
        ),
      },
    );
  }
}
