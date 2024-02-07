import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/ideas_model.dart';

class IdeasRepository {
  Future<List<IdeasModel>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://emergingideas.ae/test_apis/read.php?email=mike.hsch@gmail.com',
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<IdeasModel> users =
            data.map((json) => IdeasModel.fromJson(json)).toList();

        return users;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> postData(IdeasModel newIdea) async {
    try {
      var map = <String, dynamic>{};
      map['title'] = newIdea.title;
      map['description'] = newIdea.description;
      map['img_link'] = newIdea.imgLink;
      map['email'] = newIdea.email;

      final response = await http.post(
        Uri.parse('https://emergingideas.ae/test_apis/create.php'),
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        fetchData();
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<void> editData({
    required int id,
    required String title,
    required String description,
    required String email,
    required String image,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://emergingideas.ae/test_apis/edit.php?id=$id&title=$title&description=$description&img_link=$image&email=$email'),
      );

      if (response.statusCode == 200) {
        fetchData();
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<void> deleteData({required int id, required String email}) async {
    try {
      final response = await http.delete(
        Uri.parse(
          'https://emergingideas.ae/test_apis/delete.php?id=$id&email=$email',
        ),
      );

      if (response.statusCode == 200) {
        fetchData();
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
