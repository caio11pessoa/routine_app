import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:routine_app/collections/category.dart';
import 'package:routine_app/collections/routine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routine_app/screens/create_routine.dart';
// import 'package:appwrite/appwrite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   Map<dynamic, dynamic> test = {
//   'id': 30,
//   'name': 'João'
// };
//   try {
//     final document = databases.createDocument(
//       databaseId: "64b67cf22656607de4b9", 
//       collectionId: "64b67d2a0ab2487c293d", 
//       documentId: ID.unique(), 
//       data: test
//       );
//   } on AppwriteException catch(e) {
//     print(e);
//   }

  
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
      [RoutineSchema, CategorySchema], directory: dir.path);
  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({Key? key, required this.isar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(isar: isar),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  final Isar isar;
  const MainPage({Key? key, required this.isar}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Routine"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateRoutine(isar: widget.isar)));
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}