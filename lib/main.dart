import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ui/db/model/data_model.dart';
import 'package:ui/home.dart';
import 'package:ui/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(messagemodelAdapter().typeId)) {
    Hive.registerAdapter(messagemodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KRYPT IT!",
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 3, 34, 174),
        fontFamily: 'Georgia',
      ),
      home: Splash(),
    );
  }
}
