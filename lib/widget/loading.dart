import 'package:flutter/material.dart';
import 'package:newsapp/constant/color.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
            baseColor: ColorRes.darkGrey,
            highlightColor: ColorRes.lightGrey,
            enabled: true,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6, height: 15, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(7)))),
                  const SizedBox(height: 7),
                  Container(
                      width: MediaQuery.of(context).size.width - 10, height: 15, color: Colors.white),
                  const SizedBox(height: 3),
                  Container(
                      width: MediaQuery.of(context).size.width - 10, height: 15, color: Colors.white),
                  const SizedBox(height: 3),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7, height: 15, color: Colors.white),
                  const SizedBox(height: 13),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6, height: 15, color: Colors.white),
                  const SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                                width: 120.0,
                                height: 85.0,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)))),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                  Container(width: double.infinity, height: 12.0, color: Colors.white),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                                  Container(width: double.infinity, height: 12.0, color: Colors.white),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                                  Container(width: 40.0, height: 12.0, color: Colors.white)
                                ]))
                          ])))
                ])))));
  }
}
