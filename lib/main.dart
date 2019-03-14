import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Welcome to flutter",
      theme: new ThemeData(primaryColor: Colors.green),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _list = <WordPair>[];
  final TextStyle _style = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _set = new Set<WordPair>();

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _set.map((WordPair pair) {
          return new ListTile(
              title: new Text(pair.asPascalCase, style: _style));
        });
        final List<Widget> divider =
            ListTile.divideTiles(tiles: tiles, context: context).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Saved suggestions"),
          ),
          body: new ListView(children: divider),
        );
      }),
    );
  }

  Widget _getRandomWords() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) {
          return new Divider();
        }
        final int i = index ~/ 2;
        if (i >= _list.length) {
          _list.addAll(generateWordPairs().take(10));
        }
        return _getListTile(_list[i]);
      },
    );
  }

  Widget _getListTile(WordPair words) {
    bool _isSaved = _set.contains(words);
    return new ListTile(
      title: new Text(
        words.asPascalCase,
        style: _style,
      ),
      trailing: new Icon(
        _isSaved ? Icons.favorite : Icons.favorite_border,
        color: _isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_isSaved) {
            _set.remove(words);
          } else {
            _set.add(words);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Welcome to flutter"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _getRandomWords());
  }
}
