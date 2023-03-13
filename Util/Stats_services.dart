import 'dart:convert';
import 'package:covidtrackerapp/Model/world_states_modal.dart';
import 'package:covidtrackerapp/Util/app_url.dart';
import 'package:http/http.dart' as http;

import 'package:covidtrackerapp/Model/countries_stats_model.dart';

class StatService {
  Future<WorldStatsModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStats));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}

class CountriesStats {
  Future<List<dynamic>> fetchCountryStatsRecord() async {
    final countryResponse =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (countryResponse.statusCode == 200) {
      print("ok till hee");
      //print(countryResponse.body);
      var countryData = jsonDecode(countryResponse.body);
      //print(countryData[0]['country']);
      return countryData;
    } else {
      throw Exception('error');
    }
  }
}
