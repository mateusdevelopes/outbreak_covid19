import 'package:flutter/material.dart';
import 'package:outbreak_covid19/ui/custom_widgets/dash_navbar.dart';
import 'package:outbreak_covid19/utils/image_constants.dart';
import 'package:outbreak_covid19/core/controllers/api.dart';
import 'package:outbreak_covid19/core/models/country_model.dart';
import 'package:outbreak_covid19/ui/custom_widgets/virus_loader.dart';
import 'package:outbreak_covid19/ui/views/country_details_view.dart';
import 'package:outbreak_covid19/ui/custom_widgets/section_country_card.dart';

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  bool _isLoading = false;
  CovidApi api = CovidApi();
  var items = List<Country>();
  var _focusNode = FocusNode();
  List<Country> _countries = List<Country>();
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  void filterSearchResults(String query) {
    List<Country> dummySearchList = List<Country>();
    dummySearchList.addAll(_countries);
    if (query.isNotEmpty) {
      List<Country> dummyListData = List<Country>();
      dummySearchList.forEach((item) {
        if (item.country.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_countries);
      });
    }
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
            padding: EdgeInsets.only(top: 130),
            child: _isLoading
                ? VirusLoader()
                : _countries == null
                    ? buildErrorMessage()
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Card(
                              child: TextFormField(
                                focusNode: _focusNode,
                                controller: _controller,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    labelText: 'Search',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    hintText: 'Enter country name'),
                                onChanged: filterSearchResults,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                var country = items[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  child: SectionCountryCard(
                                    countryName: country.country,
                                    numCases:
                                        'Cases: ' + country.cases.toString(),
                                    image: ImageConstants.ct_brazil,
                                    onTap: () {
                                      _controller.clear();
                                      filterSearchResults('');
                                      _focusNode.unfocus();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CountryDetailPage(
                                                  countryName: country.country),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
          )
        ],
      ),
    );
  }

  Center buildErrorMessage() {
    return Center(
      child: Text(
        'Unable to fetch data (Não foi possível carregar os dados)',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey),
      ),
    );
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
}
