import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/savedArticlesProvider.dart';
import 'package:provider/provider.dart';
import 'package:theme_patrol/theme_patrol.dart';



class ChipsApp extends StatelessWidget {
final Function(String) onCategorySelected;

  const ChipsApp({Key? key, required this.onCategorySelected}) : super(key: key);


  

  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      light: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.red,
        ),
        // materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.red,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chips Choice',
          theme: theme.lightData,
          darkTheme: theme.darkData,
          themeMode: theme.mode,
          home: MyHomePage(onCategorySelected: onCategorySelected),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
 final Function(String) onCategorySelected;

  const MyHomePage({Key? key, required this.onCategorySelected}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
  
}

class MyHomePageState extends State<MyHomePage> {
  
  // single choice value
  int tag = 0;

  // list of string options
  List<String> options = [
    'Top Headlines',
    'Entertainment',
    'Sports',
    'Business',
    'Technology',
    'Science',
    'General',
    'Health'
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     //WidgetsBinding.instance.addPostFrameCallback((_) {
    //Provider.of<SavedArticlesProvider>(context, listen: false).loadSavedArticles();
 // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: <Widget>[
                  Content(
                    title: 'Single Choice',
                    child: ChipsChoice<int>.single(
                         onChanged: (val) {
                        setState(() {
                          tag = val;
                        });
                        widget.onCategorySelected(options[val]);
                      },
                      value: tag,
                      // onChanged: (val) => setState(() => tag = val),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.filled(
                        selectedStyle: const C2ChipStyle(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(onPressed: (){

                  // }, icon:const Icon(Icons.keyboard_arrow_up_outlined))
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  const Content({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.title,
              style:  GoogleFonts.lato(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:chips_choice/chips_choice.dart';
// import 'package:theme_patrol/theme_patrol.dart';

// class Home extends StatelessWidget {
//   const Home({super.key,required this.onCategorySelected});
//   final Function(String) onCategorySelected;


//   @override
//   Widget build(BuildContext context) {
//     return ThemePatrol(
//       light: ThemeData(
//         brightness: Brightness.light,
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.light,
//           seedColor: Colors.red,
//         ),
//         // materialTapTargetSize: MaterialTapTargetSize.padded,
//       ),
//       dark: ThemeData(
//         brightness: Brightness.dark,
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.dark,
//           seedColor: Colors.red,
//         ),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         // materialTapTargetSize: MaterialTapTargetSize.padded,
//       ),
//       builder: (context, theme) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Chips Choice',
//           theme: theme.lightData,
//           darkTheme: theme.darkData,
//           themeMode: theme.mode,
//           home: ChipsApp(onCategorySelected: onCategorySelected),
//         );
//       },
//     );
//   }
// }

// class ChipsApp extends StatelessWidget {
//   final Function(String) onCategorySelected;

//   const ChipsApp({Key? key, required this.onCategorySelected}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChipsChoice<String>.single(
//       value: 'Top Headlines', // Default category selected
//       onChanged: onCategorySelected,
//       choiceItems: C2Choice.listFrom<String, String>(
//         source: [
//           'Top Headlines',
//     'Entertainment',
//     'Sports',
//     'Politics',
//     'Business',
//     'Technology',
//     'Science',
//     'General',
//     'Health'
//         ],
//         value: (i, v) => v,
//         label: (i, v) => v,
//       ),


// // choiceCheckmark: true,
// //       choiceStyle: C2ChipStyle.filled(
// //         color: Colors.grey, // Unselected chip color
// //         // brig: Brightness.dark, // Unselected chip text color
// //         selectedStyle: const C2ChipStyle(
// //           borderRadius: BorderRadius.all(
// //             Radius.circular(25),
// //           ),
// //           backgroundColor: Colors.blue,
// //            // Selected chip color
// //           // brightness: Brightness.light, // Selected chip text color
// //         ), 
// //       ),

//     choiceCheckmark: true,
//                       choiceStyle: C2ChipStyle.filled(
//                         selectedStyle: const C2ChipStyle(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(25),
//                           ),
//                         ),
//                       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';



// class ChipsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int? _value = 0;
//   List<String> _options = [
//     'Top Headlines',
//     'Entertainment',
//     'Sports',
//     'Business',
//     'Technology',
//     'Science',
//     'General',
//     'Health',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: Text('Flutter Chips Demo'),
//       ),
//       body: ListView(
//         children: [
//           Wrap(
//             spacing: 8.0,
//             children: List<Widget>.generate(
//               _options.length,
//               (int index) {
//                 return ChoiceChip(
//                   label: Text(_options[index]),
//                   selected: _value == index,
//                   onSelected: (bool selected) {
//                     setState(() {
//                       _value = selected ? index : null;
//                     });
//                   },
//                   backgroundColor: Colors.grey.shade200,
//                   selectedColor: Colors.blue.shade700,
//                   labelStyle: TextStyle(
//                     color: _value == index ? Colors.white : Colors.black,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 );
//               },
//             ).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }


