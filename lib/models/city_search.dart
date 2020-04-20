class CitySearch {
  String name;
  String province;

  CitySearch(this.name, this.province);

  CitySearch.emptyInitialize();

  CitySearch.fromJson(Map<String, dynamic> json) :
    name = json['comune'],
    province = json['provincia'];

}