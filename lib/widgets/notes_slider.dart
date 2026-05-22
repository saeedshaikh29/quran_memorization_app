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
  bool isViewingTestNotes = false;
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
        oldWidget.isTestMode != isViewingTestNotes) {

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

      if (isViewingTestNotes) {

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

    if (isViewingTestNotes) {

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
      width: 320,

      decoration: BoxDecoration(
        color: const Color(0xFFF8F5EE),

        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(24),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),

      child: SafeArea(
        child: Column(
          children: [

            // HEADER
            Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  Text(
                    isViewingTestNotes
                        ? 'Test Notes'
                        : 'Memorization Notes',

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextButton(
                    onPressed: saveNotes,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),

            // NOTEBOOK TABS
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [

                  ChoiceChip(
                    label:
                    const Text('Memorization'),

                    selected:
                    !isViewingTestNotes,

                    onSelected: (_) {

                      setState(() {

                        isViewingTestNotes =
                        false;

                        loadNotes();

                      });

                    },
                  ),

                  const SizedBox(width: 12),

                  ChoiceChip(
                    label:
                    const Text('Test Mode'),

                    selected:
                    isViewingTestNotes,

                    onSelected: (_) {

                      setState(() {

                        isViewingTestNotes =
                        true;

                        loadNotes();

                      });

                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // TEXT FIELD
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.all(16),

                child: TextField(
                  controller: notesController,

                  readOnly:
                  isViewingTestNotes,

                  expands: true,
                  maxLines: null,

                  textAlignVertical:
                  TextAlignVertical.top,

                  decoration:
                  const InputDecoration(
                    hintText:
                    'Write your notes...',

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}