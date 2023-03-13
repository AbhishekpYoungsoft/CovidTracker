import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name = '';
  String image;
  int totalcases, recovered, critical, deaths;

  DetailsScreen(
      {required this.name,
      required this.image,
      required this.totalcases,
      required this.recovered,
      required this.critical,
      required this.deaths});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      ReusableRow(
                        totalcases: widget.totalcases,
                        recovered: widget.recovered,
                        critical: widget.critical,
                        deaths: widget.deaths,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  // String name = '';
  // String image = '';
  int totalcases, recovered, critical, deaths;

  ReusableRow(
      {super.key,
      //required this.name,
      // required this.image,
      required this.totalcases,
      required this.recovered,
      required this.critical,
      required this.deaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(2.0)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("totalcases"),
                Text(totalcases.toString()),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("recovered"),
                Text(recovered.toString()),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("critical"),
                Text(critical.toString()),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("deaths"),
                Text(deaths.toString()),
              ],
            ),
          ),
        )
      ],
    );
  }
}
