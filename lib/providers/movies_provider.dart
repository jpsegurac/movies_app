import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';


class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apikey = '84edd5bf990aae43c6030178874f2326';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies= [];
  List<Movie> popularMovies = [];

  int _popularPage = 499;


  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apikey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
  
    return response.body;

        
  }


  getOnDisplayMovies() async{
    // Await the http get jsonData, then decode the json-formatted jsonData.
    final jsonData = await _getJsonData('3/movie/now_playing');

    final decodedData = NowPlaying.fromJson(jsonData);

    onDisplayMovies = decodedData.results;

    notifyListeners();   

  }

  getPopularMovies() async{

    if(_popularPage >=500)  _popularPage =0;

    _popularPage ++;
    // Await the http get jsonData, then decode the json-formatted jsonData.
    final jsonData = await _getJsonData('3/movie/popular', _popularPage );
    
    final decodedData = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies,... decodedData.results];
    notifyListeners();     

  }
}
