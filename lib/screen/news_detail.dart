import 'package:flutter/material.dart';
import 'package:newsapp/model/news_article_model.dart';
import 'package:newsapp/widget/no_image.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/NewsDisplay';

  final Articles newsArticle;

  const NewsDetailScreen({Key? key, required this.newsArticle}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          widget.newsArticle.urlToImage == ''
              ? const NoImageWidget(isBig: true)
              : Hero(
                  tag: widget.newsArticle.title,
                  child: Image.network(widget.newsArticle.urlToImage, fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                    return const NoImageWidget(isBig: true);
                  })),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                        "${widget.newsArticle.source!.name} ${widget.newsArticle.author.isEmpty ? "" : " - " + widget.newsArticle.publishedAt}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    SelectableText(widget.newsArticle.title.split(" - ")[0],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    SelectableText(
                        widget.newsArticle.description.contains("…")
                            ? widget.newsArticle.description +
                                "\nTo know more, Visit ${widget.newsArticle.url} website."
                            : widget.newsArticle.description,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300))
                  ]))
        ])),
        bottomNavigationBar: IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              const String appTitle = 'NewsApp\n\n';
              final String msgTitle = '*${widget.newsArticle.title}*\n';
              final String msgDes = '${widget.newsArticle.description}\n';
              final String msgUrl = widget.newsArticle.url;
              Share.share(appTitle + msgTitle + msgDes + msgUrl, subject: msgTitle);
            },
            tooltip: "Share"));
  }
}
