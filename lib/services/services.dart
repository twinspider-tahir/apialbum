import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apialbum/services/models.dart';
import 'package:apialbum/services/urls.dart';
import 'package:http/http.dart' as http;

class Services {
  // static Future<Post> fetchAlbum() async {
  //   final response = await http.get(Uri.parse(Urls.post));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.

  //     return Post.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  static Future<List<Post>> getProductList() async {
    print("comes");

    final response = await http.get(Uri.parse(Urls.post));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Post.fromJson(job)).toList();
  }

  static Future<Post> deletePost(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(Urls.post + '/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }

  static Future<Post> updateAlbum(String title, id) async {
    final response = await http.put(
      Uri.parse(Urls.post + '$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Post.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }
}
