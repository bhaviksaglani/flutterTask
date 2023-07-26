import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/second_page.dart';
import 'dart:math' as math;

import '../components/pentagon_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: 90,
        title: headerItems(context),
      ),
      drawer: Drawer(child: menuItems()),
      body: const PentagoneHeroButton(),
    );
  }
}

Widget headerItems(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        "images/robomateplus_logo.png",
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      const Icon(Icons.cloud_download),
    ],
  );
}

Widget menuItems() {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: const Text(
                'Log In',
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          // Handle menu item tap
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {
          // Handle menu item tap
        },
      ),
      // Add more menu items as needed
    ],
  );
}
