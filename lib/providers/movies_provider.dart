import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movie_response.dart';


class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apikey = '84edd5bf990aae43c6030178874f2326';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies= [];
  List<Movie> popularMovies = [];

  Map<int,List<Cast>>moviesCast= {} ;

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );


  final StreamController<List<Movie>> _suggestionsStreamController =  StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionsStreamController.stream;

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



  Future<List<Cast>> getMovieCast(int movieId) async{

    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }


  Future <List<Movie>> searchMovie (String query) async{
    
    final url  = Uri.https(_baseUrl,'3/search/movie', {

      'api_key': _apikey,
      'language': _language,
      'query': query,


    });
    
    final response = await http.get(url);
    final searchMovieResponse = SearchMovieResponse.fromJson(response.body);

    return searchMovieResponse.results;

  }


  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async{

      // print('temeos valor a buscar: $value');
      final results = await searchMovie(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());

  }

}

