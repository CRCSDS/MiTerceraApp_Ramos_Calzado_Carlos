import 'package:flutter/material.dart';
import 'package:peliculas/src/models/serie_model.dart';


class SerieHorizontal extends StatelessWidget {

  final List<Serie> series;
  final Function siguientePagina;

  SerieHorizontal({ @required this.series, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        siguientePagina();
      }

    });


    return Container(
      padding: EdgeInsets.only(top: 5.0),
      decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemCount: series.length,
        itemBuilder: ( context, i ) => _tarjeta(context, series[i] ),
      ),
    );


  }

  Widget _tarjeta(BuildContext context, Serie serie) {
    
    serie.uniqueId = '${ serie.id }-poster';

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: serie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( serie.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 110.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              /* pelicula.title, */
              serie.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,)
              /*Theme.of(context).textTheme.caption,*/
            )
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalle', arguments: serie );

      },
    );

  }


  List<Widget> _tarjetas(BuildContext context) {

    return series.map( (serie) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( serie.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              /*pelicula.title,*/
              serie.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );


    }).toList();

  }

}
