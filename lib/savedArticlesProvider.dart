// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:moviesspace/Model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SavedArticlesProvider extends ChangeNotifier {
//   late List<NewsArticle> _savedArticles;

//   SavedArticlesProvider() {
//     _savedArticles = [];
//     _loadSavedArticles();
//   }

//   List<NewsArticle> get savedArticles => _savedArticles;

// Future<void> _loadSavedArticles() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? savedArticlesJson = prefs.getString('saved_articles');

//   print('Saved articles JSON: $savedArticlesJson');

//   if (savedArticlesJson != null && savedArticlesJson.isNotEmpty) {
//     try {
//       final List<dynamic> decodedData = json.decode(savedArticlesJson);

//       _savedArticles = decodedData
//           .whereType<Map<String, dynamic>>() // Filter out non-map elements
//           .map((articleJson) =>
//               NewsArticle.fromJson(articleJson as Map<String, dynamic>))
//           .toList();
//     } catch (e) {
//       print('Error decoding saved articles JSON: $e');
//       // Handle decoding error, e.g., by resetting saved articles
//       _savedArticles = [];
//     }
//   } else {
//     // If savedArticlesJson is null or empty, set _savedArticles to an empty list
//     print('No saved articles found.');
//     _savedArticles = [];
//   }

//   notifyListeners();
// }

//   Future<void> _saveArticlesToPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String savedArticlesJson =
//         json.encode(_savedArticles.map((article) => article.toJson()).toList());
//     await prefs.setString('saved_articles', savedArticlesJson);
//   }

//   void saveArticle(NewsArticle article) {
//     _savedArticles.add(article);
//     _saveArticlesToPrefs();
//     notifyListeners();
//   }

//   void removeArticle(NewsArticle article) {
//     _savedArticles.remove(article);
//     _saveArticlesToPrefs();
//     notifyListeners();
//   }

//   bool isArticleSaved(NewsArticle article) {
//     return _savedArticles.contains(article);
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moviesspace/Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SavedArticlesProvider extends ChangeNotifier {
  late List<NewsArticle> _savedArticles;

  SavedArticlesProvider() {
    _savedArticles = [];
    _loadSavedArticles(); // Load saved articles when the provider is initialized
  }

  List<NewsArticle> get savedArticles => _savedArticles;

  Future<void> _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedArticlesJson = prefs.getString('saved_articles');

    if (savedArticlesJson != null && savedArticlesJson.isNotEmpty) {
      try {
        final List<dynamic> decodedData = json.decode(savedArticlesJson);

        _savedArticles = decodedData
            .map((articleJson) => NewsArticle.fromJson(articleJson))
            .toList();

        notifyListeners(); // Notify listeners after loading saved articles
      } catch (e) {
        print('Error decoding saved articles JSON: $e');
        _savedArticles = []; // Reset saved articles if there's a decoding error
      }
    } else {
      print('No saved articles found.');
      _savedArticles = [];
    }
  }
  Future<void> loadSavedArticles() async {
    await _loadSavedArticles();
  }

  Future<void> _saveArticlesToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedArticlesJson =
        json.encode(_savedArticles.map((article) => article.toJson()).toList());
    await prefs.setString('saved_articles', savedArticlesJson);
  }

  void saveArticle(NewsArticle article) {
    if (!_savedArticles.contains(article)) {
      _savedArticles.add(article); // Only add the article if it's not already saved
      _saveArticlesToPrefs();
      notifyListeners(); // Notify listeners after saving the article
    }
  }

  void removeArticle(NewsArticle article) {
    // _savedArticles.remove(article);
    // _saveArticlesToPrefs();
    // notifyListeners();
    _savedArticles.removeWhere((savedArticle) => savedArticle.url == article.url);
  _saveArticlesToPrefs(); // Update SharedPreferences
  notifyListeners();  // Notify listeners after removing the article
  }

  bool isArticleSaved(NewsArticle article) {
  return _savedArticles.any((savedArticle) => savedArticle.url == article.url);
}
void toggleArticleSaveStatus(NewsArticle article,context) {
  if (isArticleSaved(article)) {
    _savedArticles.removeWhere((savedArticle) => savedArticle.url == article.url);
    showTopSnackBar(
        dismissType: DismissType.onSwipe,
    Overlay.of(context),
    CustomSnackBar.error(
      message:
          "News Removed from Saved News",
    ),
);
  } else {
    _savedArticles.add(article);
    showTopSnackBar(
        dismissType: DismissType.onSwipe,
    Overlay.of(context),
    CustomSnackBar.success(
      message:
          "News Added to Saved News",)
          );
  }
  _saveArticlesToPrefs(); // This method should update SharedPreferences
  notifyListeners(); // This should trigger UI updates
}
//  Future<bool> isArticleSaved(NewsArticle article) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//  return prefs.containsKey(article.url);
  // }
}