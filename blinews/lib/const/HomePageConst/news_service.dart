import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const _baseUrl = "https://hacker-news.firebaseio.com/v0";

  Future<List<Map<String, dynamic>>> fetchStories(String endpoint) async {
    final url = "$_baseUrl/$endpoint.json?print=pretty";
    try {
      final response = await http.get(Uri.parse(url));
      final List<dynamic> storyIds = jsonDecode(response.body);
      final storyIdsToFetch = storyIds.take(5).toList();
      final storyDetails =
          await Future.wait(storyIdsToFetch.map((id) => fetchStoryDetails(id)));
      return storyDetails;
    } catch (e) {
      throw Exception("Failed to fetch stories: $e");
    }
  }

  Future<Map<String, dynamic>> fetchStoryDetails(int storyId) async {
    final url = "$_baseUrl/item/$storyId.json?print=pretty";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
