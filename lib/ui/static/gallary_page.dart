import 'package:flutter/material.dart';
import 'package:leva_matrimonial/utils/assets.dart';
import 'package:leva_matrimonial/utils/labels.dart';

class GallaryPage extends StatelessWidget {
  const GallaryPage({Key? key}) : super(key: key);
  static const route = "/gallary";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Labels.gallary),
        ),
        body: ListView(
          padding: const EdgeInsets.all(4),
          children: Assets.gallaryImages
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(e),
                ),
              )
              .toList(),
        ));
  }
}
