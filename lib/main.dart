import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/page/notes_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          // TODO: Change fonts!
          // fontFamily: 'SourceSansPro',
          // textTheme: TextTheme(title: TextStyle(fontFamily: 'SourceSansPro')),
          primaryColor: Colors.black,
          errorColor: Colors.amber,
          scaffoldBackgroundColor: Colors.blueGrey.shade700,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
        ),
        home: NotesPage(),
      );
}
