import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/series_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/serie_horizontal.dart';

class HomePage extends StatelessWidget {

  final seriesProvider = new SeriesProvider();

  @override
  Widget build(BuildContext context) {

    seriesProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Series disponibles en TV'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'
                );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/API_BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
       
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: seriesProvider.getEnElAire(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        if ( snapshot.hasData ) {
          return CardSwiper( series: snapshot.data );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );



    


  }


  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 140.0, bottom: 15.0),
            child: Text('Populares', style:
            TextStyle(
              fontSize: 20,
              color: Colors.white,)
            /*Theme.of(context).textTheme.subhead  */)
          ),
          SizedBox(height: 1.0),

          StreamBuilder(
            stream: seriesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if ( snapshot.hasData ) {
                return SerieHorizontal(
                  series: snapshot.data,
                  siguientePagina: seriesProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );


  }

}