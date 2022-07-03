import 'package:flutter/material.dart';
import 'package:flutter_grundlagen/presentation/widgets_examples/container_text_example.dart';
import 'package:flutter_grundlagen/presentation/widgets_examples/media_query_example.dart';
import 'package:flutter_grundlagen/presentation/widgets_examples/page_view_example.dart';
import 'package:flutter_grundlagen/presentation/widgets_examples/profile_picture.dart';
import 'package:flutter_grundlagen/presentation/widgets_examples/row_expanded_example.dart';

class WidgetsExamplesPage extends StatelessWidget {
  const WidgetsExamplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue[500],
        title: const Text('WidgetsExample'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: const [
              ContainerTextExample(),
              SizedBox(height: 16),
              RowExpandedExample(),
              SizedBox(height: 16),
              ProfilePicture(),
              SizedBox(height: 16),
              RowExpandedExample(),
              SizedBox(height: 16),
              ProfilePicture(),
              SizedBox(height: 16),
              RowExpandedExample(),
              SizedBox(height: 16),
              MediaQueryExample(),
              SizedBox(height: 16),
              PageViewExample()
            ],
          ),
        ),
      ),
    );
  }
}
