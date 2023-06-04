

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';


class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.movies,this.titleMovieSlider});

  final List<Movie> movies;
  final String? titleMovieSlider;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //todo si no hay titulo entonces quitar esto
          if(titleMovieSlider != null)
            Padding(              
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:Text(titleMovieSlider! ,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ),
          

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _ , int index){
                final movie = movies[index];
                print(movie.fullPosterImg);
                return _MoviePoster(movie);
              },
            ),
          )
        ]
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster(this.movie);

  final Movie movie;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 210,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
       child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
            
            
              ),
            ),
          ),

          const SizedBox(height: 5,),

          Text(movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(movie.overview,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),


        ],
       ),
    );
  }
}


