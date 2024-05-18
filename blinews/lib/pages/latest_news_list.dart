import 'dart:convert';
import 'package:blinews/const/ListPageConst/news_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewslist extends StatefulWidget {
  LatestNewslist({super.key});

  @override
  State<LatestNewslist> createState() => _LatestNewslistState();
}

class _LatestNewslistState extends State<LatestNewslist> {
  List<Map<String, dynamic>> stories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopStories();
  }

  Future<void> fetchTopStories() async {
    const url =
        "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty";

    try {
      final response = await http.get(Uri.parse(url));
      final List<dynamic> storyIds = jsonDecode(response.body);

      final topStoryIds = storyIds.take(10).toList();
      final storyDetails =
          await Future.wait(topStoryIds.map((id) => fetchStoryDetails(id)));

      setState(() {
        stories = storyDetails;
        isLoading = false;
      });
    } catch (e) {
      // Handle errors
      print("Failed to fetch top stories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>> fetchStoryDetails(int storyId) async {
    final url =
        "https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty";

    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  String _formatUnixTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  final title = story['title'] ?? 'No title';
                  final author = story['by'] ?? 'Unknown';
                  final timestamp = story['time'] ?? 0;
                  final formattedDate = _formatUnixTimestamp(timestamp);
                  final url = story['url'] ?? '';

                  return NewsItem(
                    title: title,
                    author: author,
                    formattedDate: formattedDate,
                    url: url,
                    onTap: () {
                      if (url.isNotEmpty) {
                        _launchURL(url);
                      }
                    },
                  );
                },
              ),
            ),
    );
  }
}
