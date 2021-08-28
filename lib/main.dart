import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/page/notes_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"),
        ],
        locale: const Locale("fa", "IR"),
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: 'Vazir',
          accentColor: Colors.teal,
          primaryColor: Colors.white,
          errorColor: Colors.red,
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black45),
        ),
        home: NotesPage(),
      );
}
