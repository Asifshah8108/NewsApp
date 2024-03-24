// import 'package:flutter/material.dart';
// import 'package:moviesspace/webView.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:moviesspace/savedarticles.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class SourcesScreen extends StatefulWidget {
//   SourcesScreen({super.key});

//   @override
//   State<SourcesScreen> createState() => _SourcesScreenState();
// }

// class _SourcesScreenState extends State<SourcesScreen> {
//   List<dynamic> searchArticle = [];

//   Future<void> fetchQuery() async {
//     final Uri url = Uri.parse(
//         'https://newsapi.org/v2/top-headlines/sources?apiKey=f2cdec3ac00f40ae810fd039b778839d');
//     final searchData = await http.get(url);
//     if (searchData.statusCode == 200) {
//       setState(() {
//         searchArticle = json.decode(searchData.body)['sources'];
//       });
//     } else {
//       throw Exception('Failed to load news');
//     }
//   }
//   Future<String> fetchLogoUrl(String domain) async {
//   final clearbitLogoApiUrl = 'https://logo.clearbit.com/$domain';
//   final response = await http.get(Uri.parse(clearbitLogoApiUrl));

//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, return the logo URL.
//     return clearbitLogoApiUrl;
//   } else {
//     // If the server did not return a 200 OK response,
//     // throw an exception or return a default logo.
//     throw Exception('Failed to load logo');
//   }
// }

//   @override
//   void initState() {
//     super.initState();
//     fetchQuery(); // Call fetchQuery when the widget is initialized
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Sources"),
//         ),
//         body: Column(
//           children: [
//             // searchArticle.isEmpty
//             //     ? CircularProgressIndicator()
//             //     :
//             Expanded(
//               child:
//               //  ListView.builder(
//               //     itemCount: searchArticle.length,
//               //     itemBuilder: (context, index) {
//               //       final faviconUrl = '${searchArticle[index]['url']}/favicon.ico';
//               //       return
//               //           //   Row(
//               //           // children: [
//               //           // searchArticle[index]['url'] !=null && searchArticle[index].url.isNotEmpty ?
//               //           // Image.network(searchArticle[index]['url'],
//               //           // width: 80,
//               //           //         height: 80,
//               //           //         fit: BoxFit.cover,):Container(
//               //           //         height: 80,
//               //           //         width: 80,
//               //           //         color: Colors.grey,
//               //           //         child: Icon(Icons.image),
//               //           //       ),

//               //           Expanded(
//               //         child: InkWell(
//               //           onTap: (() {
//               //             Navigator.push(
//               //                 context,
//               //                 MaterialPageRoute(
//               //                     builder: (context) => WebView(
//               //                           url: searchArticle[index]['url'],
//               //                         )));
//               //           }),
//               //           child: ListTile(
//               //             leading: CachedNetworkImage(
//               //               imageUrl: fetchLogoUrl(searchArticle[index]['url']),
//               //               width: 80,
//               //               height: 80,
//               //               placeholder: (context, url) => Container(
//               //                 width: 80,
//               //                 height: 80,
//               //                 color: Colors
//               //                     .grey[200], // Placeholder color while loading
//               //               ),
//               //             ),
//               //             //searchArticle[index]['url'] != null

//               //             //     ? Image.network(
//               //             //         searchArticle[index]['url'],
//               //             //         width: 80,
//               //             //         height: 80,
//               //             //         fit: BoxFit.cover,
//               //             //       )
//               //             //     : Container(
//               //             //         height: 80,
//               //             //         width: 80,
//               //             //         color: Colors.grey,
//               //             //         child: Icon(Icons.image),
//               //             //       ),
//               //             title: Text(searchArticle[index]['name']),
//               //             subtitle: Text(searchArticle[index]['description']),
//               //           ),
//               //         ),
//               //       );
//               //       //   ],
//               //       // );
//               //     }),
//             ),
//           ],
//         ));
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/webView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moviesspace/savedarticles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SourcesScreen extends StatefulWidget {
  SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  List<dynamic> searchArticle = [];

  Future<void> fetchQuery() async {
    final Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines/sources?apiKey=f2cdec3ac00f40ae810fd039b778839d');
    final searchData = await http.get(url);
    if (searchData.statusCode == 200) {
      setState(() {
        searchArticle = json.decode(searchData.body)['sources'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<String> fetchLogoUrl(String domain) async {
    final clearbitLogoApiUrl = 'https://logo.clearbit.com/$domain';
    final response = await http.get(Uri.parse(clearbitLogoApiUrl));

    if (response.statusCode == 200) {
      return clearbitLogoApiUrl;
    } else {
      return 'https://via.placeholder.com/80'; // Return a default placeholder if the logo can't be loaded
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
        title: Text("Sources"),
      ),
      body: Column(
        children: [
          Expanded(
            child:searchArticle.isEmpty?Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.signal_wifi_connected_no_internet_4_rounded,size: 200,),
                SizedBox(height: 10,),
                Text("No Internet Connection Available !!!",style:GoogleFonts.lato( fontSize: 20,)),

              ],
            )) :ListView.builder(
              itemCount: searchArticle.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebView(
                                  url: searchArticle[index]['url'],
                                )));
                  }),
                  child: ListTile(
                    leading: FutureBuilder<String>(
                      future: fetchLogoUrl(Uri.parse(searchArticle[index]['url']).host),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: Icon(Icons.error),
                            );
                          } else {
                            return CachedNetworkImage(
                              imageUrl: snapshot.data!,
                              width: 80,
                              height: 80,
                              placeholder: (context, url) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            );
                          }
                        } else {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[200],
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    title: Text(searchArticle[index]['name']),
                    subtitle: Text(searchArticle[index]['description']),
                  ),
                );
              }),
          ),
        ],
      ),
    );
  }
}