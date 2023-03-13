import 'dart:convert';

class AppUrl {
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  static const String worldStats = baseUrl + 'all';
  static const String countryListStats = baseUrl + 'countries';
}
