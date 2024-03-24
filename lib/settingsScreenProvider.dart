import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreenProvider extends ChangeNotifier {
  SettingsScreenProvider({required this.countries}) {
    _loadSelectedCountry();
  }

  final List<String> countries;
  late String _selectedCountry;

  String get selectedCountry => _selectedCountry;

  Future<void> _loadSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedCountry = prefs.getString('selectedCountry') ?? 'in'; // Default country is 'gb'
    notifyListeners();
  }

  Future<void> changeCountry(String country) async {
    _selectedCountry = country;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountry', country);
  }
}
