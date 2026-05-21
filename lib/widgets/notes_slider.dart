import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/notes_model.dart';

class NotesSlider extends StatefulWidget {

  final int pageNumber;
  final bool isTestMode;

  const NotesSlider({
    super.key,
    required this.pageNumber,
    required this.isTestMode,
  });

  @override
  State<NotesSlider> createState() =>
      _NotesSliderState();
}

class _NotesSliderState
    extends State<NotesSlider> {
  late final TextEditingController notesController;
  @override
  void initState() {
    super.initState();

    notesController =
        TextEditingController();
    loadNotes();
  }
  @override
  void didUpdateWidget(covariant NotesSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pageNumber != widget.pageNumber ||
        oldWidget.isTestMode != widget.isTestMode) {

      loadNotes();
    }
  }

  void loadNotes() {
    print("LOADING PAGE: ${widget.pageNumber}");
    final box =
    Hive.box<NoteModel>('notesBox');

    final note =
    box.get(widget.pageNumber);

    if (note != null) {

      if (widget.isTestMode) {

        notesController.text =
            note.testModeNotes;

      } else {

        notesController.text =
            note.memorizationNotes;
      }

    } else {

      notesController.clear();

    }
  }
  void saveNotes() {
    print("SAVING PAGE: ${widget.pageNumber}");
    final box =
    Hive.box<NoteModel>('notesBox');

    NoteModel? note =
    box.get(widget.pageNumber);

    note ??= NoteModel(
      pageNumber: widget.pageNumber,
    );

    if (widget.isTestMode) {

      note.testModeNotes =
          notesController.text;

    } else {

      note.memorizationNotes =
          notesController.text;
    }

    box.put(widget.pageNumber, note);
  }
  @override
  void dispose() {

    notesController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      color: Colors.white,

      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  widget.isTestMode
                      ? 'Test Notes'
                      : 'Memorization Notes',

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: saveNotes,

                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),

              child: TextField(
                controller: notesController,

                expands: false,
                maxLines: null,

                decoration:
                const InputDecoration(
                  border:
                  OutlineInputBorder(),

                  hintText:
                  'Write your notes...',
                ),
              ),
            ),
        ],
      ),
    );

  }
}