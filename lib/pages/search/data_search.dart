import 'package:flutter/material.dart';
import 'package:my_weather/models/city_search.dart';
import 'package:my_weather/utilities/search_cities.dart';
import 'package:easy_localization/easy_localization.dart';

class DataSearch extends SearchDelegate<String> {

  List<CitySearch> searchCities = SearchCitiesUtility.allCities;

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
      return Column();
    }

    final listCitiesMatch = query.isEmpty
        ? []
        : searchCities.where( (city) => city.name.toLowerCase().startsWith(query.toLowerCase()) ).toList();


    return ListView.builder(
        itemCount: listCitiesMatch.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.of(context).pushReplacementNamed('/', arguments: {'name': listCitiesMatch[index].name.toString(), 'province': listCitiesMatch[index].province.toString()}),
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