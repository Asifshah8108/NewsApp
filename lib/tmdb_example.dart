// // // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:video_player/video_player.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'TMDb Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MovieListPage(),
// //     );
// //   }
// // }

// // class MovieListPage extends StatefulWidget {
// //   @override
// //   _MovieListPageState createState() => _MovieListPageState();
// // }

// // class _MovieListPageState extends State<MovieListPage> {
// //   final String apiKey = '43fc67ff70f7116ed18e8416b5348c82';
// //   final String baseUrl = 'https://api.themoviedb.org/3';
// //   final String popularMoviesEndpoint = '/movie/popular';

// //   List<dynamic> movies = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchPopularMovies();
// //   }

// //   Future<void> fetchPopularMovies() async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl$popularMoviesEndpoint?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       setState(() {
// //         movies = jsonDecode(response.body)['results'];
// //       });
// //     } else {
// //       throw Exception('Failed to load popular movies');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Popular Movies'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: movies.length,
// //         itemBuilder: (context, index) {
// //           final movie = movies[index];
// //           return ListTile(
// //             title: Text(movie['title']),
// //             subtitle: Text('Rating: ${movie['vote_average']}'),
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => MovieDetailsPage(movie: movie),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class MovieDetailsPage extends StatefulWidget {
// //   final dynamic movie;
// //   const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

// //   @override
// //   State<MovieDetailsPage> createState() => _MovieDetailsPageState();
// // }

// // class _MovieDetailsPageState extends State<MovieDetailsPage> {
// //   late VideoPlayerController _controller;
// //   late Future<void> _initializeVideoPlayerFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.network('');
// //     _initializeVideoPlayerFuture = _controller.initialize();
// //     _controller.setLooping(true);
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var movieid = widget.movie['id'];
// //     var posterPath = widget.movie['poster_path'];
// //     var backdropPath = widget.movie['backdrop_path'];
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.movie['title']),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: Row(
// //                 children: [
// //                   Image.network(
// //                     'https://image.tmdb.org/t/p/w500$posterPath',
// //                     fit: BoxFit.fitWidth,
// //                     height: 300,
// //                     width: 300,
// //                   ),
// //                   SizedBox(
// //                     width: 5,
// //                   ),
// //                   Image.network(
// //                     'https://image.tmdb.org/t/p/w500$backdropPath',
// //                     fit: BoxFit.fill,
// //                     height: 300,
// //                     width: 300,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Text('Title: ${widget.movie['title']}'),
// //             Text('Rating: ${widget.movie['vote_average']}'),
// //             Text('Overview: ${widget.movie['overview']}'),
// //             Text('Release Date: ${widget.movie['release_date']}'),
// //             Text('Genre: ${widget.movie['genre_ids'][0]}'),
// //             Text('Poster Path: ${widget.movie['poster_path']}'),
// //             Text('Backdrop Path: ${widget.movie['backdrop_path']}'),
// //             Text('Original Title: ${widget.movie['original_title']}'),
// //             Text('Original Language: ${widget.movie['original_language']}'),
// //             Text('Popularity: ${widget.movie['popularity']}'),
// //             Text('Vote Count: ${widget.movie['vote_count']}'),
// //             Text('id: ${widget.movie['id']}'),
// //             ElevatedButton(
// //               onPressed: () {
// //                 _playMovieVideo(context, movieid);
// //               },
// //               child: Text('Play Video'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _playMovieVideo(BuildContext context, int movieId) async {
// //     // final videoUrl = await _fetchMovieVideoUrl(movieId);
// //     String videoUrl = await _fetchMovieVideoUrl(movieId) ?? '';

// //     _controller = VideoPlayerController.network(videoUrl);
// //     _initializeVideoPlayerFuture = _controller.initialize();
// //     await showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         content: FutureBuilder(
// //           future: _initializeVideoPlayerFuture,
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.done) {
// //               return AspectRatio(
// //                 aspectRatio: _controller.value.aspectRatio,
// //                 child: VideoPlayer(_controller),
// //               );
// //             } else {
// //               return Center(child: CircularProgressIndicator());
// //             }
// //           },
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //               _controller.pause();
// //             },
// //             child: Text('Close'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<String?> _fetchMovieVideoUrl(int movieId) async {
// //     final String apiKey = '43fc67ff70f7116ed18e8416b5348c82';
// //     final String baseUrl = 'https://api.themoviedb.org/3';
// //     final String videosEndpoint = '/movie/$movieId/videos';

// //     final response = await http.get(
// //       Uri.parse('$baseUrl$videosEndpoint?api_key=$apiKey'),
// //     );

// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);
// //       final videos = data['results'] as List<dynamic>;
// //       if (videos.isNotEmpty) {
// //         final video = videos[0]; // Select the first video
// //         final String videoKey = video['key'];
// //         final String site = video['site'];
// //         if (site == 'YouTube') {
// //           return 'https://www.youtube.com/watch?v=$videoKey';
// //         } else {
// //           final String videoBaseUrl =
// //               'https://api.themoviedb.org/3/movie/$movieId';
// //           final String videoUrlEndpoint = '/videos';
// //           final videoUrlResponse = await http.get(
// //             Uri.parse('$videoBaseUrl$videoUrlEndpoint?api_key=$apiKey'),
// //           );
// //           final videoData = jsonDecode(videoUrlResponse.body);
// //           final String videoUrl = videoData['results'][0]['key'];
// //           return videoUrl;
// //         }
// //       } else {
// //         return null; // No videos found for the movie
// //       }
// //     } else {
// //       throw Exception('Failed to load movie videos');
// //     }
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TMDb Movie App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MovieListPage(),
//     );
//   }
// }

// class MovieListPage extends StatefulWidget {
//   @override
//   _MovieListPageState createState() => _MovieListPageState();
// }

// class _MovieListPageState extends State<MovieListPage> {
//   final String apiKey = '43fc67ff70f7116ed18e8416b5348c82';
//   final String baseUrl = 'https://api.themoviedb.org/3';
//   final String popularMoviesEndpoint = '/movie/popular';

//   List<dynamic> movies = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchPopularMovies();
//   }

//   Future<void> fetchPopularMovies() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl$popularMoviesEndpoint?api_key=$apiKey'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         movies = jsonDecode(response.body)['results'];
//       });
//     } else {
//       throw Exception('Failed to load popular movies');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Popular Movies'),
//       ),
//       body: ListView.builder(
//         itemCount: movies.length,
//         itemBuilder: (context, index) {
//           final movie = movies[index];
//           return ListTile(
//             title: Text(movie['title']),
//             subtitle: Text('Rating: ${movie['vote_average']}'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MovieDetailsPage(movie: movie, apiKey: apiKey),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class MovieDetailsPage extends StatefulWidget {
//   final dynamic movie;
//   final String apiKey;

//   const MovieDetailsPage({Key? key, required this.movie, required this.apiKey})
//       : super(key: key);

//   @override
//   _MovieDetailsPageState createState() => _MovieDetailsPageState();
// }

// class _MovieDetailsPageState extends State<MovieDetailsPage> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   void _initializeVideoPlayer() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://api.themoviedb.org/3/movie/${widget.movie['id']}/videos?api_key=${widget.apiKey}'),
//     );

//     if (response.statusCode == 200) {
//       final videoData = jsonDecode(response.body)['results']
//           .firstWhere((video) => video['site'] == 'YouTube', orElse: () => null);
//       if (videoData != null) {
//         final videoKey = videoData['key'];
//         _controller = YoutubePlayerController(
//           initialVideoId: videoKey,
//           flags: YoutubePlayerFlags(
//             autoPlay: true,
//             mute: false,
//           ),
//         );
//         setState(() {});
//       } else {
//         throw Exception('No YouTube video found for this movie');
//       }
//     } else {
//       throw Exception('Failed to load video data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.movie['title']),
//       ),
//       body: _controller != null
//           ? YoutubePlayer(
//               controller: _controller,
//               showVideoProgressIndicator: true,
//               onReady: () {
//                 _controller.addListener(() {});
//               },
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }