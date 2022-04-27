// To parse this JSON data, do
//
//     final joke = jokeFromMap(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

Joke jokeFromMap(String str) => Joke.fromMap(json.decode(str));

String jokeToMap(Joke data) => json.encode(data.toMap());

class Joke {
  Joke({
    required this.error,
    required this.category,
    required this.type,
    required this.setup,
    required this.delivery,
    required this.flags,
    required this.safe,
    required this.id,
    required this.lang,
  });

  bool error;
  String category;
  String type;
  String setup;
  String delivery;
  Flags flags;
  bool safe;
  int id;
  String lang;

  factory Joke.fromMap(Map<String, dynamic> json) => Joke(
        error: json["error"],
        category: json["category"],
        type: json["type"],
        setup: json["setup"],
        delivery: json["delivery"],
        flags: Flags.fromMap(json["flags"]),
        safe: json["safe"],
        id: json["id"],
        lang: json["lang"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "category": category,
        "type": type,
        "setup": setup,
        "delivery": delivery,
        "flags": flags.toMap(),
        "safe": safe,
        "id": id,
        "lang": lang,
      };
}

class Flags {
  Flags({
    required this.nsfw,
    required this.religious,
    required this.political,
    required this.racist,
    required this.sexist,
    required this.explicit,
  });

  bool nsfw;
  bool religious;
  bool political;
  bool racist;
  bool sexist;
  bool explicit;

  factory Flags.fromMap(Map<String, dynamic> json) => Flags(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
      );

  Map<String, dynamic> toMap() => {
        "nsfw": nsfw,
        "political": political,
        "racist": racist,
        "religious": religious,
        "sexist": sexist,
        "explicit": explicit,
      };
}

class JokeService {
  Future<Joke> getJokeActivity() async {
    final response =
        await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any'));
    final joke = jokeFromMap(response.body);
    return joke;
  }
}
