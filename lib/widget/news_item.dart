import 'package:flutter/material.dart';
import 'package:newsapp/model/news_article_model.dart';
import 'package:newsapp/screen/news_detail.dart';

import 'image_view.dart';
import 'no_image.dart';

class NewsItem extends StatelessWidget {
  final Articles newsArticle;

  const NewsItem({Key? key, required this.newsArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(2.0),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewsDetailScreen(newsArticle: newsArticle)));
        },
        child: SizedBox(
            height: 100,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Row(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: newsArticle.urlToImage == ''
                          ? const NoImageWidget(isBig: false)
                          : SizedBox(
                              height: 100,
                              width: 125,
                              child: ImageViewWidget(
                                  title: newsArticle.title, imageURL: newsArticle.urlToImage))),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(newsArticle.title,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Know More >",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[800])))
                              ])))
                ]))));
  }
}
