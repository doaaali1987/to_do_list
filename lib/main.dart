import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:to_do_list/providers/listProvider.dart';
import 'package:to_do_list/ui/screens/home/home_screen.dart';
import 'package:to_do_list/utilities/theme_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ///unlimited cache size
  // The default value is 40 MB. The threshold must be set to at least 1 MB,
// and can be set to Settings.CACHE_SIZE_UNLIMITED to disable garbage collection.
  FirebaseFirestore.instance.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  ///add offline
  await FirebaseFirestore.instance.disableNetwork();
  ///after creating listProvider.dart,below in runApp,create obj from provider use it around the app
  runApp(ChangeNotifierProvider(
      create: (_)=>ListProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      themeMode: ThemeMode.system,
      title: 'To Do project',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale("en"),Locale("ar")],
      locale: Locale("en"),
      routes: {
    HomeScreen.routeName:(_)=>HomeScreen(),
    },
      initialRoute: HomeScreen.routeName,
    );
  }
}
