import 'package:flutter/material.dart';

class ContainerTextExample extends StatelessWidget {
  const ContainerTextExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      // width: 300,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 8,
          child: Container(
            height: 100,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Hello World',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                // fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
