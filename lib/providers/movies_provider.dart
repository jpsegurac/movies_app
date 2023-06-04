import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';


class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apikey = '84edd5bf990aae43c6030178874f2326';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies= [];


  MoviesProvider(){
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }


  getOnDisplayMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    NowPlaying.fromJson(response.body);
    if (response.statusCode != 200 ){
      return print('Request failed with status: ${response.statusCode}.');
    }else{
      final decodedData = NowPlaying.fromJson(response.body);
      print(decodedData.results[1].title);


      onDisplayMovies = decodedData.results;

      notifyListeners();
    }

  }


}