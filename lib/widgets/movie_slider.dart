

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';


class MovieSlider extends StatefulWidget {
  const MovieSlider({
    super.key, 
    required this.movies,
    this.titleMovieSlider, 
    required this.onNextPage
  });

  final List<Movie> movies;
  final String? titleMovieSlider;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){

        widget.onNextPage();
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.titleMovieSlider != null)
            Padding(              
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:Text(widget.titleMovieSlider! ,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ),
          

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index){
                final movie = widget.movies[index];
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
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
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


