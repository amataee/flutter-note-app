const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    number,
    isImportant,
    title,
    description,
    time
  ];

  static const String id = '_id';
  static const String number = 'number';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final int number;
  final String isImportant;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.number,
    required this.title,
    required this.isImportant,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    int? number,
    String? isImportant,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        number: number ?? this.number,
        title: title ?? this.title,
        isImportant: isImportant ?? this.isImportant,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        isImportant: json[NoteFields.isImportant] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.number: number,
        NoteFields.isImportant: isImportant,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
