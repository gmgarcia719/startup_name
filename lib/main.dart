// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());
/*StatelessWidget
##Makes the app itself a widget widget
##Most everything is a Widget   
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*WordPair 
      ##Avalaible becasue we imported the english word package
    */
    //final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Startup Name Generator',
      /*Scafflod
        ##From the Marerial Library
        ##Provides a default bar, title, and body propery that holds the sidget tree for the home screen
      */
      home: RandomWords(),
    );
  }
}

/* Stateful Widget
  ##Need at least 2 classes
  ####StatefulWidget Class
  ####State class
  ##StatefulWidget Class creates an instance of a State Class
*/
class RandomWordsState extends State<RandomWords>{
  final List<WordPair>_suggestions = <WordPair>[];
  //Set does not allow duplicate entries 
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);  
  
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      });
  }

  
  Widget _buildRow(WordPair pair){
    //Makes sure that word pairing  has not already been added to favorites.
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
      );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}