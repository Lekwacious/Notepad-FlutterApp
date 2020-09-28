import 'package:flutter/material.dart';
import 'package:notepad/models/api_reponse.dart';
import 'package:notepad/models/note_for_listing.dart';
import 'package:notepad/views/create_modify_note.dart';
import 'package:notepad/views/note_delete.dart';
import 'package:notepad/services/note_services.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  NoteService get service => GetIt.I<NoteService>();

  ApiReponse<List<NoteForListing>> _apiReponse;
  bool _isLoading = false;


  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
     _apiReponse = await service.getNoteList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),

          child:Image.asset('assets/book.png'),
        ),
        title: Text('List of notes by Lekwa',
        style: TextStyle(color: Colors.black),),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify()));

        },
        child: Icon(Icons.add),

      ),
      body:  Builder(
        builder: (_){
          if(_isLoading){
            return CircularProgressIndicator();
          }
          if(_apiReponse.error){
           return Center(
              child: Text(_apiReponse.errorMessage),
            );
          }
        return ListView.separated(
          separatorBuilder: (_, __)=> Divider(height: 7, color: Colors.deepOrange),
          itemBuilder: (_, index){
            return Dismissible(
              key: ValueKey(_apiReponse.data[index].noteId),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction){
              },
              confirmDismiss: (direction) async{
                final result = await showDialog(
                    context: context,
                    builder: (_) =>NoteDelete()

                );
                return result;
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 16),
                child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft),
              ),
              child: ListTile(
                title: Text(_apiReponse.data[index].noteTitle,
                  style: TextStyle(color:Colors.deepOrange ),
                ),
                subtitle: Text("Last edited on ${formatDateTime(_apiReponse.data[index].lastEditDateTime ?? _apiReponse.data[index].createDateTime)}"),
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> NoteModify(noteId:_apiReponse.data[index].noteId)));

                },
              ),
            );

          },
          itemCount: _apiReponse.data.length,

        );

        },
      )

    );
  }
}
