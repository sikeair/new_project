import 'package:flutter/material.dart';
import 'package:new_project/data/note.dart';
import 'package:new_project/providers.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key, this.index});

  static const routeName = '/edit';

  final int? index;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  Color color = Note.colorDefault;

  @override
  void initState() {
    super.initState();
    final noteIndex = widget.index;
    if (noteIndex != null) {
      final note = noteManager().getNote(noteIndex);
      titleController.text = note.title;
      bodyController.text = note.body;
      color = note.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('노트 편집'),
        actions: [
          IconButton(
            onPressed: _displayColorSelectionDialog,
            icon: const Icon(Icons.color_lens),
            tooltip: '배경색 선택',
          ),
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.save),
            tooltip: '저장',
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: color,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '제목 입력',
                  ),
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '노트 입력',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('배경색 선택'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('없음'),
                  onTap: () => _applyColor(Note.colorDefault),
                ),
                ListTile(
                  leading: const CircleAvatar(backgroundColor: Note.colorRed),
                  title: const Text('빨간색'),
                  onTap: () => _applyColor(Note.colorRed),
                ),
                ListTile(
                  leading:
                      const CircleAvatar(backgroundColor: Note.colorOrange),
                  title: const Text('오렌지'),
                  onTap: () => _applyColor(Note.colorOrange),
                ),
                ListTile(
                  leading:
                      const CircleAvatar(backgroundColor: Note.colorYellow),
                  title: const Text('노란색'),
                  onTap: () => _applyColor(Note.colorYellow),
                ),
                ListTile(
                  leading: const CircleAvatar(backgroundColor: Note.colorLime),
                  title: const Text('연두색'),
                  onTap: () => _applyColor(Note.colorLime),
                ),
                ListTile(
                  leading: const CircleAvatar(backgroundColor: Note.colorBlue),
                  title: const Text('파란색'),
                  onTap: () => _applyColor(Note.colorBlue),
                ),
              ],
            ),
          );
        });
  }

  void _applyColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      color = newColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {
      noteManager().addNote(
        Note(
          bodyController.text,
          color: color,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('노트를 입력하세요.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
