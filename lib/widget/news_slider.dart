import 'package:flutter/material.dart';
import 'package:newsapp/model/news_article_model.dart';
import 'package:newsapp/screen/news_detail.dart';

import 'image_view.dart';
import 'no_image.dart';

class NewsSlider extends StatelessWidget {
  final Articles newsArticle;

  const NewsSlider({Key? key, required this.newsArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: InkWell(
            borderRadius: BorderRadius.circular(7),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewsDetailScreen(newsArticle: newsArticle)));
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Column(children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      child: newsArticle.urlToImage == ''
                          ? const NoImageWidget(isBig: true)
                          : SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ImageViewWidget(
                                  title: newsArticle.title, imageURL: newsArticle.urlToImage))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: Text(newsArticle.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))))
                ]))));
  }
}
