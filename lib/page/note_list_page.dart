import 'package:flutter/material.dart';
import 'package:new_project/data/note.dart';
import 'package:new_project/page/note_edit_page.dart';
import 'package:new_project/providers.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  static const routeName = '/';

  @override
  State createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky Notes'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        children: _buildCards(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '새 노트',
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then(
            (_) {
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildCards() {
    return noteManager().listNotes().map((note) => _buildCard(note)).toList();
  }

  Widget _buildCard(Note note) {
    return Card(
      color: note.color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.isEmpty ? '(제목없음)' : note.title,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Text(
                note.body,
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }
}
