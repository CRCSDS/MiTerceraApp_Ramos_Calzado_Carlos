
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/serie_model.dart';


class SeriesProvider {

  String _apikey   = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando     = false;

  List<Serie> _populares = new List();

  final _popularesStreamController = StreamController<List<Serie>>.broadcast();


  Function(List<Serie>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Serie>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams() {
    _popularesStreamController?.close();
  }


  Future<List<Serie>> _procesarRespuesta(Uri url) async {
    
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final series = new Series.fromJsonList(decodedData['results']);


    return series.items;
  }



  Future<List<Serie>> getEnElAire() async {

    final url = Uri.https(_url, '3/tv/on_the_air', {
      'api_key'  : _apikey,
      'language' : _language
    });

    return await _procesarRespuesta(url);

  }


  Future<List<Serie>> getPopulares() async {
    
    if ( _cargando ) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/tv/popular', {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink( _populares );

    _cargando = false;
    return resp;

  }

  Future<List<Actor>> getCast( String serieId ) async {

    final url = Uri.https(_url, '3/tv/$serieId/credits', {
      'api_key'  : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }


  Future<List<Serie>> buscarSerie( String query ) async {

    final url = Uri.https(_url, '3/search/tv', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await _procesarRespuesta(url);

  }

}

