import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var _movies;

  @override
  Widget build(BuildContext context) {
    _fetchMovies();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.6,
        title: Text(
          'Movies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: _movies == null ? 0 : _movies.length,
            itemBuilder: (context, index) {
              return MovieCell(_movies[index]);
            }),
      ),
    );
  }

  Future<Map> _getMoviesJson() async {
    const apiKey = 'ee8ad06beda1f105bd2f245ad3ecddec';
    const url = "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  void _fetchMovies() async {
    var data = await _getMoviesJson();
    setState(() {
      _movies = data['results'];
    });
  }
}

class MovieCell extends StatelessWidget {
  final _movie;
  var _imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieCell(this._movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _getPosterView(),
            _getDescriptionView()
          ],
        ),
        _getDividerView()
      ],
    );
  }

  Padding _getPosterView() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Container(width: 80, height: 80),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(_imageUrl + _movie['poster_path']),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Expanded _getDescriptionView() {
    return Expanded(child: Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Text(
            _movie['title'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(padding: const EdgeInsets.all(2)),
          Text(
            _movie['overview'],
            maxLines: 3,
            style: TextStyle(color: const Color(0xff8785A4)),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    ));
  }

  Container _getDividerView() {
    return Container(
      width: 300,
      height: 0.5,
      color: const Color(0xD2D2E1ff),
      margin: const EdgeInsets.all(16),
    );
  }
}
