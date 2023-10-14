import 'package:flutter/material.dart';
import 'package:leva_matrimonial/utils/assets.dart';
import 'package:leva_matrimonial/utils/labels.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);
  static const route = "/board";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.dIRECTORBOARD),
      ),
      body: Image.asset(Assets.boardOfDirectors),
    );
  }
}
