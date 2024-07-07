import 'package:dechie_news/models/news_item.dart';
import 'package:dio/dio.dart';

class Api {
  final DateTime nowTime;

  Api({required this.nowTime});
  Future<List<NewsItem>> fetchNewsItems() async {
    //List<NewsItem> neww = [];
    List<NewsItem> articleItems = [];

    Dio dio = Dio();
    Response response;

    var url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=af37dd02c8fe4c81bc62b85f03ae31a4";
    try {
      response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> arts = response.data['articles'];
        var artics = arts.where((article) {
          // return article['title'] != null &&
          return //article['author'] != null &&
              article['content'] != null && article['urlToImage'] != null;
          //article['description'] != null;
        }).toList();
        for (var article in artics) {
          DateTime parsedDate =
              DateTime.parse(article['publishedAt'].toString());
          Duration difference = nowTime.difference(parsedDate);
          print(difference.inHours.toString());
          article['timeDif'] = difference.inHours;
          var newItem = NewsItem.fromJson(article);
          print("${newItem.sourceName} --- ${newItem.imageUrl}");
          //print(newItem.description);
          articleItems.add(newItem);
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return articleItems;
  }
}
