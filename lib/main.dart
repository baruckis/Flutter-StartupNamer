import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // Use arrow notation for one-line method.

class MyApp extends StatelessWidget {
  // This widget is the root of your application. It makes the app itself a
  // widget. In Flutter, almost everything is a widget, including alignment,
  // padding, and layout.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
       home: MyHomePage(title: 'Startup Name Generator'),

    );
  }
}

// Stateful widgets maintain state that might change during the lifetime of
// the widget. The StatefulWidget class is, itself, immutable, but the State
// class persists over the lifetime of the widget.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // For saving suggested word pairings.
  final _suggestions = <WordPair>[];

  // Set stores the word pairings that the user favored.
  final Set<WordPair> _saved = Set<WordPair>();

  // Variable for making the font size larger.
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // A basic build method that generates the word pairs.
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row. For even rows, the
        // function adds a ListTile row for the word pairing. For odd rows, the
        // function adds a Divider widget to visually separate the entries.
        // Note that the divider might be difficult to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in the ListView.
          if (i.isOdd) return Divider();

          // The expression i ~/ 2 divides i by 2 and returns an integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates
          // the actual number of word pairings in the ListView, minus the
          // divider widgets.
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            // If you’ve reached the end of the available word pairings, then
            // generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {

    // Check to ensure that a word pairing has not already been added to
    // favorites.
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // Add heart-shaped icons to the ListTile objects to enable favoring.
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // When the user taps an entry in the list, toggling its "favored" state,
      // that word pairing is added or removed from a set of saved favorites.
      onTap: () {
        // Notify the framework that state has changed. In Flutter's reactive
        // style framework, calling setState() triggers a call to the build()
        // method for the State object, resulting in an update to the UI.
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // Scaffold implements the basic Material Design visual layout.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildSuggestions(),
    );
  }

}
