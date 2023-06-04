import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper(
    {super.key,
    required this.movies
    }
  );


  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
  
    return Container(
      width: double.infinity,
      height: size.height*0.5,
      color: Colors.white,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height *0.4,
        itemBuilder: ( _ , int index) {


          final movie = movies[index];
          print(movie.fullPosterImg);

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}