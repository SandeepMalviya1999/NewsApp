import 'package:flutter/material.dart';
import 'package:newsapp/constant/color.dart';

class NoImageWidget extends StatelessWidget {
  final bool isBig;

  const NoImageWidget({Key? key, required this.isBig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: isBig ? 200 : 100,
        width: isBig ? null : 125,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RichText(
                      text: const TextSpan(
                          text: 'News',
                          style: TextStyle(fontSize: 27, color: ColorRes.primary),
                          children: <TextSpan>[
                        TextSpan(
                            text: 'App',
                            style: TextStyle(fontWeight: FontWeight.bold, color: ColorRes.secondary))
                      ]))),
              Text("Image Not Available",
                  maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: isBig ? 20 : 15))
            ])));
  }
}
