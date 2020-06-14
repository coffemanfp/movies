import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Capitan America',
  ];

  final recentMovies = [
    'Spiderman',
    'Capitan America',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Leading Icons Press');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder que crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Center(
          child: Text(selection)
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {

          final movies = snapshot.data;

          return ListView(
            children: movies.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('asset/img/no-image.jpg'),
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                onTap: () {
                  close(context, null); // Cierra la ventana actual
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
              );
            }).toList(),
          );
        }

        return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen cuando la persona escribe
  //   final listSuggestion = (query.isEmpty)
  //                           ? recentMovies
  //                           : movies.where(
  //                             (movie) => movie.toLowerCase().startsWith(query.toLowerCase())
  //                           ).toList();

  //   return ListView.builder(
  //     itemCount: listSuggestion.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listSuggestion[i]),
  //         onTap: () {
  //           selection = listSuggestion[i];
  //           showResults(context);
  //         },
  //       );
  //     }
  //   );
}