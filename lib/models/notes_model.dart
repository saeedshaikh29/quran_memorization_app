import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {

  @HiveField(0)
  final int pageNumber;

  @HiveField(1)
  String memorizationNotes;

  @HiveField(2)
  String testModeNotes;

  NoteModel({
    required this.pageNumber,
    this.memorizationNotes = '',
    this.testModeNotes = '',
  });
}