import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:moviesspace/Auth/Provider/auth_provider.dart';
import 'package:moviesspace/Auth/screens/login_screen.dart';
import 'package:moviesspace/Model.dart';
import 'package:moviesspace/articlescreen.dart';
import 'package:moviesspace/chips.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:moviesspace/firebase_options.dart';
import 'package:moviesspace/profileScreen.dart';
import 'package:moviesspace/savedArticlesProvider.dart';
import 'package:moviesspace/searchScreen.dart';
import 'package:moviesspace/settingsScreenProvider.dart';
import 'package:moviesspace/sideDrawer.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SavedArticlesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsScreenProvider(countries: [
        'ae',
        'ar',
        'at',
        'au',
        'be',
        'bg',
        'br',
        'ca',
        'ch',
        'cn',
        'co',
        'cu',
        'cz',
        'de',
        'eg',
        'fr',
        'gb',
        'gr',
        'hk',
        'hu',
        'id',
        'ie',
        'il',
        'in',
        'it',
        'jp',
        'kr',
        'lt',
        'lv',
        'ma',
        'mx',
        'my',
        'ng',
        'nl',
        'no',
        'nz',
        'ph',
        'pl',
        'pt',
        'ro',
        'rs',
        'ru',
        'sa',
        'se',
        'sg',
        'si',
        'sk',
        'th',
        'tr',
        'tw',
        'ua',
        'us',
        've',
        'za'
        //     'United Arab Emirates',
        // 'Argentina',
        // 'Austria',
        // 'Australia',
        // 'Belgium',
        // 'Bulgaria',
        // 'Brazil',
        // 'Canada',
        // 'Switzerland',
        // 'China',
        // 'Colombia',
        // 'Cuba',
        // 'Czech Republic',
        // 'Germany',
        // 'Egypt',
        // 'France',
        // 'United Kingdom (Great Britain)',
        // 'Greece',
        // 'Hong Kong',
        // 'Hungary',
        // 'Indonesia',
        // 'Ireland',
        // 'Israel',
        // 'India',
        // 'Italy',
        // 'Japan',
        // 'South Korea (Republic of Korea)',
        // 'Lithuania',
        // 'Latvia',
        // 'Morocco',
        // 'Mexico',
        // 'Malaysia',
        // 'Nigeria',
        // 'Netherlands',
        // 'Norway',
        // 'New Zealand',
        // 'Philippines',
        // 'Poland',
        // 'Portugal',
        // 'Romania',
        // 'Serbia',
        // 'Russia',
        // 'Saudi Arabia',
        // 'Sweden',
        // 'Singapore',
        // 'Slovenia',
        // 'Slovakia',
        // 'Thailand',
        // 'Turkey',
        // 'Taiwan',
        // 'Ukraine',
        // 'United States of America',
        // 'Venezuela',
        // 'South Africa',
      ]),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthScreenProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<AuthScreenProvider>(
    //   builder: (context, value, child) => MaterialApp(
    //     navigatorKey: navigatorKey,
    //     title: 'News App',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //     ),
    //     home: value.isLoggedIn ? NewsScreen() : const LoginScreen(),
    //     routes: {
    //       '/news': (context) => NewsScreen(),
    //       '/login': (context) => LoginScreen(),
    //       '/profile': (context) => ProfilePage(),
    //       // Define other routes as needed
    //     },
    //   ),
    // );

    return Consumer<AuthScreenProvider>(
      builder: (context, authProvider, child) {
        // Check if the authentication process has completed
        if (authProvider.isLoading) {
          // If authentication check is in progress, show a loading indicator
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          // If authentication check is completed, navigate to appropriate screen
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'News App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: authProvider.isLoggedIn ? NewsScreen() : LoginScreen(),
            routes: {
              '/news': (context) => NewsScreen(),
              '/login': (context) => LoginScreen(),
              '/profile': (context) => ProfilePage(),
              // Define other routes as needed
            },
          );
        }
      },
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = 'f2cdec3ac00f40ae810fd039b778839d';
  // final String country = 'in';
  List<dynamic> articles = [];
  String selectedCategory = 'General'; // Default selected category
  String? query;
  TextEditingController _controller = TextEditingController();
  List<NewsArticle> savedArticles = [];
  bool offline = false;
  StreamSubscription? internetConnection;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    Provider.of<SettingsScreenProvider>(context, listen: false)
        .removeListener(_onCountryChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  
    internetConnection = Connectivity().onConnectivityChanged.listen((result) {
    if (result == ConnectivityResult.none) {
      // Show icon or message for no internet connection
      setState(() {
        offline = true;
      });
    }else{
      setState(() {
        offline = false;
      });
    }
  });
  
    fetchArticles();

    // AuthScreenProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SavedArticlesProvider>(context, listen: false)
          .loadSavedArticles();
    });

    Provider.of<SettingsScreenProvider>(context, listen: false)
        .addListener(_onCountryChanged);
  }

  void _onCountryChanged() {
    // Reload data when the selected country changes
    fetchArticles();
  }

  Future<void> fetchArticles({String? category}) async {
    final String country =
        Provider.of<SettingsScreenProvider>(context, listen: false)
            .selectedCountry;

    String apiUrl;
    if (category != null && category.toLowerCase() == 'top headlines') {
      // For "Top Headlines", we fetch articles for the "general" category
      apiUrl =
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
    } else if (category != null) {
      // For other categories, use the provided category parameter
      apiUrl =
          'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey';
    } else {
      // If no category is provided, fetch top headlines without specifying a category
      apiUrl =
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
    }
    print('Fetching news from $apiUrl...');
    final Uri url = Uri.parse(apiUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // setState(() {
      //   articles = json.decode(response.body)['articles'];
      // });

      final List<dynamic> articlesJson = json.decode(response.body)['articles'];
      setState(() {
        articles =
            articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  void onCategorySelected(String category) {
    print('Selected Category: $category');
    setState(() {
      selectedCategory = category;
    });

    if (category == 'Top Headlines') {
      print('Fetching top headlines...');
      fetchArticles(); // Fetch top headlines without specifying a category
    } else {
      print('Fetching articles for category: $category');
      fetchArticles(
          category: category); // Fetch articles with selected category
    }
  }

  final GlobalKey<SideMenuState> _sideMenuKey =
      GlobalKey<SideMenuState>(); // List to store saved articles' titles

  @override
  Widget build(BuildContext context) {
    final savedArticlesProvider = Provider.of<SavedArticlesProvider>(context);
    final authProv = Provider.of<AuthScreenProvider>(context, listen: true);

    return SideMenu(
      key: _sideMenuKey,
      menu: SideDrawer(),
      type: SideMenuType.shrinkNSlide,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              final _state = _sideMenuKey.currentState;
              if (_state!.isOpened)
                _state.closeSideMenu(); // close side menu
              else
                _state.openSideMenu(); // open side menu
            },
          ),
          title: AnimatedSearchBar(
              label: 'Top Headlines',
              controller: _controller,
              labelStyle: const TextStyle(fontSize: 16),
              searchStyle: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              searchDecoration: const InputDecoration(
                hintText: 'Search',
                alignLabelWithHint: true,
                fillColor: Colors.black,
                focusColor: Colors.black,
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  query = value;
                });
                debugPrint('value on Field Submitted: $query');
                if (query!.isNotEmpty && query != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          SearchScreen(query: query, apikey: apiKey)));
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  return;
                }
              }),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChipsApp(
                onCategorySelected: onCategorySelected,
              ),
            ),
                articles.isEmpty?
                Center(
                  child:
                    Flexible(fit: FlexFit.tight,
                      child: Column(
                        
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Icon(Icons.signal_wifi_connected_no_internet_4_rounded,size: 150,),
                                     
                                       Text("No Internet Connection Available !!!",style:GoogleFonts.lato( fontSize: 20,)
                                       ),
                                        SizedBox(height: 250,),
                       
                                     ],
                                   ),
                    ),
                   
            ) 
            :
                Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        final title = article.title;
                        final isSaved =
                            savedArticlesProvider.isArticleSaved(article);
                        final description = article.description;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleScreen(article: article),
                              ),
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 5,
                            child: Column(
                              children: [
                                Stack(children: [
                                  // article['urlToImage']
                                  article.urlToImage != null &&
                                          article.urlToImage.isNotEmpty
                                      ? Image.network(
                                          // article['urlToImage'],
                                          article.urlToImage,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          color: Colors.grey,
                                          child: Icon(
                                            Icons.image,
                                          ),
                                        ),
                                  Positioned(
                                      top: 8.0,
                                      right: 8.0,
                                      child: Consumer<SavedArticlesProvider>(
                                        builder: (context,
                                            savedArticlesProvider, child) {
                                          final isSaved = savedArticlesProvider
                                              .isArticleSaved(article);
                                          return IconButton(
                                            icon: Icon(
                                              isSaved
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                            ),
                                            onPressed: () {
                                              savedArticlesProvider
                                                  .toggleArticleSaveStatus(
                                                      article, context);
                                            },
                                          );
                                        },
                                      )
                                      // IconButton(
                                      //                   icon: isSaved
                                      //                   // savedArticlesProvider.savedArticles.contains(article.title)
                                      //                   // savedArticlesProvider.savedArticles
                                      //                   //         .contains(article)
                                      //                       ? Icon(Icons.bookmark)
                                      //                       : Icon(Icons.bookmark_border),
                                      //                   onPressed: () {
                                      //                     // setState(() {
                                      //                     //   if (savedArticlesProvider
                                      //                     //       .isArticleSaved(article)) {
                                      //                     //     savedArticlesProvider
                                      //                     //         .removeArticle(article);
                                      //                     //   } else {
                                      //                     //     savedArticlesProvider
                                      //                     //         .saveArticle(article);
                                      //                     //   }
                                      //                     // });
                                      //                     if (isSaved) {
                                      //   savedArticlesProvider.removeArticle(article);
                                      // } else {
                                      //   savedArticlesProvider.saveArticle(article);
                                      // }
                                      //                   },
                                      //                 )
                                      ),
                                ]),
                                Text(
                                  // article['title'],
                                  article.title,
                                  style: GoogleFonts.lato(fontSize: 15),
                                ),
                                Text(
                                  // article['description']
                                  article.description ?? '',
                                  style: GoogleFonts.lato(
                                    fontSize: 13,
                                  ),
                                ),
                                // Positioned(
                                //  bottom: MediaQuery.of(context).padding.bottom,
                                //   right: MediaQuery.of(context).padding.right,
                                // child:
                                //                        IconButton(onPressed: (){}, icon:const Icon(Icons.send,
                                // // textDirection: TextDirection.ltr,
                                //  color: Colors.black, size: 30)),
                                // //  ),
                                //
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
