import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/articlescreen.dart';
import 'package:moviesspace/savedArticlesProvider.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SavedArticlesScreen extends StatelessWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles',style: GoogleFonts.lato()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SavedArticlesProvider>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.savedArticles.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(value.savedArticles[index].title),
                    onDismissed: (direction) {
                      // value.removeArticle(value.savedArticles[index]);
                      Provider.of<SavedArticlesProvider>(context, listen: false)
      .removeArticle(value.savedArticles[index]);

  // Show a snackbar or some confirmation of the dismissal
 showTopSnackBar(
    dismissType: DismissType.onSwipe,
    Overlay.of(context),
    CustomSnackBar.info(
      message:
          "Article removed from saved list",
    ),
);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: Checkbox.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ArticleScreen(
                                article: value.savedArticles[index]),
                          ));
                        },
                        child: Row(children: [
                          value.savedArticles[index].urlToImage != null && value.savedArticles[index].urlToImage.isNotEmpty
                              ? Image.network(
                                  value.savedArticles[index].urlToImage,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.grey,
                                  child: Icon(Icons.image),
                                ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            value.savedArticles[index].title,
                            softWrap: true,
                            style:  GoogleFonts.lato()
                          )),
                          SizedBox(height: 10,)
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
