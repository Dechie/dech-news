class NewsItem {
  final String sourceName,
      author,
      title,
      description,
      imageUrl,
      publishedAt,
      content,
      newsSource;

  final int timeDifference;

  const NewsItem({
    required this.timeDifference,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
    this.newsSource = '',
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    var src = json['source']! as Map<String, dynamic>;

    // return article['title'] != null &&
    // return //article['author'] != null &&
    //     article['content'] != null && article['urlToImage'] != null;
    // //article['description'] != null;

    List titless = json['title'].split(" - ");
    var realTitle = titless.first;
    return NewsItem(
      sourceName: src['name'],
      author: json['author'] ?? "Unknown Author",
      title: realTitle,
      description: json['description'] ?? "No desc",
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'],
      timeDifference: json['timeDif'],
      content: json['content'],
    );
  }
}
