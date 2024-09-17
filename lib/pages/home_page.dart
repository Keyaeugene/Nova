import 'package:flutter/material.dart';
import 'package:nova/components/search_box.dart';
import 'package:nova/widgets/homepage_widget.dart';
import 'package:nova/widgets/newmovies_widget.dart';
import 'package:nova/widgets/upcoming_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(context),
      body: const SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBox(),
            SizedBox(height: 30),
            UpcomingWidget(),
            SizedBox(height: 30),
            NewmoviesWidget(),
          ],
        ),
      )),
    );
  }
}
