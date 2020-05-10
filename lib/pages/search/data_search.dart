import 'package:flutter/material.dart';
import 'package:my_weather/models/city_search.dart';
import 'package:my_weather/services/city_search_service.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';

class DataSearch extends SearchDelegate<String> {

  List<CitySearch> searchCities = locator<SearchCityService>().getCities;

  @override
  String get searchFieldLabel => tr("search_hint");

  @override
  List<Widget> buildActions(BuildContext context) {
      return [IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      },)];
  }



  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 7978 cities
    if (searchCities.length <= 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(tr("search_no_content")),
          )
        ],
      );
    }

    final listCitiesMatch = query.isEmpty
        ? []
        : searchCities.where( (city) => city.name.toLowerCase().startsWith(query.toLowerCase()) ).toList();


    return ListView.builder(
        itemCount: listCitiesMatch.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false, arguments: {'name': listCitiesMatch[index].name.toString(), 'province': listCitiesMatch[index].province.toString()}),
          /*onTap: !kIsWeb || MediaQuery.of(context).size.width <= 800
              ? () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false, arguments: {'name': listCitiesMatch[index].name.toString(), 'province': listCitiesMatch[index].province.toString()})
              : () => Navigator.of(context).pushReplacementNamed('/', arguments: {'name': listCitiesMatch[index].name.toString(), 'province': listCitiesMatch[index].province.toString()}),*/
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: listCitiesMatch[index].name.substring(0,query.length),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [TextSpan(
                text: listCitiesMatch[index].name.substring(query.length),
                style: TextStyle(color: Colors.grey),
              )]
            )
          ),
          subtitle: Text( listCitiesMatch[index].province ),
        )
    );
  }

}