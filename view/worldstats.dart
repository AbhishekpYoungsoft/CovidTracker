import 'package:covidtrackerapp/Util/Stats_services.dart';
import 'package:covidtrackerapp/view/countriesstats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/getwidget.dart';

//pie chart to represent data
import 'package:pie_chart/pie_chart.dart';

import '../Model/world_states_modal.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  //creating an anmation controller
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  //disposing the controller after the use
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget onLoading() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: const GFLoader(
        type: GFLoaderType.android,
      ),
    );
  }

  final colorslist = const [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatService statServices = StatService();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          //----------------------------------getting data from api
          FutureBuilder(
              future: statServices.fetchWorldStatesRecord(),
              builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                if (!snapshot.hasData) {
                  return onLoading();
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Revovered": double.parse(
                            snapshot.data!.recovered.toString(),
                          ),
                          "death":
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        animationDuration: const Duration(milliseconds: 1200),
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        colorList: colorslist,
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValues: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Card(
                        child: Column(
                          children: [
                            ReusableRow(
                                title: "Total",
                                value: double.parse(
                                    snapshot.data!.cases.toString())),
                            ReusableRow(
                                title: "Recovered",
                                value: double.parse(
                                    snapshot.data!.recovered.toString())),
                            ReusableRow(
                                title: "Death",
                                value: double.parse(
                                    snapshot.data!.deaths.toString())),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const TrackCountriesButton(),
                    ],
                  );
                }
              })
        ]),
      ),
    ));
  }
}

//needed widgets building
// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title;
  double value;
  //const ReusableRow({super.key});

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text(value.toString())],
            ),
          )
        ],
      ),
    );
  }
}

class TrackCountriesButton extends StatelessWidget {
  const TrackCountriesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CountriesList()));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text('Track Countries'),
        ),
      ),
      // Container(
      //   //color: Colors.green,
      //   width: MediaQuery.of(context).size.width * 0.9,
      //   decoration: const BoxDecoration(
      //       color: Colors.green,
      //       borderRadius: BorderRadius.all(Radius.circular(10))),
      // child: TextButton(
      //   child: const Text(
      //     "Track Countries",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   onPressed: () => sample(),
      //   //print("ok till here");
      // ),
    );
  }
}

//  Widget sample() {
//   return MaterialApp(
//     home: Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: const Text('countries list to be showed!'),
//       ),
//     ),
//   );
// }
