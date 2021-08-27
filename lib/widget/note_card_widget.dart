import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';
import 'package:intl/date_symbol_data_local.dart';

final _lightColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  // Colors.amber.shade300,
  // Colors.lightGreen.shade300,
  // Colors.lightBlue.shade300,
  // Colors.orange.shade300,
  // Colors.pinkAccent.shade100,
  // Colors.teal.shade100
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    Intl.defaultLocale = 'fa_IR';
    final time = DateFormat.yMMMMEEEEd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      elevation: 5,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              note.description,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 100;
      case 2:
        return 100;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
