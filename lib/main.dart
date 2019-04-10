import 'package:flutter/material.dart';
import 'package:tmdb/movie_list.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie List Demo',
      home: MovieList(),
    );
  }
}