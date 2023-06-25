import 'package:flutter/material.dart';
class travelArticles extends StatefulWidget {
  const travelArticles({super.key});

  @override
  State<travelArticles> createState() => _travelArticlesState();
}

class _travelArticlesState extends State<travelArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Articles"),),
    );
  }
}