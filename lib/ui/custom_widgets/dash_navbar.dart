import 'package:flutter/material.dart';
import 'package:outbreak_covid19/ui/views/about_view.dart';

class DashNavbar extends StatelessWidget {
  const DashNavbar({Key key, this.title, this.subTitle}) : super(key: key);
  final title;
  final subTitle;

  @override
  Widget build(BuildContext context) {
    double statusWidth = MediaQuery.of(context).padding.top;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: statusWidth,
            color: Colors.white,
          ),
          Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 12, 24, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              )),
                          Text(subTitle,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              )),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutMePage(),
                            ),
                          );
                        },
                      ),
                      // CountrySelector(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
