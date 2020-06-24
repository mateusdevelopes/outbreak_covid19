import 'package:flutter/material.dart';
import 'package:outbreak_covid19/utils/global.dart';

class StatisticCard extends StatelessWidget {
  final String text;
  final int stats;
  final Color color;
  final IconData icon;

  StatisticCard({
    @required this.color,
    @required this.icon,
    @required this.text,
    @required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stats.toString().replaceAllMapped(reg, mathFunc),
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    size: 50.0,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
