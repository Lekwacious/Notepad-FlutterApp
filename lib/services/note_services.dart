
import 'dart:convert';

import 'package:notepad/models/api_reponse.dart';
import 'package:notepad/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NoteService{
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey': 'e585f483-3557-4157-a13d-2f8a220b064b',
  };
  Future<ApiReponse<List<NoteForListing>>> getNoteList(){
    return http.get(API + '/notes', headers: headers)
    .then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for(var item in jsonData){
          final note = NoteForListing(
              noteId: item['noteID'],
              noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            lastEditDateTime: item['latestEditDateTime'] != null? DateTime.parse(item['latestEditDateTime']): null,
          );
          notes.add(note);
        }
  return ApiReponse<List<NoteForListing>>(data: notes);
    }
      return ApiReponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');

    })
    .catchError((_) => ApiReponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred'));

  }
}