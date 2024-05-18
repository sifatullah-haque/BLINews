import 'package:blinews/const/HomePageConst/news_portal_card.dart';
import 'package:blinews/const/HomePageConst/news_service.dart';
import 'package:blinews/pages/latest_news_list.dart';
import 'package:blinews/pages/top_news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService _newsService = NewsService();
  List<Map<String, dynamic>> topStories = [];
  List<Map<String, dynamic>> latestStories = [];
  bool isLoadingTop = true;
  bool isLoadingLatest = true;

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  Future<void> fetchStories() async {
    try {
      final topStories = await _newsService.fetchStories('topstories');
      final latestStories = await _newsService.fetchStories('newstories');

      setState(() {
        this.topStories = topStories;
        this.latestStories = latestStories;
        isLoadingTop = false;
        isLoadingLatest = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoadingTop = false;
        isLoadingLatest = false;
      });
    }
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

  Widget _buildNewsList(List<Map<String, dynamic>> stories, bool isLoading) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stories.map((story) {
          final title = story['title'] ?? 'No title';
          final author = story['by'] ?? 'Unknown';
          final timestamp = story['time'] ?? 0;
          final formattedDate = _formatUnixTimestamp(timestamp);
          final url = story['url'] ?? '';

          return Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: NewsPortalCard(
              title: title,
              author: author,
              date: formattedDate,
              url: url,
              onTap: () {
                if (url.isNotEmpty) {
                  _launchURL(url);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLI News'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top News",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TopNewslist();
                      }));
                    },
                    child: const Text("see all"),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildNewsList(topStories, isLoadingTop),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest News",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LatestNewslist();
                      }));
                    },
                    child: const Text("see all"),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildNewsList(latestStories, isLoadingLatest),
            ],
          ),
        ),
      ),
    );
  }
}
