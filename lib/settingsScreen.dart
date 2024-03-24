import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/settingsScreenProvider.dart';
import 'package:provider/provider.dart';
import 'package:selection_menu/selection_menu.dart';

class SettingsScreeen extends StatefulWidget {
  @override
  State<SettingsScreeen> createState() => _SettingsScreeenState();
}

class _SettingsScreeenState extends State<SettingsScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style:  GoogleFonts.lato(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Consumer<SettingsScreenProvider>(
        builder: (context, provider, _) {
          return Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Country :",
                      style:  GoogleFonts.lato()
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: provider.selectedCountry,
                      onChanged: (newValue) {
                        setState(() {
                          provider.changeCountry(newValue!);
                        });
                      },
                      items: provider.countries.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:  GoogleFonts.lato()),
                          );
                        },
                      ).toList(),
                    ),
                    
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
