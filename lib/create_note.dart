import 'package:flutter/material.dart';
import 'dart:math';
import 'custom.dart';

class CreateNoteScreen extends StatefulWidget {
  final Function(Note) onSave;

  CreateNoteScreen({required this.onSave});

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создать"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final newNote = Note(
                title: titleController.text,
                content: contentController.text,
                lastEdited: DateTime.now().toString(),
                color: Color.fromRGBO(
                  200 + random.nextInt(56),
                  200 + random.nextInt(56),
                  200 + random.nextInt(56),
                  1.0,
                ),
              );
              widget.onSave(newNote);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: InputDecoration(labelText: 'Описание'),
            ),
          ],
        ),
      ),
    );
  }
}
