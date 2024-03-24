import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/savedArticlesProvider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

class ArticleScreen extends StatefulWidget {
  // ArticleScreen({this.article, super.key});
  final article;
  late String formattedPublishedAt;

  ArticleScreen({Key? key, required this.article}) : super(key: key) {
    formattedPublishedAt = formatPublishedAt(article.publishedAt);
  }

  String formatPublishedAt(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    // Format the date and time as desired
    return DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
  }

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final SaveProvider = Provider.of<SavedArticlesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Article',style: GoogleFonts.lato()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.title,
                style:  GoogleFonts.lato(
                    fontSize: 20,
                    textBaseline: TextBaseline.ideographic,
                    fontWeight: FontWeight.bold),
              ),
              widget.article.urlToImage != null && widget.article.urlToImage.isNotEmpty
                  ? Image.network(
                      widget.article.urlToImage,
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
              SizedBox(
                height: 10,
              ),
              Text(
                // 'Published On:' + widget.article['publishedAt'] ?? '',
                'Published On: ' + widget.formattedPublishedAt ?? '',
                style:  GoogleFonts.lato(
                    fontSize: 15,
                    textBaseline: TextBaseline.ideographic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Published By: ' + widget.article.source.name ?? '',
                style:  GoogleFonts.lato(
                    fontSize: 15,
                    textBaseline: TextBaseline.ideographic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.article.description ?? '',
                style: GoogleFonts.lato(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.article.content ?? '',
                style:  GoogleFonts.lato(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            WebViewOpen(article: widget.article))));
                  },
                  child: Text('Read Full Article',style:  GoogleFonts.lato()),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

class WebViewOpen extends StatefulWidget {
  const WebViewOpen({this.article, super.key});
  final article;
  @override
  State<StatefulWidget> createState() {
    return _WebViewOpenState();
  }
}

class _WebViewOpenState extends State<WebViewOpen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            Text('Loading $progress%',style:  GoogleFonts.lato());
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse(widget.article.url)); // Load the provided articleUrl
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article',style:  GoogleFonts.lato()),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
