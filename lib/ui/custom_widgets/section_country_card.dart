import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outbreak_covid19/utils/image_constants.dart';

class SectionCountryCard extends StatelessWidget {
  const SectionCountryCard(
      {Key key, this.countryName, this.numCases, this.image, this.onTap});
  final countryName;
  final numCases;
  final image;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onTap,
          child: Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SvgPicture.asset(
                    //   image,
                    //   width: 60,
                    //   height: 60,
                    //   color: Colors.white,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            countryName,
                            style: TextStyle(
                              color: ImageConstants.colorTextGrossBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                            ),
                          ),
                          Text(
                            numCases,
                            style: TextStyle(
                              color: ImageConstants.colorTextGrossBlack,
                              fontWeight: FontWeight.w300,
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Icon(
                      Icons.arrow_right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
