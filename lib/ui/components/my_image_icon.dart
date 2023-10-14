import 'package:flutter/material.dart';


class MyIconImage extends StatelessWidget {
  const MyIconImage({Key? key,required this.path,this.size = 24}) : super(key: key);
  final String path;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset(path),
    );
  }
}