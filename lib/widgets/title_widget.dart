import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      );
}