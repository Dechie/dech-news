import 'package:dechie_news/models/news_item.dart';
import 'package:flutter/material.dart';

import '../services/method_utils.dart';

class NewsReadScreen extends StatefulWidget {
  final NewsItem newsItem;

  const NewsReadScreen({
    super.key,
    required this.newsItem,
  });

  @override
  State<NewsReadScreen> createState() => _NewsReadScreenState();
}

class _NewsReadScreenState extends State<NewsReadScreen> {
  late NewsItem newsItem;
  String contentt = '';
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                newsItem.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '${newsItem.timeDifference} h ago \t|\t ${newsItem.sourceName}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 10),
              Hero(
                tag: newsItem.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: fetchImageWithPlaceHolder(
                    newsItem.imageUrl,
                  ),
                ),
              ),
              Hero(
                tag: newsItem.title,
                child: SizedBox(
                  width: maxWidth * .9,
                  height: maxHeight * .45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: fetchImageWithPlaceHolder(
                      newsItem.imageUrl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                contentt,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    newsItem = widget.newsItem;
    var broken = newsItem.content.split('[').first;
    for (int i = 0; i < 4; i++) {
      contentt += broken;
    }
    setState(() {});
  }
}
