import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/character.dart';

class ApiCharacter{

  static Future<Character> get(int id) async{
    final url = 'https://rickandmortyapi.com/api/character/$id';
    var response = await http.get(url);
    var map = json.decode(response.body);
    return Character.fromJson(map);
  }

}