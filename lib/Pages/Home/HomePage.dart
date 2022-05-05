// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  get changePage => null;

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.house, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        index: 1,
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Container(color: Colors.blueAccent),
    );
  }
}
