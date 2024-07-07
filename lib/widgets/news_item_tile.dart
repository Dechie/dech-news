import 'package:dechie_news/models/news_item.dart';
import 'package:flutter/material.dart';

import '../screens/news_read_screen.dart';
import '../services/method_utils.dart';
import '../services/nav.dart';

class NewsItemTile extends StatelessWidget {
  final NewsItem item;

  const NewsItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        onTap: () {
          navigate(context, NewsReadScreen(newsItem: item));
        },
        isThreeLine: true,
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
        ),
        trailing: Hero(
          tag: item.title,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 100,
              height: 100,
              child: fetchImageWithPlaceHolder(
                item.imageUrl,
              ),
            ),
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${item.timeDifference} hours ago',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
