import 'package:dechie_news/models/news_item.dart';
import 'package:dechie_news/screens/news_read_screen.dart';
import 'package:dechie_news/services/method_utils.dart';
import 'package:dechie_news/services/nav.dart';
import 'package:flutter/material.dart';

class TopHeadlineWidget extends StatelessWidget {
  final NewsItem newsItem;

  const TopHeadlineWidget({
    super.key,
    required this.newsItem,
  });
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        navigate(context, NewsReadScreen(newsItem: newsItem));
      },
      child: Stack(
        children: [
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
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              width: maxWidth * 0.02 * 12, // letter width times ten
              height: maxHeight * 0.02 * 4, // letter height times 4
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Latest Headline',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: maxWidth * 0.02,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 10,
            child: SizedBox(
                height: 80,
                width: (maxWidth * .9) - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //overflow: TextOverflow.fade,
                      softWrap: true,
                      newsItem.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: maxWidth * 0.025,
                      ),
                    ),
                    Text(
                      '${newsItem.timeDifference} h ago \t|\t ${newsItem.sourceName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: maxWidth * 0.02,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
