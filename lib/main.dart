import 'package:flutter/material.dart';
import 'package:notepad/services/note_services.dart';
import 'package:notepad/views/Notelist.dart';
import 'package:get_it/get_it.dart';
void seteupLocator(){
  GetIt.I.registerLazySingleton(()=> NoteService());
}
void main() {
  seteupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NoteList(),
    );
  }
}

