import 'package:flutter/material.dart';

class PageViewExample extends StatelessWidget {
  const PageViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.3,
      child: PageView(
        controller: PageController(
          initialPage: 0,
          viewportFraction: 0.85,
        ),
        children: const [
          SinglePage(700, Colors.red),
          SinglePage(700, Colors.grey),
          SinglePage(700, Colors.blue),
        ],
      ),
    );
  }
}

class SinglePage extends StatelessWidget {
  final double width;
  final Color color;

  const SinglePage(this.width, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.3,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
