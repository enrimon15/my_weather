class CitySearch {
  final String name;
  final String province;

  CitySearch(this.name, this.province);

  CitySearch.fromJson(Map<String, dynamic> json) :
    name = json['comune'],
    province = json['provincia'];

}