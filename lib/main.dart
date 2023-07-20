import 'package:flutter/material.dart';
import 'global_state_controller.dart';
import 'home.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  StorageController().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Esprix',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
