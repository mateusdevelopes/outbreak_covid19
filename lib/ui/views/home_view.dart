import 'package:bottom_personalized_dot_bar/bottom_personalized_dot_bar.dart';
import 'package:flutter/material.dart';
import 'package:outbreak_covid19/ui/views/about_view.dart';
import 'package:outbreak_covid19/ui/views/country_list_view.dart';
import 'package:outbreak_covid19/ui/views/global_info_view.dart';

class HomePageMaster extends StatefulWidget {
  @override
  _HomePageMasterState createState() => _HomePageMasterState();
}

class _HomePageMasterState extends State<HomePageMaster> {
  int _currentIndex = 0;

  List<Widget> _widgets = <Widget>[
    GlobalInfoPage(),
    CountryListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 4),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).accentColor,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.public,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                title: Text('')),
          ],
        ),
      ),
      body: _widgets.elementAt(_currentIndex),
    );
  }
}
