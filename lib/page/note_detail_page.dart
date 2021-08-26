import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = (await NotesDatabase.instance.readNote(widget.noteId))!;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(24),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      note.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          showAlertDialog(BuildContext context) {
            final Widget cancelButton = TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text("لغو", style: TextStyle(color: Colors.black)),
            );
            Widget continueButton = TextButton(
              onPressed: () async {
                await NotesDatabase.instance.delete(widget.noteId);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child:
                  const Text("مطمئنم!", style: TextStyle(color: Colors.black)),
            );
            AlertDialog alert = AlertDialog(
              title: const Text("مطمئن هستید؟"),
              content: const Text("آیا مطمئن هستید که این یادداشت حذف شود؟"),
              actions: [
                cancelButton,
                continueButton,
              ],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }

          showAlertDialog(context);
        },
      );
}
