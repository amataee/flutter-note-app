import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/db/notes_database.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/page/edit_note_page.dart';
import 'package:note_app/page/note_detail_page.dart';
import 'package:note_app/page/settings.dart';
import 'package:note_app/widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  // late ScrollController _hideButtonController;
  int _selectedIndex = 0;
  // late bool _isVisible;

  // TODO: Make the floating action button invisible when the user scroll down.

  @override
  void initState() {
    super.initState();

    // _isVisible = true;
    // _hideButtonController = ScrollController();
    // _hideButtonController.addListener(() {
    //   if (_hideButtonController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (_isVisible == true) {
    //       /* only set when the previous state is false
    //          * Less widget rebuilds
    //          */
    //       print("**** ${_isVisible} up"); //Move IO away from setState
    //       setState(() {
    //         _isVisible = false;
    //       });
    //     }
    //   } else {
    //     if (_hideButtonController.position.userScrollDirection ==
    //         ScrollDirection.forward) {
    //       if (_isVisible == false) {
    //         /* only set when the previous state is false
    //            * Less widget rebuilds
    //            */
    //         print("**** ${_isVisible} down"); //Move IO away from setState
    //         setState(() {
    //           _isVisible = true;
    //         });
    //       }
    //     }
    //   }
    // });

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       ListTile(
        //         title: Row(
        //           children: const [
        //             Icon(Icons.notes_outlined),
        //             SizedBox(width: 10),
        //             Text("همه یادداشت‌ها"),
        //           ],
        //         ),
        //         onTap: () async {
        //           // same page
        //         },
        //       ),
        //       ListTile(
        //         title: Row(
        //           children: const [
        //             Icon(Icons.delete_outline),
        //             SizedBox(width: 10),
        //             Text("یادداشت‌های حذف شده"),
        //           ],
        //         ),
        //         onTap: () async {
        //           // list of deleted notes
        //         },
        //       ),
        //       ListTile(
        //         title: Row(
        //           children: const [
        //             Icon(Icons.settings_outlined),
        //             SizedBox(width: 10),
        //             Text("تنظیمات"),
        //           ],
        //         ),
        //         onTap: () async {
        //           Navigator.pop(context);
        //           await Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => SettingsPage()),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'یادداشت‌ها',
            style: TextStyle(fontSize: 24),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.search_outlined),
          //     onPressed: () {
          //       // search function
          //     },
          //   ),
          // ],
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

        // bottomNavigationBar: CupertinoTabScaffold(
        //   // selectedItemColor: Colors.teal,
        //   // currentIndex: _selectedIndex,
        //   // onTap: _onItemTapped,
        //   tabBar: CupertinoTabBar(
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.notes_outlined),
        //         label: 'همه یادداشت‌ها',
        //         activeIcon: Icon(Icons.notes),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.delete_outline),
        //         label: 'یادداشت‌های حذف شده',
        //         activeIcon: Icon(Icons.delete),
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.settings_outlined),
        //         label: 'تنظیمات',
        //         activeIcon: Icon(Icons.settings),
        //       ),
        //     ],
        //   ),
        //   tabBuilder: (context, index) {
        //     switch (index) {
        //       case 0:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoPageScaffold(
        //             child: NotesPage(),
        //           );
        //         });
        //       case 2:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoPageScaffold(
        //             child: SettingsPage(),
        //           );
        //         });
        //       default:
        //         return CupertinoTabView(builder: (context) {
        //           return CupertinoPageScaffold(
        //             child: NotesPage(),
        //           );
        //         });
        //     }
        //   },
        // ),
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

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
