import 'package:flutter/material.dart';

class RowExpandedExample extends StatelessWidget {
  const RowExpandedExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            color: Colors.yellow,
            height: 100,
            width: 50,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              height: 100,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.cyan,
              height: 100,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            color: Colors.yellow,
            height: 100,
            width: 50,
          ),
        ],
      ),
    );
  }
}
