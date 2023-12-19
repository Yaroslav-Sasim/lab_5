import 'package:flutter/material.dart';
import 'custom.dart';

class NotesListScreen extends StatefulWidget {
  final List<Note> notes;
  final Function(int) onDelete;

  NotesListScreen({required this.notes, required this.onDelete});

  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Записки"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Обработчик для начала поиска
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          final note = widget.notes[index];
          final isSquare = (index % 2 == 0);

          return Card(
            color: note.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/note_detail', arguments: index);
              },
              onLongPress: () {
                _showDeleteDialog(context, index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      note.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      note.content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _formatDate(note.lastEdited),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_note');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Удалить заметку?"),
          content: Text("Вы уверены, что хотите удалить эту заметку?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Удаление заметки из списка
                setState(() {
                  widget.notes.removeAt(index);
                });
                // Вызов onDelete, чтобы также удалить заметку из хранилища
                widget.onDelete(index);
              },
              child: Text("Удалить"),
            ),
          ],
        );
      },
    );
  }
}
