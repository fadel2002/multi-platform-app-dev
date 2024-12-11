import 'package:flutter/material.dart';

import '../screens/all_cash_flow_screen.dart';
import '../screens/setting_screen.dart';

Drawer buildDrawerItems(BuildContext context) {
  return Drawer(
    shape: const RoundedRectangleBorder(),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text("All Cash Flow"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AllCashFlowScreen()
            ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SettingScreen()
            ));
          },
        ),
      ],
    ),
  );
}