import 'dart:async';

import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  String _apiKey = '2eaf3e422600607a46560904e628a22c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _doResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.movies;
  }

  Future<List<Movie>> getInTheaters() async {
    final url = Uri.http(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _doResponse(url);
  }

  Future<List<Movie>> getPopulars() async {

    if (_loading) return [];

    _loading = true;

    _popularsPage++;

    print('Loading following page...');

    final url = Uri.http(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString(),
    });

    final resp = await _doResponse(url);

    _populars.addAll(resp);

    popularsSink(_populars);

    _loading = false;

    return resp;
  }

  Future<List<Actor>> getCast( int movieID ) async {
    final url = Uri.https(_url, '/3/${movieID.toString()}/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.http(_url, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    return await _doResponse(url);
  }
}