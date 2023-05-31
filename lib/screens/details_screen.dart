import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});



  @override
  Widget build(BuildContext context) {

    // final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppbar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _PosterAndTitle(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),

                const CastingCards()

              ]
            ) 
          )
        ],
      ),
    );
  }
}

class _CustomAppbar extends StatelessWidget {
  const _CustomAppbar({super.key});

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
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: const Text(
            'Movie.title', 
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ),
        background: const FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'), 
        image: NetworkImage('http://placekitten.com/500/300'),
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage('http://placekitten.com/200/300'),
              height: 150,
            ),
          ),
          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.original.title',
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const Row(
                children: [
                  Icon(Icons.star_outline, size: 15,color: Colors.grey,),
                  SizedBox(width: 5,),
                  Text("movie.voteAverage")
                ],
              )
            ],
          )
        ]
      ),
    );
  }
}


class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      
      child: Text('Adipisicing adipisicing tempor officia consequat dolor elit nulla fugiat nulla nulla anim. Ex dolor magna veniam non eiusmod. Eiusmod duis culpa irure enim officia labore nisi adipisicing. Irure nisi reprehenderit non laboris enim voluptate deserunt laboris amet.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      
    );
  }
}