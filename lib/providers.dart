import 'package:new_project/data/note_manager.dart';

NoteManager? _noteManager;

NoteManager noteManager() {
  _noteManager ??= NoteManager();
  return _noteManager!;
}
