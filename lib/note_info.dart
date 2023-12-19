import 'package:flutter/material.dart';

import 'custom.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;
  final Function(Note) onSave;

  NoteDetailScreen({required this.note, required this.onSave});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  bool isEditing = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Описание"),
        actions: [
          if (isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final updatedNote = Note(
                  title: titleController.text,
                  content: contentController.text,
                  lastEdited: widget.note.lastEdited,
                  color: widget.note.color,
                );
                widget.onSave(updatedNote);
                setState(() {
                  isEditing = false;
                });
              },
            )
          else
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? '' : widget.note.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              isEditing ? '' : widget.note.lastEdited,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            if (isEditing)
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Название'),
              )
            else
              SizedBox.shrink(),
            if (isEditing)
              TextField(
                controller: contentController,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Описание'),
              )
            else
              Text(
                isEditing ? '' : widget.note.content,
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}