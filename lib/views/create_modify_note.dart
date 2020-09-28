import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String noteId;
  bool get isEditing => noteId != null;

  NoteModify({this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Note": "Create Note" ),
          backgroundColor: Colors.deepOrange,
        ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),

        child: Column(
          children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Note Title'
            ),
          ),
          Container(height: 9),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
              hintText: 'Note content')
            ,),
          RaisedButton(
            child: Text('Save',
            style: TextStyle(color: Colors.white),
            ),
            color: Colors.deepOrange,
            onPressed: (){
              Navigator.of(context).pop();

        }
        )
        ],

        ),
      ),
    );
  }
}
