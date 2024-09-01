import 'dart:convert';

import 'package:clippet_technology_assignment/model/movie_item.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  final String _baseUrl = "https://hoblist.com";
  final String _endPoint = "api/movieList";

  String get _url => "$_baseUrl/$_endPoint";
  final Map<String, String> _params = <String, String>{
    "category": "movies",
    "language": "kannada",
    "genre": "all",
    "sort": "voting"
  };

  Future<List<MovieItem>> getMovies() async {
    try {
      var response = await http.post(
          Uri.parse(
            _url,
          ),
          body: _params);
      if(response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
        var movieListData = decodedData["result"] as List<dynamic>;
        var data = movieListData.map((e) => MovieItem.fromJson(e),).toList();
        return data;
      }else{
        return [];
      }
    } catch (e) {
      throw "$e";
    }
    return [];
  }
}
