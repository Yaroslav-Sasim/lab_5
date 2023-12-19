import 'dart:convert';
import 'dart:ui';

class Note {
  String title;
  String content;
  String lastEdited;
  Color color;

  Note({
    required this.title,
    required this.content,
    required this.lastEdited,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'lastEdited': lastEdited,
      'color': color.value,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      content: map['content'],
      lastEdited: map['lastEdited'],
      color: Color(map['color']),
    );
  }

  static String listToJson(List<Note> notes) {
    final List<Map<String, dynamic>> noteList =
    notes.map((note) => note.toMap()).toList();
    return jsonEncode(noteList);
  }

  static List<Note> listFromJson(String jsonString) {
    final List<dynamic> noteList = jsonDecode(jsonString);
    return noteList.map((map) => Note.fromMap(map)).toList();
  }
}
