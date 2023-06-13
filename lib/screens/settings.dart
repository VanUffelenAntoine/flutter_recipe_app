import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/CustomDrawer.dart';

import '../widgets/SettingsGroup.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        SettingsGroup(
        title: 'Theme',
        children: <Widget>[
          RadioListTile(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: EasyDynamicTheme.of(context).themeMode,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) => EasyDynamicTheme.of(context)
                .changeTheme(dynamic: false, dark: false),
          ),
          RadioListTile(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: EasyDynamicTheme.of(context).themeMode,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) => EasyDynamicTheme.of(context)
                .changeTheme(dynamic: false, dark: true),
          ),
          RadioListTile(
            title: const Text('Use device theme'),
            value: ThemeMode.system,
            groupValue: EasyDynamicTheme.of(context).themeMode,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) => EasyDynamicTheme.of(context)
                .changeTheme(dynamic: true, dark: false),
          ),
        ],
        )],
       )
      ),
      drawer: const CustomDrawer(),
    );
  }
}
