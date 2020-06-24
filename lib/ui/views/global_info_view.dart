import 'package:flutter/material.dart';
import 'package:outbreak_covid19/core/controllers/api.dart';
import 'package:outbreak_covid19/core/models/global_info_model.dart';
import 'package:outbreak_covid19/ui/custom_widgets/country_selection.dart';
import 'package:outbreak_covid19/ui/custom_widgets/dash_navbar.dart';
import 'package:outbreak_covid19/ui/custom_widgets/static_card.dart';
import 'package:outbreak_covid19/ui/custom_widgets/virus_loader.dart';

class GlobalInfoPage extends StatefulWidget {
  @override
  _GlobalInfoPageState createState() => _GlobalInfoPageState();
}

class _GlobalInfoPageState extends State<GlobalInfoPage> {
  GlobalInfo _stats;
  double deathPercentage;
  double activePercentage;
  bool _isLoading = false;
  CovidApi api = CovidApi();
  double recoveryPercentage;

  @override
  void initState() {
    super.initState();
    _fetchGlobalStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            DashNavbar(
              title: 'Covid-19',
              subTitle: 'Stay home, stay safe!',
            ),
            Container(
              padding: EdgeInsets.only(top: 100),
              child: SafeArea(
                child: _isLoading
                    ? VirusLoader()
                    : _stats == null
                        ? buildErrorMessage()
                        : ListView(
                            children: <Widget>[
                              StatisticCard(
                                color: Colors.orange,
                                text: 'Total cases',
                                icon: Icons.timeline,
                                stats: _stats.cases,
                              ),
                              StatisticCard(
                                color: Colors.green,
                                text: 'Total recovered',
                                icon: Icons.whatshot,
                                stats: _stats.recovered,
                              ),
                              StatisticCard(
                                color: Colors.red,
                                text: 'Total deaths',
                                icon: Icons.airline_seat_individual_suite,
                                stats: _stats.deaths,
                              ),
                              // CountrySelector(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Card(
                                  elevation: 4.0,
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.sentiment_very_dissatisfied),
                                    title: Text('Death percentage'),
                                    trailing: Text(
                                      deathPercentage.toStringAsFixed(2) + ' %',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Card(
                                  elevation: 4.0,
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.sentiment_very_satisfied),
                                    title: Text('Recovery percentage'),
                                    trailing: Text(
                                      recoveryPercentage.toStringAsFixed(2) +
                                          ' %',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
              ),
            )
          ],
        ));
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to fetch data',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
      ),
    );
  }

  void _fetchGlobalStats() async {
    setState(() => _isLoading = true);
    try {
      var stats = await api.getGlobalInfo();
      deathPercentage = (stats.deaths / stats.cases) * 100;
      recoveryPercentage = (stats.recovered / stats.cases) * 100;
      activePercentage = 100 - (deathPercentage + recoveryPercentage);

      print(deathPercentage);
      print(recoveryPercentage);
      print(activePercentage);
      setState(() => _stats = stats);
    } catch (ex) {
      setState(() => _stats = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
