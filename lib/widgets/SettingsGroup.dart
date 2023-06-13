import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String _title;
  final List<Widget> _children;

  const SettingsGroup(
      {super.key, required String title, required List<Widget> children})
      : this._title = title,
        this._children = children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      ListTile(
      dense: true,
      leading: Text(
        _title,
      ),
    ),
    ]..addAll(_children),
    );
  }
}
