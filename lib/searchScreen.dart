import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/Model.dart';
import 'package:moviesspace/articlescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.query, this.apikey});
  final query;
  final apikey;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<dynamic> searchArticle = [];
  Future<void> fetchQuery() async {
    final Uri url = Uri.parse(
        'https://newsapi.org/v2/everything?q=${widget.query}&apiKey=${widget.apikey}');
    final searchData = await http.get(url);
    if (searchData.statusCode == 200) {
      // setState(() {
      //   searchArticle = json.decode(searchData.body)['articles'];
      // });
      final List<dynamic> articlesJson = json.decode(searchData.body)['articles'];
      setState(() {
        searchArticle =
            articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
    
  }
@override
  void initState() {
    super.initState();
    fetchQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Result "+" :  "+searchArticle.length.toString(),style: TextStyle(overflow: TextOverflow.fade,fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600,),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: searchArticle.length,
        itemBuilder: (context, index) {
          final article = searchArticle[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleScreen(
                        article:
                            article)),
              );
            },
            child: Column(
              children: [
                article.urlToImage != null && article.urlToImage.isNotEmpty 
                    ? Image.network(
                        article.urlToImage,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        color: Colors.grey,
                        child: Icon(Icons.image),
                      ),
                Text(
                  article.title,
                  style:  GoogleFonts.lato(fontSize: 15),
                ),
                Text(
                  article.description ?? '',
                  style:  GoogleFonts.lato(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
