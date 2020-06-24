import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outbreak_covid19/core/controllers/api.dart';
import 'package:outbreak_covid19/core/models/country_model.dart';
import 'package:outbreak_covid19/ui/custom_widgets/virus_loader.dart';
import 'package:outbreak_covid19/utils/image_constants.dart';

class CountrySelector extends StatefulWidget {
  const CountrySelector({Key key, this.countryName}) : super(key: key);
  final countryName;

  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<Country> _countries = List<Country>();
  var items = List<Country>();
  CovidApi api = CovidApi();
  bool _isLoading = false;
  String _selectedLocation;
  String image = ImageConstants.ct_brazil;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  void _fetchCountries() async {
    try {
      setState(() => _isLoading = true);
      var countries = await api.getAllCountriesInfo();
      setState(() {
        _countries = countries;
        items.addAll(_countries);
      });
    } catch (ex) {
      setState(() => _countries = null);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  List<Widget> _buildItems1() {
    return items
        .map((val) => MySelectionItem(
              title: val.country,
            ))
        .toList();
  }

  int selectedIndex1 = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      // padding: EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ImageConstants.colorLightPurple,
        ),
        child: _isLoading
            ? VirusLoader()
            : _countries == null
                ? buildErrorMessage()
                : Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SvgPicture.asset(
                            image,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      DropdownButton(
                        isExpanded: false,
                        underline: Text(''),
                        hint: Text(
                          'Choose',
                          style: TextStyle(
                              color: ImageConstants.colorTextGrossBlack,
                              fontWeight: FontWeight.w600),
                        ), // Not necessary for Option 1
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            api.getCountryByName(_selectedLocation);
                          });
                        },
                        items: items.map((country) {
                          return DropdownMenuItem(
                            child: new Text(
                              country.country,
                              style: TextStyle(
                                  color: ImageConstants.colorTextGrossBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                            value: country.country,
                          );
                        }).toList(),
                      ),
                      Container(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
      ),
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to fetch data',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
