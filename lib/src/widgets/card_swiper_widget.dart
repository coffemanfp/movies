import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int i) {
          
          movies[i].uniqueId = '${movies[i].id}-card';

          return Hero(
            tag: movies[i].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('details', arguments: movies[i]),
                child: FadeInImage(
                  image: NetworkImage(movies[i].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}