
import 'package:flutter/material.dart';

import 'CustomDrawer.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetching data'),
        ),
        body: const Center(child: CircularProgressIndicator(),),
        drawer: const CustomDrawer());
  }
}