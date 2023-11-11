// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:kutuphaneapp/Constants/constants.dart';

class ContentPage extends StatefulWidget {
  final String CategoryChapter;
  const ContentPage({super.key, required this.CategoryChapter});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.CategoryChapter.toString()),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Constants.addBook(context),
              Constants.customContainer(
                  "assets/images/image.jpg", "lorem", "ipsum", 1234, 1234)
            ],
          ),
        ),
      ),
    );
  }
}
