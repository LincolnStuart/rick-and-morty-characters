import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/api_character.dart';
import 'package:rick_and_morty/character.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _random = Random();
  final _streamControllerCharacter = StreamController<Character>();

  @override
  void initState() {
    super.initState();
    _randomCharacter();
  }

  void _randomCharacter() {
    var future = ApiCharacter.get(_getId());
    future.then((character) {
      _streamControllerCharacter.add(character);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamControllerCharacter.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty\'s Characters',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        brightness: Brightness.light,
        flexibleSpace: Image(
          image: AssetImage('assets/image/background.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomCharacter,
        backgroundColor: Colors.green,
        child: Icon(Icons.refresh),
      ),
    );
  }

  _body() {
    return StreamBuilder(
      stream: _streamControllerCharacter.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return _cardCharacter(snapshot.data);
      },
    );
  }

  _getId() {
    return _random.nextInt(592) + 1;
  }

  _layoutBody(Character character) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(child: _cardCharacter(character)),
      ],
    );
  }

  _cardCharacter(Character character) {
    return Card(
      margin: EdgeInsets.all(50),
      child: ListView(
        children: <Widget>[
          _banner(character),
          _titulo(character),
          _species(character),
          _gender(character),
          _type(character),
          _status(character),
        ],
      ),
    );
  }

  Image _banner(Character character) {
    return Image.network(
      character.image,
      height: 250,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
            height: 250,
            color: Colors.black,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  _titulo(Character character) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              '#${character.id}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Flexible(
            child: Text(
              '${character.name}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _detail(String text, IconData iconData) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(text, style: TextStyle(color: Colors.green),),
          SizedBox(width: 4,),
          Icon(iconData, color: Colors.green,),
        ],
      ),
    );
  }

  _species(Character character) {
    return _detail(character.species, Icons.person);
  }
  _gender(Character character) {
    return _detail(character.gender, Icons.group);
  }

  _type(Character character) {
    if(character.type.isEmpty)
      return Container();
    return _detail(character.type, Icons.style);
  }

  _status(Character character) {
    return _detail(character.status, Icons.track_changes);
  }

}
