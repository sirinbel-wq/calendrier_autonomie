import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/day_note.dart';
import '../utils/storage_service.dart';

class DayNotesPage extends StatefulWidget {
  final DateTime date;
  const DayNotesPage({super.key, required this.date});

  @override
  State<DayNotesPage> createState() => _DayNotesPageState();
}

class _DayNotesPageState extends State<DayNotesPage> {
  final TextEditingController _controller = TextEditingController();
  List<DayNote> _dayNotes = [];
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _dayNotes = StorageService.getDayNotes(widget.date);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImagePath = picked.path;
      });
    }
  }

  void saveNote() {
    if (_controller.text.isEmpty && _selectedImagePath == null) return;

    final newNote = DayNote(
      date: widget.date,
      text: _controller.text,
      imagePath: _selectedImagePath,
    );

    StorageService.saveDayNote(newNote);

    setState(() {
      _dayNotes.add(newNote);
      _controller.clear();
      _selectedImagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes du ${widget.date.day}/${widget.date.month}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Ajouter une note'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Ajouter une photo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveNote,
              child: const Text('Enregistrer note'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _dayNotes.length,
                itemBuilder: (context, index) {
                  final n = _dayNotes[index];
                  return Card(
                    child: ListTile(
                      title: Text(n.text),
                      subtitle: n.imagePath != null ? Image.file(File(n.imagePath!)) : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}