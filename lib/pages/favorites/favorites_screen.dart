import 'package:flutter/material.dart';
import 'package:my_weather/pages/favorites/widget/favorite_card_widget.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';
import 'package:my_weather/providers/favorite_cities.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget{
  static const routeName = '/favorites';

  List<BackgroundCard> backgroundList = [
    BackgroundCard('assets/img/backgrounds/01b.jpg', Alignment.bottomCenter),
    BackgroundCard('assets/img/backgrounds/02b.jpg', Alignment.bottomCenter),
    BackgroundCard('assets/img/backgrounds/03b.jpg', Alignment.bottomCenter),
    BackgroundCard('assets/img/backgrounds/04b.jpg', Alignment.topCenter),
    BackgroundCard('assets/img/backgrounds/05b.jpg', Alignment.bottomCenter),
    BackgroundCard('assets/img/backgrounds/06b.jpg', Alignment.bottomCenter),
    BackgroundCard('assets/img/backgrounds/07b.jpg', Alignment.center),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Preferiti',
          isTabBar: false,
          context: context
      ).getAppBar(),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<FavoriteCities>(context, listen: false).fetchFavoriteCities(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center( child: CircularProgressIndicator() );
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Oops.. preferiti non caricati correttamente!'));
          }
          else {
            return Consumer<FavoriteCities>(
              child: Center(
                child: Text('Non hai ancora aggiunto nessun preferito!'),
              ),
              builder: (ctx, favoriteCities, ch) =>
                favoriteCities.getCityList.length <= 0
                  ? ch
                  : Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: favoriteCities.getCityList.length,
                      itemBuilder: (ctx, i) => FavoriteCard(favoriteCities.getCityList[i], backgroundList[i % backgroundList.length]),
                    ),
                  ),
            );
          }
        }
      ),
    );
  }
}

class BackgroundCard {
  final String imagePath;
  final Alignment alignment;

  BackgroundCard(this.imagePath, this.alignment);
}
