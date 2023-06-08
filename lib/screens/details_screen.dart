import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});



  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppbar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie),
                _Overview(movie),

                CastingCards(movieId: movie.id,)

              ]
            ) 
          )
        ],
      ),
    );
  }
}

class _CustomAppbar extends StatelessWidget {


  const _CustomAppbar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.yellow[600],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true, 
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
          color: Colors.black12,
          child: Text(
            movie.title, 
            style: const TextStyle(
              fontSize: 16
            ),
          ),
        ),
        background: FadeInImage(
        placeholder: const AssetImage('assets/images/loading.gif'), 
        image: NetworkImage(movie.fullBackdropPath),
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle(this.movie);


  final Movie movie;

  @override
  Widget build(BuildContext context) {

    // final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(
        top: 20
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-200),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15,color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}')
                  ],
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}


class _Overview extends StatelessWidget {
  const _Overview(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      
      child: Text(movie.overview.toString(),
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      
    );
  }
}