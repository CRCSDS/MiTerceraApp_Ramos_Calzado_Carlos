import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/serie_model.dart';

import 'package:peliculas/src/providers/series_provider.dart';

class SerieDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Serie serie = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( serie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _posterTitulo( context, serie ),
               /* _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),*/
                _descripcion( serie ),
                _crearCasting( serie )
              ]
            ),
          )
        ],
      )
    );
  }


  Widget _crearAppbar( Serie serie ){

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          /*pelicula.title,*/
          serie.name,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        background: FadeInImage(
          image: NetworkImage( serie.getBackgroundImg() ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 1000),
          fit: BoxFit.cover,
        ),
      ),
    );

  }

  Widget _posterTitulo(BuildContext context, Serie serie ){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: serie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( serie.getPosterImg() ),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ), */
                /* Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ), */
                Text(serie.name, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis ),
                Text(serie.originalName, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis ),

                Row(
                  children: <Widget>[
                    Icon( Icons.star_border,),
                    Text( serie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

  }


  Widget _descripcion( Serie serie ) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
      child: Text(
        serie.overview,
        textAlign: TextAlign.justify,
      ),
    );

  }


  Widget _crearCasting( Serie serie ) {

    final serieProvider = new SeriesProvider();

    return FutureBuilder(
      future: serieProvider.getCast(serie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        
        if( snapshot.hasData ) {
          return _crearActoresPageView( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator());
        }

      },
    );

  }

  Widget _crearActoresPageView( List<Actor> actores ) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) =>_actorTarjeta( actores[i] ),
      ),
    );

  }

  Widget _actorTarjeta( Actor actor ) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getFoto() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    );
  }


}