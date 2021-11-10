import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/animation/slide_animation_widget.dart';
import 'package:newsapp/provider/news_article_provider.dart';

import 'connectivity_error.dart';
import 'heading_div_widget.dart';
import 'news_slider.dart';
import 'news_item.dart';

class NewsListWidget extends StatelessWidget {
  final NewsArticleProvider data;
  final List<String> headings;

  const NewsListWidget({Key? key, required this.data, required this.headings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.listNewsArticle.isEmpty) {
      return const Center(child: ConnectivityError());
    } else {
      final List _mainScreenWidgets = [
        const SizedBox(height: 10),
        HeadingAndDivider(heading: headings[0]),
        CarouselSlider(
            items: [
              NewsSlider(newsArticle: data.listNewsArticle[0]),
              NewsSlider(newsArticle: data.listNewsArticle[1]),
              NewsSlider(newsArticle: data.listNewsArticle[2]),
              NewsSlider(newsArticle: data.listNewsArticle[3])
            ],
            options: CarouselOptions(
                autoPlay: true,
                height: 300,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: false)),
        const SizedBox(height: 5),
        HeadingAndDivider(heading: headings[1]),
        ListView.separated(
            separatorBuilder: (context, index) => const Divider(indent: 135, endIndent: 10),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.listNewsArticle.length - 4,
            itemBuilder: (ctx, index) => SlideAnimationWidget(
                index: index,
                itemCount: data.listNewsArticle.length - 4,
                widgetToAnimate:
                    NewsItem(newsArticle: data.listNewsArticle[index + 4])))
      ];

      return ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _mainScreenWidgets.length,
          itemBuilder: (context, index) => SlideAnimationWidget(
              index: index,
              itemCount: _mainScreenWidgets.length,
              widgetToAnimate: _mainScreenWidgets[index]));
    }
  }
}
