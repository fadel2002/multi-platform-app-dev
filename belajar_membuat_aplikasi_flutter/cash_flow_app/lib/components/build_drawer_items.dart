import 'package:flutter/material.dart';

import '../screens/all_cash_flow_screen.dart';
import '../screens/setting_screen.dart';
import '../utils/utils.dart';

Drawer buildDrawerItems(BuildContext context) {
  return Drawer(
    shape: const RoundedRectangleBorder(),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue[800],
          ),
          child: const Text(
            "Menu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text("All Cash Flow"),
          onTap: () {
            navigateAndCloseDrawer(context, const AllCashFlowScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {
            navigateAndCloseDrawer(context, const SettingScreen());
          },
        ),
      ],
    ),
  );
}