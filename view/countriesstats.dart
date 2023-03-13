import 'package:covidtrackerapp/Util/Stats_services.dart';
import 'package:covidtrackerapp/view/detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

//this is a country list shwing all the list oof countries available with covid data
//pending work, search button
//integration of country wise data
class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CountriesStats countriesstats = CountriesStats();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(leading: const BackButton()),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Search bar function,, can be used for which ever app you will build
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      //icon: Icon(Icons.search),
                      hintText: 'Search country name',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.2),
                      ),
                      suffixIcon: _searchController.text.isEmpty
                          ? const Icon(Icons.search)
                          : GestureDetector(onTap: (() {
                              _searchController.text = "";
                              setState(() {});
                            }), onPanEnd: (value) {
                              setState(() {});
                            })),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: countriesstats.fetchCountryStatsRecord(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const GFLoader(type: GFLoaderType.android);
                  } else {
                    //print(snapshot.data![index]['country'].toString());
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          String name = snapshot.data![index][
                              'country']; // declaring a string name to make use in serching country

                          if (_searchController.text.isEmpty) {
                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                name: snapshot.data![index]
                                                        ['country']
                                                    .toString(),
                                                totalcases: snapshot
                                                    .data![index]['cases'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                              )));
                                },
                                child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                    title: Text(
                                      snapshot.data![index]['country']
                                          .toString(),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]['cases'].toString(),
                                    )),
                              )
                            ]);
                          } else if (name
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase())) {
                            //name and search controller is having same name

                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                name: snapshot.data![index]
                                                        ['country']
                                                    .toString(),
                                                totalcases: snapshot
                                                    .data![index]['cases'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                              )));
                                },
                                child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                    title: Text(
                                      snapshot.data![index]['country']
                                          .toString(),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]['cases'].toString(),
                                    )),
                              )
                            ]);
                          } else {
                            return Container();
                          }
                        }));
                  }
                },
              ))
            ],
          )),
    );
  }
}
