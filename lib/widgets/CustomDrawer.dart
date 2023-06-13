import 'package:flutter/material.dart';
import 'package:meal_app/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../screens/categories.dart';
import '../screens/Meals.dart';

class CustomDrawer extends StatefulWidget{
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _customDrawerState();
}

// ignore: camel_case_types
class _customDrawerState extends State<CustomDrawer>{
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build (BuildContext context){
    return  Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration:
                BoxDecoration(color: Theme.of(context).primaryColor),
                child: const Text('Navigation')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title:'Meal App'))
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Categories'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Categories())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meals'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MealsList(category: 'Beef',drawer:true))
                );
              },
            ),
            AboutListTile(
              icon: const Icon(Icons.info),
              applicationName: _packageInfo.appName,
              applicationVersion: _packageInfo.version,
              applicationLegalese: '© 2023 Antoine Van Uffelen',
              applicationIcon: const Icon(Icons.soup_kitchen),
              child: const Text('About this app'),
            ),
          ],
        ));
  }
}