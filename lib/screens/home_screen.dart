import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final moviesProvider = Provider.of<MoviesProvider>(context,);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies on cinemas"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              
            }, 
            icon: const Icon(Icons.search_outlined)
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [

          //tarjetas principales
          CardSwiper( movies: moviesProvider.onDisplayMovies, ),
          //tarjetas de peliculas
          //todo agregar titulo opcional en movie slider
          MovieSlider(movies: moviesProvider.popularMovies, titleMovieSlider: 'Las mas populares',),

          //listado de pelis
        ],
      ),
      )
    );
  }
}