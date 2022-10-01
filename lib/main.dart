import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_db/db/functions/db_functions.dart';
import 'package:student_db/db/model/data_model.dart';
import 'package:student_db/provider/add_image_provider.dart';
import 'package:student_db/provider/search_provider.dart';
import 'package:student_db/screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => DbFuctionProvider()),
      ],
      child: MaterialApp(
        title: 'Student Database',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
