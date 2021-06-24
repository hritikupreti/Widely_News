import 'package:flutter/material.dart';
import 'home.dart';

class CountryTile extends StatelessWidget {
  final String countryFlag;
  final String countryName;
  final String countryCode;
  CountryTile({this.countryFlag, this.countryName, this.countryCode});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        countryName: countryName.trim(),
                        countryistrue: false,
                        countryCode: countryCode,
                        countryFlag: countryFlag,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Container(
              alignment: Alignment.bottomCenter,
              height: 30,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(countryFlag),
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 15, color: Colors.red),
                child: Text(countryName, style: TextStyle(fontSize: 15)),
              )),
        ));
  }
}
