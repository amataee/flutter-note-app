import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/page/edit_note_page.dart';
import 'package:note_app/page/note_detail_page.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'یادداشت‌ها',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Center(
          child: isLoading
              ? Platform.isAndroid
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const CupertinoActivityIndicator()
              : notes.isEmpty
                  ? const Center(
                      child: Text(
                        'یادداشتی وجود نداره!',
                        style: TextStyle(fontSize: 22),
                      ),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: Visibility(
          // visible: _isVisible,
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddEditNotePage()),
              );

              refreshNotes();
            },
            child: const Icon(
              Icons.create_outlined,
              size: 30,
            ),
          ),
        ),
      );

  Widget buildNotes() => ListView.builder(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return Column(
            children: [
              ListTile(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteDetailPage(noteId: note.id!),
                  ));
                  refreshNotes();
                },
                onLongPress: () {
                  // TODO: select notes
                },
                title: Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  note.description,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(
                thickness: 0.4,
              ),
            ],
          );
        },
      );
}
