import 'package:dechie_news/models/news_item.dart';
import 'package:dechie_news/services/api.dart';
import 'package:dechie_news/widgets/news_item_tile.dart';
import 'package:dechie_news/widgets/top_headline_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool isTopHeadline = false;

  List allNews = [];
  List filteredNews = [];
  List sources = [];

  late NewsItem headlineItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Dechie News',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sources
                        .map((elm) => Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FilledButton(
                                  onPressed: () {
                                    filterNews(elm);
                                  },
                                  child: Text(elm)),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 10),
                if (isTopHeadline) TopHeadlineWidget(newsItem: findHeadline()),
                const SizedBox(height: 10),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .8,
                        child: ListView.separated(
                          itemCount: filteredNews.length,
                          itemBuilder: (context, index) =>
                              NewsItemTile(item: filteredNews[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchItems(DateTime nowTime) async {
    var api = Api(nowTime: nowTime);

    setState(() {
      isLoading = true;
    });
    List<NewsItem> newss = [];
    //await Future.delayed(const Duration(seconds: 4));
    newss = await api.fetchNewsItems();
    allNews = newss;
    filteredNews = allNews;
    isLoading = false;
    sources.add("all");
    for (var n in allNews) {
      if (!sources.contains(n.sourceName)) {
        sources.add(n.sourceName);
      }
    }
    headlineItem = findHeadline();
    isTopHeadline = true;

    setState(() {});
  }

  void filterNews(String filter) {
    if (filter == "all") {
      filteredNews = allNews;
      setState(() {});
      return;
    }
    filteredNews = allNews.where((news) => news.sourceName == filter).toList();
    headlineItem = findHeadline();
    setState(() {});
  }

  NewsItem findHeadline() {
    List timeDiffs = filteredNews.map((news) => news.timeDifference).toList();

    timeDiffs.sort();
    var min = timeDiffs.first;
    print("diffs: $timeDiffs");
    print("min: $min");
    return allNews.firstWhere((news) => news.timeDifference == min);
  }

  @override
  void initState() {
    var nowTime = DateTime.now();
    isTopHeadline = false;
    super.initState();
    fetchItems(nowTime);
  }
}
