import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies on cinemas"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              
            }, 
            icon: Icon(Icons.search_outlined)
            )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
        children: [

          //tarjetas principales
          CardSwiper(),
          //tarjetas de peliculas
          MovieSlider(),

          //listado de pelis
        ],
      ),
      )
    );
  }
}