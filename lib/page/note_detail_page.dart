import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/page/edit_note_page.dart';
import 'package:share/share.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

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
  late String _value;

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
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'fa_IR';
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), shareButton(), infoButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   DateFormat('h:mm a').format(note.createdTime),
                  //   // TODO: Add khorshidi cal.
                  //   // DateTime j2dt = note.createdTime.toDateTime(),
                  //   // Jalali.fromDateTime(note.createdTime).toString(),
                  //   // note.createdTime.toJalali().toString(),
                  // ),
                  const SizedBox(height: 20),
                  Text(
                    note.description,
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget shareButton() => IconButton(
        icon: const Icon(Icons.share_outlined),
        onPressed: () {
          Share.share('${note.title} \n ${note.description}');
        },
      );

  Widget infoButton() => IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.fromLTRB(8, 16, 8, 0),
                height: 250,
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ساخته شد',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                DateFormat('d MMM، yyyy، HH:mm')
                                    .format(note.createdTime),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'کلمات',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                (note.title.split(' ').length +
                                        note.description.split(' ').length)
                                    .toString()
                                    .toPersianDigit(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'حروف',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                (note.title.length + note.description.length)
                                    .toString()
                                    .toPersianDigit(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

  // DateFormat('h:mm a').format(note.createdTime),

//   AnimatedIcon(
//    icon: AnimatedIcons.play_pause,
//    progress: _animationController,
//  )

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          showAlertDialog(BuildContext context) {
            final Widget cancelButton = TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "لغو",
                style: TextStyle(color: Colors.black),
              ),
            );
            Widget continueButton = TextButton(
              onPressed: () async {
                await NotesDatabase.instance.delete(widget.noteId);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                "مطمئنم!",
                style: TextStyle(color: Colors.black),
              ),
            );
            AlertDialog alert = AlertDialog(
              title: const Text("مطمئن هستید؟"),
              content: const Text("آیا مطمئن هستید که این یادداشت حذف بشه؟"),
              actions: [
                cancelButton,
                continueButton,
              ],
            );

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
